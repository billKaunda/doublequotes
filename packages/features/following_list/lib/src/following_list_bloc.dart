import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:domain_models/domain_models.dart';
import 'package:user_repository/user_repository.dart';
import 'package:activity_repository/activity_repository.dart';

part 'following_list_event.dart';
part 'following_list_state.dart';

class FollowingListBloc extends Bloc<FollowingListEvent, FollowingListState> {
  FollowingListBloc({
    required UserRepository userRepository,
    required ActivityRepository activityRepository,
  })  : _activityRepository = activityRepository,
        super(
          const FollowingListState(),
        ) {
    _registerEventHandler();

    _authChangesSubscription = userRepository.createUserSession().listen(
      (user) {
        _authenticatedUsername = user?.username;
        add(
          const FollowingListUsernameObtained(),
        );
      },
    );
  }

  final ActivityRepository _activityRepository;
  late final StreamSubscription _authChangesSubscription;
  String? _authenticatedUsername;

  void _registerEventHandler() {
    on<FollowingListEvent>((event, emitter) async {
      if (event is FollowingListUsernameObtained) {
        await _handleFollowingListUsernameObtained(emitter);
      } else if (event is FollowingListFailedFetchRetried) {
        await _handleFollowingListFailedFetchRetried(emitter);
      } else if (event is FollowingListItemUpdated) {
        _handleFollowingListItemUpdated(emitter, event);
      } else if (event is FollowingListFilterByUsernameToggled) {
        await _handleFollowingListFilterByUsernameToggled(emitter, event);
      } else if (event is FollowingListSearchTermChanged) {
        await _handleFollowingListSearchTermChanged(emitter, event);
      } else if (event is FollowingListRefreshed) {
        await _handleFollowingListRefreshed(emitter, event);
      } else if (event is FollowingListNextPageRequested) {
        await _handleFollowingListNextPageRequested(emitter, event);
      } else if (event is FollowingListItemFollowToggled) {
        await _handleFollowingListItemFollowToggled(emitter, event);
      }
    }, transformer: (eventStream, eventHandler) {
      /*
      ---eventStream is the channel/Stream through which our events
      come in.
      ---eventHandler is the function written above which processes 
      the events.
      */

      //The where operator generates a new Stream which excludes any
      // FollowingListSearchTermChanged events.
      final nonDebounceEventStream = eventStream.where(
        (event) => event is! FollowingListSearchTermChanged,
      );

      //Debounce search events. The whereType operator here generates
      // a new Stream which excludes all but the QuoteListSearchTermChanged
      // events.
      final debounceEventStream = eventStream
          .whereType<FollowingListSearchTermChanged>()
          .debounceTime(
            const Duration(seconds: 1),
          )
          /*
          Skip searches where the term entered by the user is equal to 
          the term of the search already on display. This can happen, for
          instance when a user types a letter in the search bar, then
          regrets it and deletes it within 1sec.
          Without applying this where operator, this would trigger another
          request although the search term hasn't changed
          */
          .where((event) {
        final previousFilter = state.filter;
        final previousSearchTerm =
            previousFilter is FollowingListFilterBySearchTerm
                ? previousFilter.searchTerm
                : '';

        return event.searchTerm != previousSearchTerm;
      });

      //Merge the two Streams back together.
      final mergedEventStream = MergeStream([
        nonDebounceEventStream,
        debounceEventStream,
      ]);

      //Apply the canceling effect by discarding in-progress event if
      // a new one comes in.

      /*
      restartable function, coming from the bloc_concurrency package,
      is the one that has the desired canceling effect. The package
      also provide a few different options as well.

      restartable function actually returns another function. Return
      the results from that function by passing them to your 
      mergedEventStream and eventHandler
      */
      final restartableTransformer = restartable<FollowingListEvent>();
      return restartableTransformer(mergedEventStream, eventHandler);
    });
  }

