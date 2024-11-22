import 'settings_menu_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SettingsMenuLocalizationsEn extends SettingsMenuLocalizations {
  SettingsMenuLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get themeSettingsTileLabel => 'Theme Settings';

  @override
  String get defaultThemeTileLabel => 'Default';

  @override
  String get themeFromMyWallpaperTileLabel => 'Inspired by my wallpaper';

  @override
  String get languageListTileLabel => 'Language';

  @override
  String get languagePrefSimpleDialogTitle => 'Language';

  @override
  String get englishOptionTileLabel => 'English';

  @override
  String get swahiliOptionTileLabel => 'Swahili';

  @override
  String get darkModePreferencesListTileLabel => 'Dark Mode Preference';

  @override
  String get darkModePrefSimpleDialogTitle => 'Dark Mode Preference';

  @override
  String get highContrastDarkOptionLabel => 'High Contrast Dark';

  @override
  String get darkOptionTileLabel => 'Dark';

  @override
  String get lightOptionTileLabel => 'Light';

  @override
  String get highContrastLightOptionTileLabel => 'High Contrast Light';

  @override
  String get useSystemSettingsOptionTileLabel => 'Use System Settings';

  @override
  String get languageTileLabel => 'Language';

  @override
  String get englishLanguageOptionLabel => 'English';

  @override
  String get swahiliLanguageOptionLabel => 'Kiswahili';

  @override
  String get signInButtonLabel => 'Sign in';

  @override
  String get signUpOpeningText => 'Don\'t have an account?';

  @override
  String get signUpButtonLabel => 'Sign Up';

  @override
  String signedInUserGreeting(String username) {
    return 'Hi $username';
  }

  @override
  String get signOutButtonLabel => 'Sign Out';
}
