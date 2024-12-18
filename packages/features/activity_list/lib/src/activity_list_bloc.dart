import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:domain_models/domain_models.dart';
import 'package:user_repository/user_repository.dart';
import 'package:activity_repository/activity_repository.dart';

part 'activity_list_event.dart';
part 'activity_list_state.dart';

const int _itemsPerPage = 25;

class ActivityListBloc extends Bloc<ActivityListEvent, ActivityListState> {
  ActivityListBloc({
    required UserRepository userRepository,
    required ActivityRepository activityRepository,
  })  : _activityRepository = activityRepository,
        super(
          const ActivityListState(),
        ) {
    _registerEventHandler();

    _authChangesSubscription = userRepository.createUserSession().listen(
      (user) {
        _authenticatedUsername = user?.username;
        add(
          const ActivityListUsernameObtained(),
        );
      },
    );
  }

  final ActivityRepository _activityRepository;
  late final StreamSubscription _authChangesSubscription;
  String? _authenticatedUsername;

  void _registerEventHandler() {
    on<ActivityListEvent>((event, emitter) async {
      if (event is ActivityListUsernameObtained) {
        await _handleActivityListUsernameObtained(emitter);
      } else if (event is ActivityListFailedFetchRetried) {
        await _handleActivityListFailedFetchRetried(emitter);
      } else if (event is ActivityListItemUpdated) {
        _handleActivityListItemUpdated(emitter, event);
      } else if (event is ActivityListTypeLookupChanged) {
        await _handleActivityListTypeLookupChanged(emitter, event);
      } else if (event is ActivityListSearchTermChanged) {
        await _handleActivityListSearchTermChanged(emitter, event);
      } else if (event is ActivityListRefreshed) {
        await _handleActivityListRefreshed(emitter, event);
      } else if (event is ActivityListNextPageRequested) {
        await _handleActivityListNextPageRequested(emitter, event);
      } else if (event is ActivityListItemDeleteRequest) {
        await _handleActivityListItemDeleteRequest(emitter, event);
      }
    }, transformer: (eventStream, eventHandler) {
      /*
      ---eventStream is the channel/Stream through which our events
      come in.
      ---eventHandler is the function written above which processes 
      the events.
      */

      //The where operator generates a new Stream which excludes any
      // ActivityListSearchTermChanged events.
      final nonDebounceEventStream = eventStream.where(
        (event) => event is! ActivityListSearchTermChanged,
      );

      //Debounce search events. The whereType operator here generates
      // a new Stream which excludes all but the QuoteListSearchTermChanged
      // events.
      final debounceEventStream = eventStream
          .whereType<ActivityListSearchTermChanged>()
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
            previousFilter is ActivityListFilterBySearchTerm
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
      final restartableTransformer = restartable<ActivityListEvent>();
      return restartableTransformer(mergedEventStream, eventHandler);
    });
  }

  //ActivityListUsernameObtained event is fired from the constructor
  // when a user first opens the screen and you've retrieved their
  // username or null, or when the user signs in or out at a later
  // time.
  Future<void> _handleActivityListUsernameObtained(Emitter emitter) {
    //Use the emitter to set the UI back to its initial state-with a
    // full screen loading indicator- while keeping any filters the
    // user might have selected, e.g, a tag
    emitter(
      ActivityListState(
        filter: state.filter,
      ),
    );

    //Call the _fetchQuotePage function to get a new Stream that
    // you can subscribe to, to get the initial page.
    final firstPageFetchStream = _fetchActivityPage(
      1,
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    );

    //Use the onEach() method of the emitter to handle subscribing to
    // the firstPageFetchStream and sending out each new state it emits
    // to the UI.
    return emitter.onEach<ActivityListState>(
      firstPageFetchStream,
      onData: emitter.call,
    );
  }

  Future<void> _handleActivityListFailedFetchRetried(Emitter emitter) {
    //Clears out the error and puts the loading indicator back on
    // the screen.
    emitter(
      state.copyWithNewError(null),
    );

    final firstPageFetchStream = _fetchActivityPage(
      1,
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    );

    return emitter.onEach<ActivityListState>(
      firstPageFetchStream,
      onData: emitter.call,
    );
  }

  void _handleActivityListItemUpdated(
    Emitter emitter,
    ActivityListItemUpdated event,
  ) {
    //Replaces the updated quote in the current state and re-emits it.
    emitter(
      state.copyWithUpdatedActivity(event.updatedActivity),
    );
  }

