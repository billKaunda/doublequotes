// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_credentials_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCredentialsRM _$UserCredentialsRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'UserCredentialsRM',
      json,
      ($checkedConvert) {
        final val = UserCredentialsRM(
          username: $checkedConvert('login', (v) => v as String?),
          email: $checkedConvert('email', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'username': 'login'},
    );
