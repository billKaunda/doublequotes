// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qotd_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QotdCMAdapter extends TypeAdapter<QotdCM> {
  @override
  final int typeId = 7;

  @override
  QotdCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QotdCM(
      date: fields[0] as String,
      quote: fields[1] as QuoteCM,
    );
  }

  @override
  void write(BinaryWriter writer, QotdCM obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.quote);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QotdCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