  //ActivityListUsernameObtained event is fired from the constructor
  // when a user first opens the screen and you've retrieved their
  // username or null, or when the user signs in or out at a later
  // time.
  Future<void> _handleFollowingListUsernameObtained(Emitter emitter) {
    //Use the emitter to set the UI back to its initial state-with a
    // full screen loading indicator- while keeping the user filters if
    // it has been selected
    emitter(
      FollowingListState(
        filter: state.filter,
      ),
    );

    //Call the _fetchQuotePage function to get a new Stream that
    // you can subscribe to, to get the initial page.
    final firstPageFetchStream = _fetchFollowingPage(
      1,
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    );

    //Use the onEach() method of the emitter to handle subscribing to
    // the firstPageFetchStream and sending out each new state it emits
    // to the UI.
    return emitter.onEach<FollowingListState>(
      firstPageFetchStream,
      onData: emitter.call,
    );
  }

  Future<void> _handleFollowingListFailedFetchRetried(Emitter emitter) {
    //Clears out the error and puts the loading indicator back on
    // the screen.
    emitter(
      state.copyWithNewError(null),
    );

    final firstPageFetchStream = _fetchFollowingPage(
      1,
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    );

    return emitter.onEach<FollowingListState>(
      firstPageFetchStream,
      onData: emitter.call,
    );
  }

  void _handleFollowingListItemUpdated(
    Emitter emitter,
    FollowingListItemUpdated event,
  ) {
    //Replaces the updated following item in the current state
    //and re-emits it.
    emitter(
      state.copyWithUpdatedFollowingItem(event.updatedItem),
    );
  }

  Future<void> _handleFollowingListFilterByUsernameToggled(
    Emitter emitter,
    FollowingListFilterByUsernameToggled event,
  ) {
    emitter(
      FollowingListState.loadingFilterByUsername(user: event.user),
    );

    final firstPageFetchStream = _fetchFollowingPage(
      1,
      /*
      If the user is 'deselecting' a typeLookup (e.g tag, or author), 
      the 'cachePreferably' fetch policy will return the cached activities. 
      However, if the user is selecting a new typeLookup, 'cachePreferably' 
      won't find any cached activity and will instead use the network.
      */
      fetchPolicy: FetchPolicy.cachePreferably,
    );

    return emitter.onEach<FollowingListState>(
      firstPageFetchStream,
      onData: emitter.call,
    );
  }

  Future<void> _handleFollowingListSearchTermChanged(
    Emitter emitter,
    FollowingListSearchTermChanged event,
  ) {
    emitter(
      FollowingListState.loadingNewSearchTerm(
        searchTerm: event.searchTerm,
      ),
    );

    final firstPageFetchStream = _fetchFollowingPage(
      1,
      /*
      If the user is 'clearing out' the seach bar, the 
      'cachePreferably' fetch policy will return the cached quotes.
      However, if the user is entering a new search, 
      'cachePreferably' won't find anything and will opt to 
      network.
      */
      fetchPolicy: FetchPolicy.cachePreferably,
    );

    return emitter.onEach<FollowingListState>(
      firstPageFetchStream,
      onData: emitter.call,
    );
  }

  Future<void> _handleFollowingListRefreshed(
    Emitter emitter,
    FollowingListRefreshed event,
  ) {
    final firstPageFetchStream = _fetchFollowingPage(
      1,
      /*
      Because the user is asking for a refresh, he doesn't want to 
      get cached quotes, thus 'networkOnly' fetch makes the sense.
      */
      fetchPolicy: FetchPolicy.networkOnly,
      isRefresh: true,
    );

    return emitter.onEach<FollowingListState>(
      firstPageFetchStream,
      onData: emitter.call,
    );
  }

  Future<void> _handleFollowingListNextPageRequested(
    Emitter emitter,
    FollowingListNextPageRequested event,
  ) {
    emitter(
      state.copyWithNewError(null),
    );

    final nextPageFetchStream = _fetchFollowingPage(
      event.pageNumber,
      /*
      The 'networkPreferably' fetch policy prioritizes fetching the 
      new page from the server, and if it fails, try grabbing from 
      the cache.
      */
      fetchPolicy: FetchPolicy.networkPreferably,
    );
    return emitter.onEach<FollowingListState>(
      nextPageFetchStream,
      onData: emitter.call,
    );
  }

