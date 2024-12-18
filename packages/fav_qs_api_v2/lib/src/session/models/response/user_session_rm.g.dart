// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_session_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSessionRM _$UserSessionRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'UserSessionRM',
      json,
      ($checkedConvert) {
        final val = UserSessionRM(
          userToken: $checkedConvert('User-Token', (v) => v as String),
          userCredentials: $checkedConvert('userCredentials',
              (v) => UserCredentialsRM.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'userToken': 'User-Token'},
    );
