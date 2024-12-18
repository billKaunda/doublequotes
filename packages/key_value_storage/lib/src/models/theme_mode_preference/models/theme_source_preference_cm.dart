import 'package:hive_local_storage/hive_local_storage.dart';

part 'theme_source_preference_cm.g.dart';

@HiveType(typeId: 13)
enum ThemeSourcePreferenceCM {

  @HiveField(0)
  defaultTheme,

  @HiveField(1)
  fromWallpaper,
}
