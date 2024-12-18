import 'package:json_annotation/json_annotation.dart';

part 'personal_tags_rm.g.dart';

@JsonSerializable(createFactory: false)
class PersonalTagsRM {
  const PersonalTagsRM({
    this.personalTags,
  });

  @JsonKey(name: 'personal_tags')
  final List<String>? personalTags;

  Map<String, dynamic> toJson() => _$PersonalTagsRMToJson(this);
}
