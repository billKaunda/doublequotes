part of 'settings_menu_bloc.dart';

abstract class SettingsMenuEvent extends Equatable {
  const SettingsMenuEvent();

  @override
  List<Object?> get props => [];
}

class SettingsMenuStarted extends SettingsMenuEvent {
  const SettingsMenuStarted();
}

class SettingsMenuThemeSourceChanged extends SettingsMenuEvent {
  const SettingsMenuThemeSourceChanged(
    this.themeSourcePreference,
  );

  final ThemeSourcePreference themeSourcePreference;

  @override
  List<Object?> get props => [
        themeSourcePreference,
      ];
}

class SettingsMenuDarkModePrefChanged extends SettingsMenuEvent {
  const SettingsMenuDarkModePrefChanged(
    this.darkModePreference,
  );

  final DarkModePreference darkModePreference;

  @override
  List<Object?> get props => [
        darkModePreference,
      ];
}

class SettingsMenuLanguagePrefChanged extends SettingsMenuEvent {
  const SettingsMenuLanguagePrefChanged(this.languagePreference);

  final LanguagePreference languagePreference;

  @override
  List<Object?> get props => [
        languagePreference,
      ];
}

class SettingsMenuSignedOut extends SettingsMenuEvent {
  const SettingsMenuSignedOut();
}
