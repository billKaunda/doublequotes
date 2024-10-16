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
          userToken: $checkedConvert('User-Token', (v) => v as String),
          userCredentials: $checkedConvert('userCredentials',
              (v) => UserCredentialsRM.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'userToken': 'User-Token'},
    );
