import 'package:hive_local_storage/hive_local_storage.dart';

part 'user_details_cm.g.dart';

@HiveType(typeId: 10)
class UserDetailsCM {
  const UserDetailsCM({
    this.isFavorite,
    this.isUpvoted,
    this.isDownvoted,
    this.isHidden,
    this.personalTags,
  });

  @HiveField(0)
  final bool? isFavorite;

  @HiveField(1)
  final bool? isUpvoted;

  @HiveField(2)
  final bool? isDownvoted;

  @HiveField(3)
  final bool? isHidden;

  @HiveField(4)
  final List<String>? personalTags;

}
