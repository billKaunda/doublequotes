import 'package:hive_local_storage/hive_local_storage.dart';

part 'dark_mode_preference_cm.g.dart';

@HiveType(typeId: 6)
enum DarkModePreferenceCM {

  @HiveField(0)
  dark,

  @HiveField(1)
  light,

  @HiveField(2)
  accordingToSystemSettings,
}