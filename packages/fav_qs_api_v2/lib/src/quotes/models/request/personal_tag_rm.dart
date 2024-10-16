import 'package:json_annotation/json_annotation.dart';

part 'personal_tag_rm.g.dart';

@JsonSerializable(createFactory: false)
class PersonalTagRM {
  const PersonalTagRM({
    this.personalTag,
  });

  final String? personalTag;

  Map<String, dynamic> toJson() => _$PersonalTagRMToJson(this);
}
