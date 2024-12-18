// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuoteCMAdapter extends TypeAdapter<QuoteCM> {
  @override
  final int typeId = 8;

  @override
  QuoteCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuoteCM(
      quoteId: fields[0] as int,
      favoritesCount: fields[1] as int?,
      enableDialogue: fields[2] as bool?,
      isFavorite: fields[3] as bool?,
      tags: (fields[4] as List?)?.cast<String>(),
      quoteUrl: fields[5] as String?,
      upvotesCount: fields[6] as int?,
      downvotesCount: fields[7] as int?,
      author: fields[8] as String?,
      authorPermalink: fields[9] as String?,
      body: fields[10] as String?,
      isPrivate: fields[11] as bool?,
      userDetails: fields[12] as UserDetailsCM?,
      dialogueLines: (fields[13] as List?)?.cast<DialogueLineCM>(),
      source: fields[14] as String?,
      context: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, QuoteCM obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.quoteId)
      ..writeByte(1)
      ..write(obj.favoritesCount)
      ..writeByte(2)
      ..write(obj.enableDialogue)
      ..writeByte(3)
      ..write(obj.isFavorite)
      ..writeByte(4)
      ..write(obj.tags)
      ..writeByte(5)
      ..write(obj.quoteUrl)
      ..writeByte(6)
      ..write(obj.upvotesCount)
      ..writeByte(7)
      ..write(obj.downvotesCount)
      ..writeByte(8)
      ..write(obj.author)
      ..writeByte(9)
      ..write(obj.authorPermalink)
      ..writeByte(10)
      ..write(obj.body)
      ..writeByte(11)
      ..write(obj.isPrivate)
      ..writeByte(12)
      ..write(obj.userDetails)
      ..writeByte(13)
      ..write(obj.dialogueLines)
      ..writeByte(14)
      ..write(obj.source)
      ..writeByte(15)
      ..write(obj.context);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuoteCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
