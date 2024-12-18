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

extension ThemeSourcePreferenceDomainToCM on ThemeSourcePreference {
  ThemeSourcePreferenceCM toCacheModel() {
    switch (this) {
      case ThemeSourcePreference.defaultTheme:
        return ThemeSourcePreferenceCM.defaultTheme;
      case ThemeSourcePreference.fromWallpaper:
        return ThemeSourcePreferenceCM.fromWallpaper;
    }
  }
}

extension LanguagePreferenceDomainToCM on LanguagePreference {
  LanguagePreferenceCM toCacheModel() {
    switch (this) {
      case LanguagePreference.english:
        return LanguagePreferenceCM.english;
      case LanguagePreference.swahili:
        return LanguagePreferenceCM.swahili;
    }
  }
}
