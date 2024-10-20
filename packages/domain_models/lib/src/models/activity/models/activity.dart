import 'package:equatable/equatable.dart';

class Activity extends Equatable {
  const Activity({
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

  final int activityId;

  final String? ownerType;

  final String? ownerId;

  final String? ownerValue;

  final String? action;

  final int? trackableId;

  final String? trackableType;

  final String? trackableValue;

  final String? message;

  @override
  List<Object?> get props => [
    activityId,
    ownerType,
    ownerId,
    ownerValue,
    action,
    trackableId,
    trackableType,
    trackableValue,
    message,
  ];
}
