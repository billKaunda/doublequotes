// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activities_list_page_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivitiesListPageCMAdapter extends TypeAdapter<ActivitiesListPageCM> {
  @override
  final int typeId = 2;

  @override
  ActivitiesListPageCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivitiesListPageCM(
      activities: (fields[0] as List?)?.cast<ActivityCM>(),
    );
  }

  @override
  void write(BinaryWriter writer, ActivitiesListPageCM obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.activities);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivitiesListPageCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
