import 'package:json_annotation/json_annotation.dart';

part 'tag_rm.g.dart';

@JsonSerializable(createToJson: false)
class TagRM {
  const TagRM({
    required this.tag,
  });

  final String? tag;

  static const fromJson = _$TagRMFromJson;
}
