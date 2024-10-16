// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRM _$UserRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'UserRM',
      json,
      ($checkedConvert) {
        final val = UserRM(
          details: $checkedConvert('details',
              (v) => FilterDetailsRM.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );
