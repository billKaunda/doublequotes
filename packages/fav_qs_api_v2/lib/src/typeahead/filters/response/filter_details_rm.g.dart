// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_details_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterDetailsRM _$FilterDetailsRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FilterDetailsRM',
      json,
      ($checkedConvert) {
        final val = FilterDetailsRM(
          count: $checkedConvert('count', (v) => (v as num?)?.toInt()),
          permalink: $checkedConvert('permalink', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String?),
        );
        return val;
      },
    );
