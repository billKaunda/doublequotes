import 'package:json_annotation/json_annotation.dart';

part 'dialogue_lines_request_rm.g.dart';

@JsonSerializable(createFactory: false)
class DialogueLinesRequestRM {
  const DialogueLinesRequestRM({
    required this.author,
    required this.body,
  });

  @JsonKey(name: 'author')
  final String author;

  @JsonKey(name: 'body')
  final String body;

  Map<String, dynamic> toJson() => _$DialogueLinesRequestRMToJson(this);
}
