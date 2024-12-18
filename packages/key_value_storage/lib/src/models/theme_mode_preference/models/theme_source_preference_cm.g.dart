// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_source_preference_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemeSourcePreferenceCMAdapter
    extends TypeAdapter<ThemeSourcePreferenceCM> {
  @override
  final int typeId = 13;

  @override
  ThemeSourcePreferenceCM read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ThemeSourcePreferenceCM.defaultTheme;
      case 1:
        return ThemeSourcePreferenceCM.fromWallpaper;
      default:
        return ThemeSourcePreferenceCM.defaultTheme;
    }
  }

  @override
  void write(BinaryWriter writer, ThemeSourcePreferenceCM obj) {
    switch (obj) {
      case ThemeSourcePreferenceCM.defaultTheme:
        writer.writeByte(0);
        break;
      case ThemeSourcePreferenceCM.fromWallpaper:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeSourcePreferenceCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
