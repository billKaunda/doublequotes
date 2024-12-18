import 'package:hive_local_storage/hive_local_storage.dart';

part 'dark_mode_preference_cm.g.dart';

@HiveType(typeId: 11)
enum DarkModePreferenceCM {

  @HiveField(0)
  dark,

  @HiveField(1)
  highContrastDark,

  @HiveField(2)
  highContrastLight,

  @HiveField(3)
  light,

  @HiveField(4)
  accordingToSystemSettings,
}