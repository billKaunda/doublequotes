// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'following_list_page_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FollowingListPageCMAdapter extends TypeAdapter<FollowingListPageCM> {
  @override
  final int typeId = 5;

  @override
  FollowingListPageCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FollowingListPageCM(
      page: fields[0] as int?,
      isLastPage: fields[1] as bool?,
      followingItems: (fields[2] as List?)?.cast<FollowingItemCM>(),
    );
  }

  @override
  void write(BinaryWriter writer, FollowingListPageCM obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.page)
      ..writeByte(1)
      ..write(obj.isLastPage)
      ..writeByte(2)
      ..write(obj.followingItems);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FollowingListPageCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
