part of 'following_list_bloc.dart';

class FollowingListState extends Equatable {
  const FollowingListState({
    this.itemList,
    this.nextPage,
    this.error,
    this.filter,
    this.refreshError,
    this.followToggleError,
  });

  //Holds all of the items from the pages you have loaded so far
  final List<FollowingItem>? itemList;

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
  //Can either be a user typeFilter('FollowingListFilterByUsername'), or searchTerm
  //filter ('FollowingListFilterBySearchTerm').
  final FollowingListFilter? filter;

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

  //Auxilliary constructor that facilitates building the state for
  // when the app is loading a type (user) change.
  FollowingListState.loadingFilterByUsername({
    required TypeLookup? user,
  }) : this(
          filter: user != null ? FollowingListFilterByUsername('', user) : null,
        );

  //Auxilliary constructor that facilitates building the state for
  // when the app is loading a search change
  FollowingListState.loadingNewSearchTerm({
    required String searchTerm,
  }) : this(
          filter: searchTerm.isEmpty
              ? null
              : FollowingListFilterBySearchTerm(searchTerm),
        );

  //Auxilliary constructor which facilitates building the state for
  // when the app couldn't find any items for the selected filter.
  const FollowingListState.noItemsFound({
    required FollowingListFilter? filter,
  }) : this(
          itemList: const [],
          error: null,
          nextPage: 1,
          filter: filter,
        );

  //Auxilliary constructor which facilitates building the state for
  // the app when a new page has been loaded successfully
  const FollowingListState.success({
    required int? nextPage,
    required List<FollowingItem> itemList,
    required FollowingListFilter? filter,
    required bool isRefresh,
  }) : this(
          nextPage: nextPage,
          itemList: itemList,
          filter: filter,
        );

  //Auxilliary function that creates a copy of the current state with
  // a new value for the [error] property.
  FollowingListState copyWithNewError(
    dynamic error,
  ) =>
      FollowingListState(
        itemList: itemList,
        nextPage: nextPage,
        error: error,
        filter: filter,
        refreshError: refreshError,
      );

  //Auxilliary function which creates a copy of the current state with
  // a new value for the [refreshError] property.
  FollowingListState copyWithNewRefreshError(
    dynamic refreshError,
  ) =>
      FollowingListState(
        itemList: itemList,
        nextPage: nextPage,
        error: error,
        filter: filter,
        refreshError: refreshError,
      );

  //Auxilliary function which creates a copy of the current state
  // by replacing just the [updatedFollowingItem]
  FollowingListState? copyWithUpdatedFollowingItem(
    FollowingItem? updatedItem,
  ) =>
      updatedItem == null
          ? null
          : FollowingListState(
              itemList: itemList?.map((item) {
                if (item.followingId == updatedItem.followingId) {
                  return updatedItem;
                } else {
                  return item;
                }
              }).toList(),
              nextPage: nextPage,
              error: error,
              filter: filter,
              refreshError: null,
              followToggleError: null,
            );

  //Auxilliary function which creates a copy of the current state
  // with a new value for the [followToggleError] property.
  FollowingListState copyWithFollowToggleError(
    dynamic followToggleError,
  ) =>
      FollowingListState(
        itemList: itemList,
        nextPage: nextPage,
        error: error,
        filter: filter,
        refreshError: refreshError,
        followToggleError: followToggleError,
      );

  PagingState<int, FollowingItem> toPagingState({
    int? nextPageKey,
    List<FollowingItem>? itemList,
    dynamic error,
  }) {
    return PagingState<int, FollowingItem>(
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
      ];
}

abstract class FollowingListFilter extends Equatable {
  const FollowingListFilter();

  @override
  List<Object?> get props => [];
}

class FollowingListFilterBySearchTerm extends FollowingListFilter {
  const FollowingListFilterBySearchTerm(this.searchTerm);

  final String searchTerm;

  @override
  List<Object?> get props => [
        searchTerm,
      ];
}

class FollowingListFilterByUsername extends FollowingListFilterBySearchTerm {
  const FollowingListFilterByUsername(
    super.searchTerm,
    this.user,
  );

  final TypeLookup user;

  @override
  List<Object?> get props => [
        user,
      ];
}
