import 'package:json_annotation/json_annotation.dart';

import 'dialogue_line_request_rm.dart';

part 'dialogue_request_rm.g.dart';

@JsonSerializable(createFactory: false)
class DialogueRequestRM {
  const DialogueRequestRM({
    this.lines,
    this.source,
    this.context,
    this.tags,
  });

  @JsonKey(name: 'lines')
  final List<DialogueLineRequestRM>? lines;

  @JsonKey(name: 'source')
  final String? source;

  @JsonKey(name: 'context')
  final String? context;

  @JsonKey(name: 'tags')
  final String? tags;

  Map<String, dynamic> toJson() => _$DialogueRequestRMToJson(this);
}
