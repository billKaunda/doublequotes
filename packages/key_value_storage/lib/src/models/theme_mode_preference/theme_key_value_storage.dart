import 'package:hive_local_storage/hive_local_storage.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import 'theme_mode_preference.dart';

class ThemeKeyValueStorage {
  static const _themeSourcePreferenceBoxKey = 'theme-source-preference';
  static const _languagePreferenceBoxKey = 'language-preference';
  static const _darkModePreferenceBoxKey = 'dark-mode-preference';

  ThemeKeyValueStorage({
    @visibleForTesting HiveInterface? hive,
  }) : _hive = hive ?? Hive {
    try {
      _hive
        ..registerAdapter(ThemeSourcePreferenceCMAdapter())
        ..registerAdapter(LanguagePreferenceCMAdapter())
        ..registerAdapter(DarkModePreferenceCMAdapter());
    } catch (_) {
      throw Exception('Avoid having more than one [ThemeModeKeyValueStorage] '
          'instance in the project');
    }
  }

  final HiveInterface _hive;

  Future<Box<ThemeSourcePreferenceCM>> get themeSourcePreferenceBox =>
      _openThemeModeHiveBox<ThemeSourcePreferenceCM>(
          _themeSourcePreferenceBoxKey,
          isTemporary: false);

  Future<Box<LanguagePreferenceCM>> get languagePreferenceBox =>
      _openThemeModeHiveBox<LanguagePreferenceCM>(_languagePreferenceBoxKey,
          isTemporary: false);

  Future<Box<DarkModePreferenceCM>> get darkModePreferenceBox =>
      _openThemeModeHiveBox<DarkModePreferenceCM>(_darkModePreferenceBoxKey,
          isTemporary: false);

  Future<Box<E>> _openThemeModeHiveBox<E>(
    String boxKey, {
    required bool isTemporary,
  }) async {
    if (_hive.isBoxOpen(boxKey)) {
      return _hive.box(boxKey);
    } else {
      final directory = await (isTemporary
          ? getTemporaryDirectory()
          : getApplicationDocumentsDirectory());
      return _hive.openBox<E>(boxKey, path: directory.path);
    }
  }
}
