// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityCMAdapter extends TypeAdapter<ActivityCM> {
  @override
  final int typeId = 1;

  @override
  ActivityCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivityCM(
      activityId: fields[0] as int,
      ownerType: fields[1] as String?,
      ownerId: fields[2] as String?,
      ownerValue: fields[3] as String?,
      action: fields[4] as String?,
      trackableId: fields[5] as int?,
      trackableType: fields[6] as String?,
      trackableValue: fields[7] as String?,
      message: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ActivityCM obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.activityId)
      ..writeByte(1)
      ..write(obj.ownerType)
      ..writeByte(2)
      ..write(obj.ownerId)
      ..writeByte(3)
      ..write(obj.ownerValue)
      ..writeByte(4)
      ..write(obj.action)
      ..writeByte(5)
      ..write(obj.trackableId)
      ..writeByte(6)
      ..write(obj.trackableType)
      ..writeByte(7)
      ..write(obj.trackableValue)
      ..writeByte(8)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
