// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typeahead_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeaheadRM _$TypeaheadRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'TypeaheadRM',
      json,
      ($checkedConvert) {
        final val = TypeaheadRM(
          authors: $checkedConvert(
              'authors',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      FilterDetailsRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
          tags: $checkedConvert(
              'tags',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      FilterDetailsRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
          users: $checkedConvert(
              'users',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      FilterDetailsRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );
