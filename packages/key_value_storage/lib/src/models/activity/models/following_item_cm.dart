import 'package:hive/hive.dart';

part 'following_item_cm.g.dart';

@HiveType(typeId: 4)
class FollowingItemCM {
  const FollowingItemCM({
    required this.followingType,
    this.followingId,
    this.followingValue,
  });

  @HiveField(0)
  final String followingType;

  @HiveField(1)
  final String? followingId;

  @HiveField(2)
  final String? followingValue;

}
