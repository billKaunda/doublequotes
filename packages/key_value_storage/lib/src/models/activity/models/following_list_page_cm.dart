import 'package:hive_local_storage/hive_local_storage.dart';
import 'following_item_cm.dart';

part 'following_list_page_cm.g.dart';

@HiveType(typeId: 5)
class FollowingListPageCM {
  const FollowingListPageCM({
    this.page,
    this.isLastPage,
    this.followingItems,
  });

  @HiveField(0)
  final int? page;

  @HiveField(1)
  final bool? isLastPage;

  @HiveField(2)
  final List<FollowingItemCM>? followingItems;
}
