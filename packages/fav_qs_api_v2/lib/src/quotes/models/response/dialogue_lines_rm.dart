import 'package:json_annotation/json_annotation.dart';

part 'dialogue_lines_rm.g.dart';

@JsonSerializable(createToJson: false)
class DialogueLinesRM {
  const DialogueLinesRM({
    required this.author,
    required this.body,
  });

  @JsonKey(name: 'author')
  final String author;

  @JsonKey(name: 'body')
  final String body;

  static const fromJson = _$DialogueLinesRMFromJson;
}
