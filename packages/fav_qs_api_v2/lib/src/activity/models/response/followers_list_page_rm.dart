import 'package:json_annotation/json_annotation.dart';
import './user_name_rm.dart';
import './author_rm.dart';
import './tag_rm.dart';

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
  final List<UserNameRM>? users;

  @JsonKey(name: 'authors')
  final List<AuthorRM>? authors;

  @JsonKey(name: 'tags')
  final List<TagRM>? tags;

  static const fromJson = _$FollowersListPageRMFromJson;
}
