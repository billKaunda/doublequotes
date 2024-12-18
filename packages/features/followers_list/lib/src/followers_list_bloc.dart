import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:domain_models/domain_models.dart';
import 'package:user_repository/user_repository.dart';
import 'package:activity_repository/activity_repository.dart';

part 'followers_list_event.dart';
part 'followers_list_state.dart';


class FollowersListBloc extends Bloc<FollowersListEvent, FollowersListState> {
  FollowersListBloc({
    required UserRepository userRepository,
    required ActivityRepository activityRepository,
  })  : _activityRepository = activityRepository,
        super(
          const FollowersListState(),
        ) {
    _registerEventHandler();
  }

  final ActivityRepository _activityRepository;

  void _registerEventHandler() {
    on<FollowersListEvent>((event, emitter) async {
      if (event is FollowersListFailedFetchRetried) {
        await _handleFollowersListFailedFetchRetried(emitter);
      } else if (event is FollowersListTypeLookupChanged) {
        await _handleFollowersListTypeLookupChanged(emitter, event);
      } else if (event is FollowersListSearchTermChanged) {
        await _handleFollowersListSearchTermChanged(emitter, event);
      } else if (event is FollowersListRefreshed) {
        await _handleFollowersListRefreshed(emitter, event);
      } else if (event is FollowersListNextPageRequested) {
        await _handleFollowersListNextPageRequested(emitter, event);
      }
    }, transformer: (eventStream, eventHandler) {
      /*
      ---eventStream is the channel/Stream through which our events
      come in.
      ---eventHandler is the function written above which processes 
      the events.
      */

      //The where operator generates a new Stream which excludes any
      // FollowersListSearchTermChanged events.
      final nonDebounceEventStream = eventStream.where(
        (event) => event is! FollowersListSearchTermChanged,
      );

      //Debounce search events. The whereType operator here generates
      // a new Stream which excludes all but the QuoteListSearchTermChanged
      // events.
      final debounceEventStream = eventStream
          .whereType<FollowersListSearchTermChanged>()
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
            previousFilter is FollowersListFilterBySearchTerm
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
      final restartableTransformer = restartable<FollowersListEvent>();
      return restartableTransformer(mergedEventStream, eventHandler);
    });
  }

  Future<void> _handleFollowersListFailedFetchRetried(Emitter emitter) {
    //Clears out the error and puts the loading indicator back on
    // the screen.
    emitter(
      state.copyWithNewError(null),
    );

    final firstPageFetchStream = _fetchFollowersPage(
      1,
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    );

    return emitter.onEach<FollowersListState>(
      firstPageFetchStream,
      onData: emitter.call,
    );
  }

  Future<void> _handleFollowersListTypeLookupChanged(
    Emitter emitter,
    FollowersListTypeLookupChanged event,
  ) {
    emitter(
      FollowersListState.loadingNewTypeLookup(typeLookup: event.typeLookup),
    );

    final firstPageFetchStream = _fetchFollowersPage(
      1,
      /*
      If the user is 'deselecting' a typeLookup (e.g tag, or author), 
      the 'cachePreferably' fetch policy will return the cached activities. 
      However, if the user is selecting a new typeLookup, 'cachePreferably' 
      won't find any cached activity and will instead use the network.
      */
      fetchPolicy: FetchPolicy.cachePreferably,
    );

    return emitter.onEach<FollowersListState>(
      firstPageFetchStream,
      onData: emitter.call,
    );
  }

