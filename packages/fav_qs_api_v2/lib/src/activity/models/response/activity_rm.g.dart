// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityRM _$ActivityRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ActivityRM',
      json,
      ($checkedConvert) {
        final val = ActivityRM(
          activityId: $checkedConvert('activity_id', (v) => (v as num).toInt()),
          ownerType: $checkedConvert('owner_type', (v) => v as String?),
          ownerId: $checkedConvert('owner_Id', (v) => v as String?),
          ownerValue: $checkedConvert('owner_value', (v) => v as String?),
          action: $checkedConvert('action', (v) => v as String?),
          trackableId:
              $checkedConvert('trackable_id', (v) => (v as num?)?.toInt()),
          trackableType: $checkedConvert('trackable_type', (v) => v as String?),
          trackableValue:
              $checkedConvert('trackable_value', (v) => v as String?),
          message: $checkedConvert('message', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'activityId': 'activity_id',
        'ownerType': 'owner_type',
        'ownerId': 'owner_Id',
        'ownerValue': 'owner_value',
        'trackableId': 'trackable_id',
        'trackableType': 'trackable_type',
        'trackableValue': 'trackable_value'
      },
    );
