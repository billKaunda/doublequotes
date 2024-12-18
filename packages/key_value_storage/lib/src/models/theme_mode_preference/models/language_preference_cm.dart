import 'package:hive_local_storage/hive_local_storage.dart';

part 'language_preference_cm.g.dart';

@HiveType(typeId: 12)
enum LanguagePreferenceCM {

  @HiveField(0)
  english,

  @HiveField(1)
  swahili
}
