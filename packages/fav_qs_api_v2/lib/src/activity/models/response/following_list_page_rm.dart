import 'package:json_annotation/json_annotation.dart';
import 'following_item_rm.dart';

part 'following_list_page_rm.g.dart';

@JsonSerializable(createToJson: false)
class FollowingListPageRM {
  const FollowingListPageRM({
    this.page,
    this.isLastPage,
    this.followingItems,
  });

  @JsonKey(name: 'page')
  final int? page;

  @JsonKey(name: 'last_page')
  final bool? isLastPage;

  @JsonKey(name: 'following')
  final List<FollowingItemRM>? followingItems;

  static const fromJson = _$FollowingListPageRMFromJson;
}
