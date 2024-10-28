import 'package:hive_local_storage/hive_local_storage.dart';

part 'followers_list_page_cm.g.dart';

@HiveType(typeId: 3)
class FollowersListPageCM {
  const FollowersListPageCM({
    this.page,
    this.isLastPage,
    this.users,
    this.authors,
    this.tags,
  });

  @HiveField(0)
  final int? page;

  @HiveField(1)
  final bool? isLastPage;

  @HiveField(2)
  final List<String>? users;

  @HiveField(3)
  final List<String>? authors;

  @HiveField(4)
  final List<String>? tags;
}
