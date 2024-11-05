import 'package:key_value_storage/key_value_storage.dart';

class UserLocalStorage {
  static const _themeModePreferenceBoxKey = 'theme-mode-preference';
  static const _typeaheadBoxKey = 'typeahead';

  UserLocalStorage({
    required this.themeModeStorage,
    required this.typeaheadStorage,
  });

  final ThemeKeyValueStorage themeModeStorage;
  final TypeaheadKeyValueStorage typeaheadStorage;

  Future<void> upsertThemeModePreference(ThemeModePreferenceCM theme) async {
    final box = await themeModeStorage.themeModePreferenceBox;
    box.put(_themeModePreferenceBoxKey, theme);
  }

  Future<ThemeModePreferenceCM?> getThemeModePreference() async {
    final box = await themeModeStorage.themeModePreferenceBox;
    return box.get(_themeModePreferenceBoxKey);
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
