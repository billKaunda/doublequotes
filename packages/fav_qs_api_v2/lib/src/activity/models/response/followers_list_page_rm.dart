import 'package:json_annotation/json_annotation.dart';

part 'followers_list_page_rm.g.dart';

@JsonSerializable(createToJson: false)
class FollowersListPageRM {
  const FollowersListPageRM({
    this.page,
    this.isLastPage,
    this.users,
    this.authors,
    this.tags,
  });

  @JsonKey(name: 'page')
  final int? page;

  @JsonKey(name: 'last_page')
  final bool? isLastPage;

  @JsonKey(name: 'users')
  final List<String>? users;

  @JsonKey(name: 'authors')
  final List<String>? authors;

  @JsonKey(name: 'tags')
  final List<String>? tags;

  static const fromJson = _$FollowersListPageRMFromJson;
}
