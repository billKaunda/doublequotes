// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'following_item_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowingItemRM _$FollowingItemRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FollowingItemRM',
      json,
      ($checkedConvert) {
        final val = FollowingItemRM(
          followingType: $checkedConvert('following_type', (v) => v as String),
          followingId: $checkedConvert('following_id', (v) => v as String?),
          followingValue:
              $checkedConvert('following_value', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'followingType': 'following_type',
        'followingId': 'following_id',
        'followingValue': 'following_value'
      },
    );
