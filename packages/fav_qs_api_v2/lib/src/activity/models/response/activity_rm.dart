import 'package:json_annotation/json_annotation.dart';

part 'activity_rm.g.dart';

@JsonSerializable(createToJson: false)
class ActivityRM {
  const ActivityRM({
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

  @JsonKey(name: 'activity_id')
  final int activityId;

  @JsonKey(name: 'owner_type')
  final String? ownerType;
  
  @JsonKey(name: 'owner_Id')
  final String? ownerId;

  @JsonKey(name: 'owner_value')
  final String? ownerValue;

  @JsonKey(name: 'action')
  final String? action;

  @JsonKey(name: 'trackable_id')
  final int? trackableId;

  @JsonKey(name: 'trackable_type')
  final String? trackableType;

  @JsonKey(name: 'trackable_value')
  final String? trackableValue;

  @JsonKey(name: 'message')
  final String? message;

  static const fromJson = _$ActivityRMFromJson;
}
