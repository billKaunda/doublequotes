// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'following_item_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FollowingItemCMAdapter extends TypeAdapter<FollowingItemCM> {
  @override
  final int typeId = 4;

  @override
  FollowingItemCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FollowingItemCM(
      followingType: fields[0] as String,
      followingId: fields[1] as String?,
      followingValue: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FollowingItemCM obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.followingType)
      ..writeByte(1)
      ..write(obj.followingId)
      ..writeByte(2)
      ..write(obj.followingValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FollowingItemCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
