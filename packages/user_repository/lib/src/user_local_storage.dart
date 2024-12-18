import 'package:key_value_storage/key_value_storage.dart';

class UserLocalStorage {
  static const _themeSourcePreferenceBoxKey = 'theme-source-preference';
  static const _languagePreferenceBoxKey = 'language-preference';
  static const _darkModePreferenceBoxKey = 'dark-mode-preference';
  static const _typeaheadBoxKey = 'typeahead';

  UserLocalStorage({
    required this.themeModeStorage,
    required this.typeaheadStorage,
  });

  final ThemeKeyValueStorage themeModeStorage;
  final TypeaheadKeyValueStorage typeaheadStorage;

  Future<void> upsertThemeSourcePreference(
      ThemeSourcePreferenceCM theme) async {
    final box = await themeModeStorage.themeSourcePreferenceBox;
    box.put(_themeSourcePreferenceBoxKey, theme);
  }

  Future<ThemeSourcePreferenceCM?> getThemeSourcePreference() async {
    final box = await themeModeStorage.themeSourcePreferenceBox;
    return box.get(_themeSourcePreferenceBoxKey);
  }

  Future<void> upsertLanguagePreference(LanguagePreferenceCM theme) async {
    final box = await themeModeStorage.languagePreferenceBox;
    box.put(_languagePreferenceBoxKey, theme);
  }

  Future<LanguagePreferenceCM?> getLanguagePreference() async {
    final box = await themeModeStorage.languagePreferenceBox;
    return box.get(_languagePreferenceBoxKey);
  }

  Future<void> upsertdarkModePreference(DarkModePreferenceCM theme) async {
    final box = await themeModeStorage.darkModePreferenceBox;
    box.put(_darkModePreferenceBoxKey, theme);
  }

  Future<DarkModePreferenceCM?> getDarkModePreference() async {
    final box = await themeModeStorage.darkModePreferenceBox;
    return box.get(_darkModePreferenceBoxKey);
  }
  

  Future<void> upsertTypeahead(TypeaheadCM typeaheadCM) async {
    final box = await typeaheadStorage.typeaheadBox;
    box.put(_typeaheadBoxKey, typeaheadCM);
  }

  Future<TypeaheadCM?> getTypeahead() async {
    final box = await typeaheadStorage.typeaheadBox;
    return box.get(_typeaheadBoxKey);
  }
}
