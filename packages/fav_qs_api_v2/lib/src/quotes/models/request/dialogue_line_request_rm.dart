import 'package:json_annotation/json_annotation.dart';

part 'dialogue_line_request_rm.g.dart';

@JsonSerializable(createFactory: false)
class DialogueLineRequestRM {
  const DialogueLineRequestRM({
    required this.author,
    required this.body,
  });

  @JsonKey(name: 'author')
  final String author;

  @JsonKey(name: 'body')
  final String body;

  Map<String, dynamic> toJson() => _$DialogueLineRequestRMToJson(this);
}
