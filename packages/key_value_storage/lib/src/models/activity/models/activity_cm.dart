import 'package:hive_local_storage/hive_local_storage.dart';

part 'activity_cm.g.dart';

//TypeId for data classes begins at typeId=1 because typeId=0 is
//already used by session classes
@HiveType(typeId: 1)
class ActivityCM {
  const ActivityCM({
    required this.activityId,
    this.ownerType,
    this.ownerId,
    this.ownerValue,
    this.action,
    this.trackableId,
    this.trackableType,
    this.trackableValue,
    this.message,
  });

  @HiveField(0)
  final int activityId;

  @HiveField(1)
  final String? ownerType;

  @HiveField(2)
  final String? ownerId;

  @HiveField(3)
  final String? ownerValue;

  @HiveField(4)
  final String? action;

  @HiveField(5)
  final int? trackableId;

  @HiveField(6)
  final String? trackableType;

  @HiveField(7)
  final String? trackableValue;

  @HiveField(8)
  final String? message;
}
