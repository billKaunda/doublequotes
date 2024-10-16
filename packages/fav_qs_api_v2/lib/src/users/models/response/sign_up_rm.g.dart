// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpRM _$SignUpRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'SignUpRM',
      json,
      ($checkedConvert) {
        final val = SignUpRM(
          userToken: $checkedConvert('User-Token', (v) => v as String),
          username: $checkedConvert('login', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'userToken': 'User-Token', 'username': 'login'},
    );