  Future<void> _handleFollowersListSearchTermChanged(
    Emitter emitter,
    FollowersListSearchTermChanged event,
  ) {
    emitter(
      FollowersListState.loadingNewSearchTerm(
        searchTerm: event.searchTerm,
      ),
    );

    final firstPageFetchStream = _fetchFollowersPage(
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

    return emitter.onEach<FollowersListState>(
      firstPageFetchStream,
      onData: emitter.call,
    );
  }

  Future<void> _handleFollowersListRefreshed(
    Emitter emitter,
    FollowersListRefreshed event,
  ) {
    final firstPageFetchStream = _fetchFollowersPage(
      1,
      /*
      Because the user is asking for a refresh, he doesn't want to 
      get cached quotes, thus 'networkOnly' fetch makes the sense.
      */
      fetchPolicy: FetchPolicy.networkOnly,
      isRefresh: true,
    );

    return emitter.onEach<FollowersListState>(
      firstPageFetchStream,
      onData: emitter.call,
    );
  }

  Future<void> _handleFollowersListNextPageRequested(
    Emitter emitter,
    FollowersListNextPageRequested event,
  ) {
    emitter(
      state.copyWithNewError(null),
    );

    final nextPageFetchStream = _fetchFollowersPage(
      event.pageNumber,
      /*
      The 'networkPreferably' fetch policy prioritizes fetching the 
      new page from the server, and if it fails, try grabbing from 
      the cache.
      */
      fetchPolicy: FetchPolicy.networkPreferably,
    );
    return emitter.onEach<FollowersListState>(
      nextPageFetchStream,
      onData: emitter.call,
    );
  }

  //This utility function fetches a given page
  Stream<FollowersListState> _fetchFollowersPage(
    int page, {
    required FetchPolicy fetchPolicy,
    bool isRefresh = false,
  }) async* {
    //Retrieve the currently applied filter, which can be a search
    // filter or a typeLookup filter.
    final currentlyAppliedFilter = state.filter;

    //Fetch the page
    final pageStream = _activityRepository.getFollowersListPage(
      policy: fetchPolicy,
      page: page,
      searchTerm: currentlyAppliedFilter is FollowersListFilterBySearchTerm
          ? currentlyAppliedFilter.searchTerm
          : '',
      tag: currentlyAppliedFilter is FollowersListFilterByTypeLookup &&
              currentlyAppliedFilter.typeLookup == TypeLookup.tag &&
              currentlyAppliedFilter.searchTerm.isNotEmpty
          ? currentlyAppliedFilter.searchTerm
          : null,
      author: currentlyAppliedFilter is FollowersListFilterByTypeLookup &&
              currentlyAppliedFilter.typeLookup == TypeLookup.author &&
              currentlyAppliedFilter.searchTerm.isNotEmpty
          ? currentlyAppliedFilter.searchTerm
          : null,
      username: currentlyAppliedFilter is FollowersListFilterByTypeLookup &&
              currentlyAppliedFilter.typeLookup == TypeLookup.user &&
              currentlyAppliedFilter.searchTerm.isNotEmpty
          ? currentlyAppliedFilter.searchTerm
          : null,
    );

    try {
      // Listen to the stream you got from the activity repository by
      // using the await for syntax.
      await for (final newPage in pageStream) {
        final oldItemList = state.itemList ?? [];
        final newItemList = (newPage.authors?.isNotEmpty == true
            ? newPage.authors
            : newPage.tags?.isNotEmpty == true
                ? newPage.tags
                : newPage.users?.isNotEmpty == true
                    ? newPage.users
                    : []) as List<FollowersListPage>;

        //For every new page you get, append the new items to
        // the old ones already on the screen. This is assuming
        // the user isn't trying to refresh the page, which will
        // necessitate replacing the previous items.
        final completeList =
            isRefresh || page == 1 ? newItemList : (oldItemList + newItemList);

        final nextPage = newPage.isLastPage! ? null : page + 1;

        //yield a new QuoteListState containing all the data you
        // got from the repository
        yield FollowersListState.success(
          nextPage: nextPage,
          itemList: completeList,
          filter: currentlyAppliedFilter,
          isRefresh: isRefresh,
        );
      }
    } catch (error) {
      //Handle errors if you can't get a new page for some reason
      //such as the user not having an internet connection or a typeLookup name 
      // not being found

      if (error is AuthorNotFound ||
          error is TagNotFound ||
          error is UserNotFound) {
        yield FollowersListState.noItemsFound(
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
}
