import 'package:json_annotation/json_annotation.dart';
import './filter_details_rm.dart';

part 'typeahead_rm.g.dart';

@JsonSerializable(createToJson: false)
class TypeaheadRM {
  const TypeaheadRM({
    this.authors,
    this.tags,
    this.users,
  });

  @JsonKey(name: 'authors')
  final List<FilterDetailsRM>? authors;

  @JsonKey(name: 'tags')
  final List<FilterDetailsRM>? tags;

  @JsonKey(name: 'users')
  final List<FilterDetailsRM>? users;

  static const fromJson = _$TypeaheadRMFromJson;
}
