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
          username: $checkedConvert('login', (v) => v as String),
          picUrl: $checkedConvert('pic_url', (v) => v as String?),
          publicFavoritesCount: $checkedConvert(
              'public_favorites_count', (v) => (v as num?)?.toInt()),
          followers: $checkedConvert('followers', (v) => (v as num?)?.toInt()),
          following: $checkedConvert('following', (v) => (v as num?)?.toInt()),
          isProUser: $checkedConvert('pro', (v) => v as bool?),
          accountDetails: $checkedConvert(
              'account_details',
              (v) => v == null
                  ? null
                  : AccountDetailsRM.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'username': 'login',
        'picUrl': 'pic_url',
        'publicFavoritesCount': 'public_favorites_count',
        'isProUser': 'pro',
        'accountDetails': 'account_details'
      },
    );
