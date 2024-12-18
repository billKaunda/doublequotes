part of 'activity_list_bloc.dart';

class ActivityListState extends Equatable {
  const ActivityListState({
    this.itemList,
    this.nextPage,
    this.error,
    this.filter,
    this.refreshError,
    this.followToggleError,
    this.deleteActivityError,
  });

  //Holds all of the items from the pages you have loaded so far
  final List<Activity>? itemList;

  //Next page to be fetched, or return `null` if you have already
  // loaded the entire list.
  //
  //This variable also determines whether you need a loading indicator
  // at the bottom to indicate that you haven't loaded all the pages
  // yet.
  final int? nextPage;

  //Indicates that an error occured trying to fetch any page of activities.
  //
  // If both this property and [itemList] holds values, it means that
  // an error occured when trying to fetch a subsequent page. On the
  // other hand, if this property has a value but [itemList] doesn't,
  // that means the error ocurred when fetching the first page.
  final dynamic error;

  //Currenty applied filter(if any)
  //
  //Can either be a typeFilter('ActivityListFilterByType'), or searchTerm
  //filter ('ActivityListFilterBySearchTerm').
  final ActivityListFilter? filter;

  //Indicates an error occured when trying to refresh the list
  //
  // Used to display a snackbar to indicate the failure
  final dynamic refreshError;

  //Indicates that an error occured when trying to follow a quote
  //
  // Used to display a snackbar to the user indicating the failure
  // and also redirecting the user to the sign in screen in case
  // the cause of the error is the user being signed out.
  final dynamic followToggleError;

  /*
    Indicates an error occured when trying to delete a quote.

    Used to display a snackbar to the user and possibly taking him to 
    the Sign In screen in case he is signed out.
  */
  final dynamic deleteActivityError;

  //Auxilliary constructor that facilitates building the state for
  // when the app is loading a type (author, tag) change.
  ActivityListState.loadingNewTypeLookup({
    required TypeLookup? typeLookup,
  }) : this(
          filter: typeLookup != null
              ? ActivityListFilterByTypeLookup('', typeLookup)
              : null,
        );

  //Auxilliary constructor that facilitates building the state for
  // when the app is loading a search change
  ActivityListState.loadingNewSearchTerm({
    required String searchTerm,
  }) : this(
          filter: searchTerm.isEmpty
              ? null
              : ActivityListFilterBySearchTerm(searchTerm),
        );

  //Auxilliary constructor which facilitates building the state for
  // when the app couldn't find any items for the selected filter.
  const ActivityListState.noItemsFound({
    required ActivityListFilter? filter,
  }) : this(
          itemList: const [],
          error: null,
          nextPage: 1,
          filter: filter,
        );

  //Auxilliary constructor which facilitates building the state for
  // the app when a new page has been loaded successfully
  const ActivityListState.success({
    required int? nextPage,
    required List<Activity> itemList,
    required ActivityListFilter? filter,
    required bool isRefresh,
  }) : this(
          nextPage: nextPage,
          itemList: itemList,
          filter: filter,
        );

  //Auxilliary function that creates a copy of the current state with
  // a new value for the [error] property.
  ActivityListState copyWithNewError(
    dynamic error,
  ) =>
      ActivityListState(
        itemList: itemList,
        nextPage: nextPage,
        error: error,
        filter: filter,
        refreshError: refreshError,
        deleteActivityError: deleteActivityError,
      );

  //Auxilliary function which creates a copy of the current state with
  // a new value for the [refreshError] property.
  ActivityListState copyWithNewRefreshError(
    dynamic refreshError,
  ) =>
      ActivityListState(
        itemList: itemList,
        nextPage: nextPage,
        error: error,
        filter: filter,
        refreshError: refreshError,
        followToggleError: null,
        deleteActivityError: null,
      );

  //Auxilliary function which creates a copy of the current state
  // by replacing just the [updatedActivity]
  ActivityListState copyWithUpdatedActivity(
    Activity updatedActivity,
  ) =>
      ActivityListState(
        itemList: itemList?.map((activity) {
          if (activity.activityId == updatedActivity.activityId) {
            return updatedActivity;
          } else {
            return activity;
          }
        }).toList(),
        nextPage: nextPage,
        error: error,
        filter: filter,
        refreshError: null,
        followToggleError: null,
        deleteActivityError: null,
      );

  //Auxilliary function which creates a copy of the current state
  // with a new value for the [favoriteToggleError] property.
  ActivityListState copyWithFollowToggleError(
    dynamic followToggleError,
  ) =>
      ActivityListState(
        itemList: itemList,
        nextPage: nextPage,
        error: error,
        filter: filter,
        refreshError: refreshError,
        followToggleError: followToggleError,
        deleteActivityError: deleteActivityError,
      );

  ActivityListState copyWithDeleteActivityError(
    dynamic deleteActivityError,
  ) =>
      ActivityListState(
        itemList: itemList,
        nextPage: nextPage,
        error: error,
        filter: filter,
        refreshError: refreshError,
        followToggleError: followToggleError,
        deleteActivityError: deleteActivityError,
      );

  PagingState<int, Activity> toPagingState({
    int? nextPageKey,
    List<Activity>? itemList,
    dynamic error,
  }) {
    return PagingState<int, Activity>(
      itemList: itemList,
      nextPageKey: nextPage,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        itemList,
        nextPage,
        error,
        filter,
        refreshError,
        followToggleError,
      ];
}

abstract class ActivityListFilter extends Equatable {
  const ActivityListFilter();

  @override
  List<Object?> get props => [];
}

class ActivityListFilterBySearchTerm extends ActivityListFilter {
  const ActivityListFilterBySearchTerm(this.searchTerm);

  final String searchTerm;

  @override
  List<Object?> get props => [
        searchTerm,
      ];
}

class ActivityListFilterByTypeLookup extends ActivityListFilterBySearchTerm {
  const ActivityListFilterByTypeLookup(
    super.searchTerm,
    this.typeLookup,
  );

  final TypeLookup typeLookup;

  @override
  List<Object?> get props => [
        typeLookup,
      ];
}
