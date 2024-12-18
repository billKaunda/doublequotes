import 'package:json_annotation/json_annotation.dart';

part 'dialogue_line_rm.g.dart';

@JsonSerializable(createToJson: false)
class DialogueLineRM {
  const DialogueLineRM({
    required this.author,
    required this.body,
  });

  @JsonKey(name: 'author')
  final String author;

  @JsonKey(name: 'body')
  final String body;

  static const fromJson = _$DialogueLineRMFromJson;
}
