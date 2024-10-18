// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDetailsCMAdapter extends TypeAdapter<UserDetailsCM> {
  @override
  final int typeId = 7;

  @override
  UserDetailsCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDetailsCM(
      isFavorite: fields[0] as bool?,
      isUpvoted: fields[1] as bool?,
      isDownvoted: fields[2] as bool?,
      isHidden: fields[3] as bool?,
      personalTags: (fields[4] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserDetailsCM obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.isFavorite)
      ..writeByte(1)
      ..write(obj.isUpvoted)
      ..writeByte(2)
      ..write(obj.isDownvoted)
      ..writeByte(3)
      ..write(obj.isHidden)
      ..writeByte(4)
      ..write(obj.personalTags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDetailsCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
