part of 'followers_list_bloc.dart';

abstract class FollowersListEvent extends Equatable {
  const FollowersListEvent();

  @override
  List<Object?> get props => [];
}

class FollowersListTypeLookupChanged extends FollowersListEvent {
  const FollowersListTypeLookupChanged({
    this.typeLookup,
  });

  final TypeLookup? typeLookup;

  @override
  List<Object?> get props => [
        typeLookup,
      ];
}

class FollowersListSearchTermChanged extends FollowersListEvent {
  const FollowersListSearchTermChanged(
    this.searchTerm,
  );

  final String searchTerm;

  @override
  List<Object?> get props => [
        searchTerm,
      ];
}

class FollowersListRefreshed extends FollowersListEvent {
  const FollowersListRefreshed();
}

class FollowersListNextPageRequested extends FollowersListEvent {
  const FollowersListNextPageRequested({
    required this.pageNumber,
  });

  final int pageNumber;

  @override
  List<Object?> get props => [
        pageNumber,
      ];
}

class FollowersListFailedFetchRetried extends FollowersListEvent {
  const FollowersListFailedFetchRetried();
}


