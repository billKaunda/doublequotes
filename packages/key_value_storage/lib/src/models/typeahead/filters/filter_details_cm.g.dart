// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_details_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilterDetailsCMAdapter extends TypeAdapter<FilterDetailsCM> {
  @override
  final int typeId = 14;

  @override
  FilterDetailsCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FilterDetailsCM(
      count: fields[0] as int?,
      permalink: fields[1] as String?,
      name: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FilterDetailsCM obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.permalink)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterDetailsCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
