// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typeahead_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TypeaheadCMAdapter extends TypeAdapter<TypeaheadCM> {
  @override
  final int typeId = 15;

  @override
  TypeaheadCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TypeaheadCM(
      authors: (fields[0] as List?)?.cast<FilterDetailsCM>(),
      users: (fields[1] as List?)?.cast<FilterDetailsCM>(),
      tags: (fields[2] as List?)?.cast<FilterDetailsCM>(),
    );
  }

  @override
  void write(BinaryWriter writer, TypeaheadCM obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.authors)
      ..writeByte(1)
      ..write(obj.users)
      ..writeByte(2)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeaheadCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
