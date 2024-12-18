// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialogue_line_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DialogueLineRM _$DialogueLineRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DialogueLineRM',
      json,
      ($checkedConvert) {
        final val = DialogueLineRM(
          author: $checkedConvert('author', (v) => v as String),
          body: $checkedConvert('body', (v) => v as String),
        );
        return val;
      },
    );
