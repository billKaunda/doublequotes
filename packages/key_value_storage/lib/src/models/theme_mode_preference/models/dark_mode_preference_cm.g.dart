// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dark_mode_preference_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DarkModePreferenceCMAdapter extends TypeAdapter<DarkModePreferenceCM> {
  @override
  final int typeId = 11;

  @override
  DarkModePreferenceCM read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DarkModePreferenceCM.dark;
      case 1:
        return DarkModePreferenceCM.highContrastDark;
      case 2:
        return DarkModePreferenceCM.highContrastLight;
      case 3:
        return DarkModePreferenceCM.light;
      case 4:
        return DarkModePreferenceCM.accordingToSystemSettings;
      default:
        return DarkModePreferenceCM.dark;
    }
  }

  @override
  void write(BinaryWriter writer, DarkModePreferenceCM obj) {
    switch (obj) {
      case DarkModePreferenceCM.dark:
        writer.writeByte(0);
        break;
      case DarkModePreferenceCM.highContrastDark:
        writer.writeByte(1);
        break;
      case DarkModePreferenceCM.highContrastLight:
        writer.writeByte(2);
        break;
      case DarkModePreferenceCM.light:
        writer.writeByte(3);
        break;
      case DarkModePreferenceCM.accordingToSystemSettings:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DarkModePreferenceCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
