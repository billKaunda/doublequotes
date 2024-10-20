import 'package:equatable/equatable.dart';
import './following_item.dart';

class FollowingListPage extends Equatable{
  const FollowingListPage({
    this.page,
    this.isLastPage,
    this.followingItems,
  });

  final int? page;

  final bool? isLastPage;

  final List<FollowingItem>? followingItems;

  @override
  List<Object?> get props => [
        page,
        isLastPage,
        followingItems,
      ];
}
