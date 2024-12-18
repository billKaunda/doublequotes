part of 'following_list_bloc.dart';

abstract class FollowingListEvent extends Equatable {
  const FollowingListEvent();

  @override
  List<Object?> get props => [];
}

class FollowingListFilterByUsernameToggled extends FollowingListEvent {
  const FollowingListFilterByUsernameToggled({
    this.user,
  });

  final TypeLookup? user;

  @override
  List<Object?> get props => [
        user,
      ];
}

class FollowingListSearchTermChanged extends FollowingListEvent {
  const FollowingListSearchTermChanged(
    this.searchTerm,
  );

  final String searchTerm;

  @override
  List<Object?> get props => [
        searchTerm,
      ];
}

class FollowingListRefreshed extends FollowingListEvent {
  const FollowingListRefreshed();
}

class FollowingListNextPageRequested extends FollowingListEvent {
  const FollowingListNextPageRequested({
    required this.pageNumber,
  });

  final int pageNumber;

  @override
  List<Object?> get props => [
        pageNumber,
      ];
}

class FollowingListFailedFetchRetried extends FollowingListEvent {
  const FollowingListFailedFetchRetried();
}

class FollowingListUsernameObtained extends FollowingListEvent {
  const FollowingListUsernameObtained();
}

class FollowingListItemUpdated extends FollowingListEvent {
  const FollowingListItemUpdated(this.updatedItem);

  final FollowingItem updatedItem;
}

abstract class FollowingListItemFollowToggled extends FollowingListEvent {
  const FollowingListItemFollowToggled(
    this.followingType,
    this.followingId,
  );

  final String followingType;
  final String followingId;
}

class FollowingListItemFollowed extends FollowingListItemFollowToggled {
  const FollowingListItemFollowed(
    super.followingType,
    super.followingId,
  );
}

class FollowingListItemUnfollowed extends FollowingListItemFollowToggled {
  const FollowingListItemUnfollowed(
    super.followingType,
    super.followingId,
  );
}
