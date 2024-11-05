import 'package:domain_models/domain_models.dart';
import 'package:key_value_storage/key_value_storage.dart';

extension DarkModePreferenceDomainToCM on DarkModePreference {
  DarkModePreferenceCM toCacheModel() {
    switch (this) {
      case DarkModePreference.dark:
        return DarkModePreferenceCM.dark;
      case DarkModePreference.highContrastDark:
        return DarkModePreferenceCM.highContrastDark;
      case DarkModePreference.highContrastLight:
        return DarkModePreferenceCM.highContrastLight;
      case DarkModePreference.light:
        return DarkModePreferenceCM.light;
      case DarkModePreference.accordingToSystemSettings:
        return DarkModePreferenceCM.accordingToSystemSettings;
    }
  }
}

extension ThemeModePreferenceDomainToCM on ThemeModePreference {
  ThemeModePreferenceCM toCacheModel() {
    return ThemeModePreferenceCM(
      preference: preference.toCacheModel(),
    );
  }
}