  Future<void> _handleFollowingListItemFollowToggled(
    Emitter emitter,
    FollowingListItemFollowToggled event,
  ) async {
    try {
      // The follow() and unfollow() methods return
      // you the updated following item object.

      final isFilteringByUsername =
          state.filter is FollowingListFilterByUsername;

      /*
        If the user isn't filtering by username, that means the user is 
        actually removing a FollowingItem object from the list. Therefore,
        you need to refresh the entire list to ensure that you 
        don't break pagination
      */
      if (!isFilteringByUsername) {
        emitter(
          FollowingListState(filter: state.filter),
        );
      } else {
        //If the user is filtering by username, you just replace the
        //changed quote on-screen.
        emitter(
          //TODO Passed in argument doesn't match the function's parameter type (FollowingItem)
          state.copyWithUpdatedFollowingItem(null),
        );
      }

      final firstPageFetchStream = _fetchFollowingPage(
        1,
        fetchPolicy: FetchPolicy.networkOnly,
      );

      await emitter.onEach<FollowingListState>(
        firstPageFetchStream,
        onData: emitter.call,
      );
    } catch (error) {
      /*
      If an error occurs when trying to (un)hide a quote, attach
      the error to the current state which will result in displaying
      a snackbar to the user and possibly taking him to the Sign In 
      screen in case he is signed out.
      */
      emitter(
        state.copyWithFollowToggleError(error),
      );
    }
  }

  Future<void> _handleFollowUnfollow(
    FollowingListItemFollowToggled event,
  ) async {
    // Decide whether to call follow or unfollow based on event type
    Future<void> Function({
      String? author,
      String? tag,
      String? username,
    }) action;

    if (event is FollowingListItemFollowed) {
      action = _activityRepository.follow;
    } else {
      action = _activityRepository.unfollow;
    }

    // Perform the action based on followingType
    switch (event.followingType) {
      case 'Author':
        return await action(author: event.followingId);
      case 'Tag':
        return await action(tag: event.followingId);
      case 'User':
        return await action(username: event.followingId);
      default:
        return;
    }
  }

  //This utility function fetches a given page
  Stream<FollowingListState> _fetchFollowingPage(
    int page, {
    required FetchPolicy fetchPolicy,
    bool isRefresh = false,
  }) async* {
    //Retrieve the currently applied filter, which can be a search
    // filter or a typeLookup filter.
    final currentlyAppliedFilter = state.filter;

    final isUserSignedIn = _authenticatedUsername != null;

    final isFilteringByUsername =
        currentlyAppliedFilter is FollowingListFilterByUsername;

    if (!isUserSignedIn && (isFilteringByUsername)) {
      yield FollowingListState.noItemsFound(
        filter: currentlyAppliedFilter,
      );
    } else {
      //Fetch the page
      final pageStream = _activityRepository.getFollowingListPage(
        policy: fetchPolicy,
        page: page,
        username: currentlyAppliedFilter is FollowingListFilterByUsername &&
                currentlyAppliedFilter.user == TypeLookup.user &&
                currentlyAppliedFilter.searchTerm.isNotEmpty
            ? currentlyAppliedFilter.searchTerm
            : null,
      );

      try {
        // Listen to the stream you got from the activity repository by
        // using the await for syntax.
        await for (final newPage in pageStream) {
          final newItemList = newPage.followingItems ?? [];
          final oldItemList = state.itemList ?? [];

          //For every new page you get, append the new items to
          // the old ones already on the screen. This is assuming
          // the user isn't trying to refresh the page, which will
          // necessitate replacing the previous items.
          final completeList = isRefresh || page == 1
              ? newItemList
              : (oldItemList + newItemList);

          final nextPage = newPage.isLastPage! ? null : page + 1;

          //yield a new QuoteListState containing all the data you
          // got from the repository
          yield FollowingListState.success(
            nextPage: nextPage,
            itemList: completeList,
            filter: currentlyAppliedFilter,
            isRefresh: isRefresh,
          );
        }
      } catch (error) {
        //If error occured during a refresh request, notify the user
        //of it using a snackbar and if it is an unexpected error,
        // just re-emit the current state with an error added to it.
        if (isRefresh) {
          yield state.copyWithNewRefreshError(
            error,
          );
        } else {
          yield state.copyWithNewError(error);
        }
      }
    }
  }

  //Dispose the authChangesSubscription created when the screen
  // is closed. It ensure that the subscription won't remain active
  // after the user closes the screen
  @override
  Future<void> close() {
    _authChangesSubscription.cancel();
    return super.close();
  }
}