  Future<void> _handleActivityListTypeLookupChanged(
    Emitter emitter,
    ActivityListTypeLookupChanged event,
  ) {
    emitter(
      ActivityListState.loadingNewTypeLookup(typeLookup: event.typeLookup),
    );

    final firstPageFetchStream = _fetchActivityPage(
      1,
      /*
      If the user is 'deselecting' a typeLookup (e.g tag, or author), 
      the 'cachePreferably' fetch policy will return the cached activities. 
      However, if the user is selecting a new typeLookup, 'cachePreferably' 
      won't find any cached activity and will instead use the network.
      */
      fetchPolicy: FetchPolicy.cachePreferably,
    );

    return emitter.onEach<ActivityListState>(
      firstPageFetchStream,
      onData: emitter.call,
    );
  }

  Future<void> _handleActivityListSearchTermChanged(
    Emitter emitter,
    ActivityListSearchTermChanged event,
  ) {
    emitter(
      ActivityListState.loadingNewSearchTerm(
        searchTerm: event.searchTerm,
      ),
    );

    final firstPageFetchStream = _fetchActivityPage(
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

    return emitter.onEach<ActivityListState>(
      firstPageFetchStream,
      onData: emitter.call,
    );
  }

  Future<void> _handleActivityListRefreshed(
    Emitter emitter,
    ActivityListRefreshed event,
  ) {
    final firstPageFetchStream = _fetchActivityPage(
      1,
      /*
      Because the user is asking for a refresh, he doesn't want to 
      get cached quotes, thus 'networkOnly' fetch makes the sense.
      */
      fetchPolicy: FetchPolicy.networkOnly,
      isRefresh: true,
    );

    return emitter.onEach<ActivityListState>(
      firstPageFetchStream,
      onData: emitter.call,
    );
  }

  Future<void> _handleActivityListNextPageRequested(
    Emitter emitter,
    ActivityListNextPageRequested event,
  ) {
    emitter(
      state.copyWithNewError(null),
    );

    final nextPageFetchStream = _fetchActivityPage(
      event.pageNumber,
      /*
      The 'networkPreferably' fetch policy prioritizes fetching the 
      new page from the server, and if it fails, try grabbing from 
      the cache.
      */
      fetchPolicy: FetchPolicy.networkPreferably,
    );
    return emitter.onEach<ActivityListState>(
      nextPageFetchStream,
      onData: emitter.call,
    );
  }

  Future<void> _handleActivityListItemDeleteRequest(
    Emitter emitter,
    ActivityListItemDeleteRequest event,
  ) async {
    try {
      await _activityRepository.deleteActivity(event.activityId);

      /*
      Since the user is actually removing an activity from the list, you
      need to refresh the entire list to ensure that you don't break
      pagination
    */
      emitter(
        ActivityListState(filter: state.filter),
      );

      final firstPageFetchStream = _fetchActivityPage(
        1,
        fetchPolicy: FetchPolicy.networkOnly,
      );

      return emitter.onEach<ActivityListState>(
        firstPageFetchStream,
        onData: emitter.call,
      );
    } catch (error) {
      /*
      If an error occurs when trying to delete a quote, attach
      the error to the current state which will result in displaying
      a snackbar to the user and possibly taking him to the Sign In 
      screen in case he is signed out.
      */
      emitter(
        state.copyWithDeleteActivityError(error),
      );
    }
  }
  /*
  Future<void> _handleActivityListItemFollowToggled(
    Emitter emitter,
    ActivityListItemFollowToggled event,
  ) async {
    try {
      //Retrieve the currently applied filter, which can be a search
      // filter or a typeLookup filter.
      final currentlyAppliedFilter = state.filter;

      // The follow() and unfollow() methods return
      // you the updated quote object.

      if (event is ActivityListItemFollowed) {
        if (currentlyAppliedFilter is ActivityListFilterByTypeLookup &&
            currentlyAppliedFilter.searchTerm.isNotEmpty) {
          switch (currentlyAppliedFilter.typeLookup) {
            case TypeLookup.author:
              await _activityRepository.follow(
                  author: currentlyAppliedFilter.searchTerm);
              break;
            case TypeLookup.tag:
              await _activityRepository.follow(
                  tag: currentlyAppliedFilter.searchTerm);
              break;
            case TypeLookup.user:
              await _activityRepository.follow(
                  username: currentlyAppliedFilter.searchTerm);
              break;
          }
        }
      } else {
        if (currentlyAppliedFilter is ActivityListFilterByTypeLookup &&
            currentlyAppliedFilter.searchTerm.isNotEmpty) {
          switch (currentlyAppliedFilter.typeLookup) {
            case TypeLookup.author:
              await _activityRepository.unfollow(
                  author: currentlyAppliedFilter.searchTerm);
              break;
            case TypeLookup.tag:
              await _activityRepository.unfollow(
                  tag: currentlyAppliedFilter.searchTerm);
              break;
            case TypeLookup.user:
              await _activityRepository.unfollow(
                  username: currentlyAppliedFilter.searchTerm);
              break;
          }
        }
      }
      /*
      final updatedActivity = await (
        event is ActivityListItemFollowed
            ? _activityRepository.follow(
                event.quoteId,
              )
            : _activityRepository.unfollow(
                event.quoteId,
              ),
      );
      */
      final isFilteringByFavorites = state.filter is QuoteListFilterByFavorites;

      //If the user isn't filtering by favorites, you just replace the
      //changed quote on-screen.
      if (!isFilteringByFavorites) {
        emitter(
          state.copyWithUpdatedQuote(updatedQuote),
        );
      } else {
        /*
        If the user is filtering by favorites, that means the user is 
        actually removing a quote from the list. Therefore, you need to 
        refresh the entire list to ensure that you don't break pagination
        */
        emitter(
          QuoteListState(filter: state.filter),
        );
      }

      final firstPageFetchStream = _fetchActivityPage(
        1,
        fetchPolicy: FetchPolicy.networkOnly,
      );

      await emitter.onEach<ActivityListState>(
        firstPageFetchStream,
        onData: emitter.call,
      );
    } catch (error) {
      /*
      If an error occurs when trying to (un)favorite a quote, attach
      the error to the current state which will result in displaying
      a snackbar to the user and possibly taking him to the Sign In 
      screen in case he is signed out.
      */
      emitter(
        state.copyWithFavoriteToggleError(error),
      );
    }
  }
  */

  //This utility function fetches a given page
  Stream<ActivityListState> _fetchActivityPage(
    int page, {
    required FetchPolicy fetchPolicy,
    bool isRefresh = false,
  }) async* {
    //Retrieve the currently applied filter, which can be a search
    // filter or a typeLookup filter.
    final currentlyAppliedFilter = state.filter;

    final isUserSignedIn = _authenticatedUsername != null;

    //Fetch the page
    final pageStream = _activityRepository.getActivitiesListPage(
      policy: fetchPolicy,
      page: page,
      searchTerm: currentlyAppliedFilter is ActivityListFilterBySearchTerm
          ? currentlyAppliedFilter.searchTerm
          : '',
      tag: currentlyAppliedFilter is ActivityListFilterByTypeLookup &&
              currentlyAppliedFilter.typeLookup == TypeLookup.tag &&
              currentlyAppliedFilter.searchTerm.isNotEmpty
          ? currentlyAppliedFilter.searchTerm
          : null,
      author: currentlyAppliedFilter is ActivityListFilterByTypeLookup &&
              currentlyAppliedFilter.typeLookup == TypeLookup.author &&
              currentlyAppliedFilter.searchTerm.isNotEmpty
          ? currentlyAppliedFilter.searchTerm
          : null,
      username: currentlyAppliedFilter is ActivityListFilterByTypeLookup &&
              currentlyAppliedFilter.typeLookup == TypeLookup.user &&
              currentlyAppliedFilter.searchTerm.isNotEmpty
          ? currentlyAppliedFilter.searchTerm
          : null,
    );

    try {
      // Listen to the stream you got from the activity repository by
      // using the await for syntax.
      await for (final newPage in pageStream) {
        final newItemList = newPage.activities ?? [];
        final oldItemList = state.itemList ?? [];

        //For every new page you get, append the new items to
        // the old ones already on the screen. This is assuming
        // the user isn't trying to refresh the page, which will
        // necessitate replacing the previous items.
        final completeList =
            isRefresh || page == 1 ? newItemList : (oldItemList + newItemList);

        final nextPage =
            newPage.activities!.length < _itemsPerPage ? null : page + 1;

        //yield a new QuoteListState containing all the data you
        // got from the repository
        yield ActivityListState.success(
          nextPage: nextPage,
          itemList: completeList,
          filter: currentlyAppliedFilter,
          isRefresh: isRefresh,
        );
      }
    } catch (error) {
      //Handle errors if you can't get a new page for some reason
      //such as the user not having an internet connection

      if (error is ActivityNotFound) {
        yield ActivityListState.noItemsFound(
          filter: currentlyAppliedFilter,
        );
      }

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

  //Dispose the authChangesSubscription created when the screen
  // is closed. It ensure that the subscription won't remain active
  // after the user closes the screen
  @override
  Future<void> close() {
    _authChangesSubscription.cancel();
    return super.close();
  }
}
