import 'settings_menu_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class SettingsMenuLocalizationsSw extends SettingsMenuLocalizations {
  SettingsMenuLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get themeSettingsTileLabel => 'Mipangilio ya Mandhari';

  @override
  String get defaultThemeTileLabel => 'Chaguo-msingi';

  @override
  String get themeFromMyWallpaperTileLabel => 'Imehamasishwa na picha wa ukuta wangu';

  @override
  String get languageListTileLabel => 'Lugha';

  @override
  String get languagePrefSimpleDialogTitle => 'Lugha';

  @override
  String get englishOptionTileLabel => 'Kiingereza';

  @override
  String get swahiliOptionTileLabel => 'Kiswahili';

  @override
  String get darkModePreferencesListTileLabel => 'Upendeleo wa Hali ya Giza';

  @override
  String get darkModePrefSimpleDialogTitle => 'Upendeleo wa Hali ya Giza';

  @override
  String get highContrastDarkOptionLabel => 'Tofauti ya Juu Giza';

  @override
  String get darkOptionTileLabel => 'Giza';

  @override
  String get lightOptionTileLabel => 'Nuru';

  @override
  String get highContrastLightOptionTileLabel => 'Nuru ya Tofauti ya Juu';

  @override
  String get useSystemSettingsOptionTileLabel => 'Tumia Mipangilio ya Mfumo';

  @override
  String get languageTileLabel => 'Lugha';

  @override
  String get englishLanguageOptionLabel => 'English';

  @override
  String get swahiliLanguageOptionLabel => 'Kiswahili';

  @override
  String get signInButtonLabel => 'Weka sahihi';

  @override
  String get signUpOpeningText => 'Je, huna akaunti? Bonyeza hapa.';

  @override
  String get signUpButtonLabel => 'Jisajili';

  @override
  String signedInUserGreeting(String username) {
    return 'Hi $username';
  }

  @override
  String get signOutButtonLabel => 'Ondoka';
}
