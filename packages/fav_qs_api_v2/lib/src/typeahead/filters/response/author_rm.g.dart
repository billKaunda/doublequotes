// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorRM _$AuthorRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'AuthorRM',
      json,
      ($checkedConvert) {
        final val = AuthorRM(
          details: $checkedConvert('details',
              (v) => FilterDetailsRM.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );
