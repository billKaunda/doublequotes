import 'package:json_annotation/json_annotation.dart';

part 'personal_tag_rm.g.dart';

@JsonSerializable(createToJson: false)
class PersonalTagRM {
  const PersonalTagRM({
    this.personalTag,
  });

  final String? personalTag;

  static const fromJson = _$PersonalTagRMFromJson;
}
