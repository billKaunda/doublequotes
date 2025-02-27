// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_list_page_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuoteListPageCMAdapter extends TypeAdapter<QuoteListPageCM> {
  @override
  final int typeId = 9;

  @override
  QuoteListPageCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuoteListPageCM(
      page: fields[0] as int?,
      isLastPage: fields[1] as bool?,
      quotes: (fields[2] as List?)?.cast<QuoteCM>(),
    );
  }

  @override
  void write(BinaryWriter writer, QuoteListPageCM obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.page)
      ..writeByte(1)
      ..write(obj.isLastPage)
      ..writeByte(2)
      ..write(obj.quotes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuoteListPageCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
