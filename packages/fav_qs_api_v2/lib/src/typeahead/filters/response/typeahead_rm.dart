import 'package:json_annotation/json_annotation.dart';
import './author_rm.dart';
import './tag_rm.dart';
import './user_rm.dart';

part 'typeahead_rm.g.dart';

@JsonSerializable(createToJson: false)
class TypeaheadRM {
  const TypeaheadRM({
    this.authors,
    this.tags,
    this.users,
  });

  @JsonKey(name: 'authors')
  final List<AuthorRM>? authors;

  @JsonKey(name: 'tags')
  final List<TagRM>? tags;

  @JsonKey(name: 'users')
  final List<UserRM>? users;

  static const fromJson = _$TypeaheadRMFromJson;
}
