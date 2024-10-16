import 'package:json_annotation/json_annotation.dart';
import './filter_details_rm.dart';

part 'tag_rm.g.dart';

@JsonSerializable(createToJson: false)
class TagRM {
  const TagRM({
    required this.details,
  });

  final FilterDetailsRM details;

  static const fromJson = _$TagRMFromJson;
}