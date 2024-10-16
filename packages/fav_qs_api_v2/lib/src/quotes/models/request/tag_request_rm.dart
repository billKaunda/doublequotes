import 'package:json_annotation/json_annotation.dart';

part 'tag_request_rm.g.dart';

@JsonSerializable(createFactory: false)
class TagRequestRM {
  const TagRequestRM({
    required this.tag,
  });

  final String? tag;

  Map<String, dynamic> toJson() => _$TagRequestRMToJson(this);
}
