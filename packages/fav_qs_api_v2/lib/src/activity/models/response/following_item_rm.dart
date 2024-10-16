import 'package:json_annotation/json_annotation.dart';

part 'following_item_rm.g.dart';

@JsonSerializable(createToJson: false)
class FollowingItemRM {
  const FollowingItemRM({
    required this.followingType,
    this.followingId,
    this.followingValue,
  });

  @JsonKey(name: 'following_type')
  final String followingType;

  @JsonKey(name: 'following_id')
  final String? followingId;

  @JsonKey(name: 'following_value')
  final String? followingValue;

  static const fromJson = _$FollowingItemRMFromJson;
}
