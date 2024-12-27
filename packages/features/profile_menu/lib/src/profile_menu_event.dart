part of 'profile_menu_bloc.dart';

abstract class ProfileMenuEvent extends Equatable {
  const ProfileMenuEvent();

  @override
  List<Object?> get props => [];
}

class ProfileMenuStarted extends ProfileMenuEvent {
  const ProfileMenuStarted();
}

class ProfileMenuUsernameObtained extends ProfileMenuEvent {
  const ProfileMenuUsernameObtained();
}

class ProfileMenuThemeSourcePrefChanged extends ProfileMenuEvent {
  const ProfileMenuThemeSourcePrefChanged(
    this.themeSourcePreference,
  );

  final ThemeSourcePreference themeSourcePreference;

  @override
  List<Object?> get props => [
        themeSourcePreference,
      ];
}

class ProfileMenuDarkModePrefChanged extends ProfileMenuEvent {
  const ProfileMenuDarkModePrefChanged(
    this.darkModePreference,
  );

  final DarkModePreference darkModePreference;

  @override
  List<Object?> get props => [
        darkModePreference,
      ];
}

class ProfileMenuLanguagePrefChanged extends ProfileMenuEvent {
  const ProfileMenuLanguagePrefChanged(this.languagePreference);

  final LanguagePreference languagePreference;

  @override
  List<Object?> get props => [
        languagePreference,
      ];
}

class ProfileMenuSignedOut extends ProfileMenuEvent {
  const ProfileMenuSignedOut();
}
