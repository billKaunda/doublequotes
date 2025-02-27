// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'followers_list_page_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FollowersListPageCMAdapter extends TypeAdapter<FollowersListPageCM> {
  @override
  final int typeId = 3;

  @override
  FollowersListPageCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FollowersListPageCM(
      page: fields[0] as int?,
      isLastPage: fields[1] as bool?,
      users: (fields[2] as List?)?.cast<String>(),
      authors: (fields[3] as List?)?.cast<String>(),
      tags: (fields[4] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, FollowersListPageCM obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.page)
      ..writeByte(1)
      ..write(obj.isLastPage)
      ..writeByte(2)
      ..write(obj.users)
      ..writeByte(3)
      ..write(obj.authors)
      ..writeByte(4)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FollowersListPageCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
