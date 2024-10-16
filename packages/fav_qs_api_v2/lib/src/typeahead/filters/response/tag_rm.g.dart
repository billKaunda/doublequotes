// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagRM _$TagRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'TagRM',
      json,
      ($checkedConvert) {
        final val = TagRM(
          details: $checkedConvert('details',
              (v) => FilterDetailsRM.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );
