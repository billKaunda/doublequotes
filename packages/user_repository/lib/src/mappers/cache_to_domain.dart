import 'package:domain_models/domain_models.dart';
import 'package:key_value_storage/key_value_storage.dart';

extension DarkModePrefereneCMToDomain on DarkModePreferenceCM {
  DarkModePreference toDomainModel() {
    switch (this) {
      case DarkModePreferenceCM.dark:
        return DarkModePreference.dark;
      case DarkModePreferenceCM.highContrastDark:
        return DarkModePreference.highContrastDark;
      case DarkModePreferenceCM.highContrastLight:
        return DarkModePreference.highContrastLight;
      case DarkModePreferenceCM.light:
        return DarkModePreference.light;
      case DarkModePreferenceCM.accordingToSystemSettings:
        return DarkModePreference.accordingToSystemSettings;
    }
  }
}

extension ThemeSourcePreferenceCMToDomain on ThemeSourcePreferenceCM {
  ThemeSourcePreference toDomainModel() {
    switch (this) {
      case ThemeSourcePreferenceCM.defaultTheme:
        return ThemeSourcePreference.defaultTheme;
      case ThemeSourcePreferenceCM.fromWallpaper:
        return ThemeSourcePreference.fromWallpaper;
    }
  }
}

extension LanguagePreferenceCMToDomain on LanguagePreferenceCM {
  LanguagePreference toDomainModel() {
    switch (this) {
      case LanguagePreferenceCM.english:
        return LanguagePreference.english;
      case LanguagePreferenceCM.swahili:
        return LanguagePreference.swahili;
    }
  }
}

extension FilterDetailsCMToDomain on FilterDetailsCM {
  FilterDetails toDomainModel() {
    return FilterDetails(
      count: count,
      permalink: permalink,
      name: name,
    );
  }
}

extension TypeaheadCMToDomain on TypeaheadCM {
  Typeahead toDomainModel() {
    return Typeahead(
      authors: authors!.map((author) => author.toDomainModel()).toList(),
      users: users!.map((user) => user.toDomainModel()).toList(),
      tags: tags!.map((tag) => tag.toDomainModel()).toList(),
    );
  }
}
