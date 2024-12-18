part of 'followers_list_bloc.dart';

class FollowersListState extends Equatable {
  const FollowersListState({
    this.itemList,
    this.nextPage,
    this.error,
    this.filter,
    this.refreshError,
  });

  //Holds all of the items from the pages you have loaded so far
  final List<FollowersListPage>? itemList;

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
  //Can either be a typeFilter('FollowersListFilterByType'), or searchTerm
  //filter ('FollowersListFilterBySearchTerm').
  final FollowersListFilter? filter;

  //Indicates an error occured when trying to refresh the list
  //
  // Used to display a snackbar to indicate the failure
  final dynamic refreshError;

  //Auxilliary constructor that facilitates building the state for
  // when the app is loading a type (author, tag, user) change.
  FollowersListState.loadingNewTypeLookup({
    required TypeLookup? typeLookup,
  }) : this(
          filter: typeLookup != null
              ? FollowersListFilterByTypeLookup('', typeLookup)
              : null,
        );

  //Auxilliary constructor that facilitates building the state for
  // when the app is loading a search change
  FollowersListState.loadingNewSearchTerm({
    required String searchTerm,
  }) : this(
          filter: searchTerm.isEmpty
              ? null
              : FollowersListFilterBySearchTerm(searchTerm),
        );

  //Auxilliary constructor which facilitates building the state for
  // when the app couldn't find any items for the selected filter.
  const FollowersListState.noItemsFound({
    required FollowersListFilter? filter,
  }) : this(
          itemList: const [],
          error: null,
          nextPage: 1,
          filter: filter,
        );

  //Auxilliary constructor which facilitates building the state for
  // the app when a new page has been loaded successfully
  const FollowersListState.success({
    required int? nextPage,
    required List<FollowersListPage> itemList,
    required FollowersListFilter? filter,
    required bool isRefresh,
  }) : this(
          nextPage: nextPage,
          itemList: itemList,
          filter: filter,
        );

  //Auxilliary function that creates a copy of the current state with
  // a new value for the [error] property.
  FollowersListState copyWithNewError(
    dynamic error,
  ) =>
      FollowersListState(
        itemList: itemList,
        nextPage: nextPage,
        error: error,
        filter: filter,
        refreshError: refreshError,
      );

  //Auxilliary function which creates a copy of the current state with
  // a new value for the [refreshError] property.
  FollowersListState copyWithNewRefreshError(
    dynamic refreshError,
  ) =>
      FollowersListState(
        itemList: itemList,
        nextPage: nextPage,
        error: error,
        filter: filter,
        refreshError: refreshError,
      );

  PagingState<int, String> toPagingState({
    int? nextPageKey,
    List<String>? itemList,
    dynamic error,
  }) {
    return PagingState<int, String>(
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

abstract class FollowersListFilter extends Equatable {
  const FollowersListFilter();

  @override
  List<Object?> get props => [];
}

class FollowersListFilterBySearchTerm extends FollowersListFilter {
  const FollowersListFilterBySearchTerm(this.searchTerm);

  final String searchTerm;

  @override
  List<Object?> get props => [
        searchTerm,
      ];
}

class FollowersListFilterByTypeLookup extends FollowersListFilterBySearchTerm {
  const FollowersListFilterByTypeLookup(
    super.searchTerm,
    this.typeLookup,
  );

  final TypeLookup typeLookup;

  @override
  List<Object?> get props => [
        typeLookup,
      ];
}
