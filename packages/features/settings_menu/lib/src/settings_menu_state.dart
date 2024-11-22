part of 'settings_menu_bloc.dart';

abstract class SettingsMenuState extends Equatable {
  const SettingsMenuState();

  @override
  List<Object?> get props => [];
}

class SettingsMenuInProgress extends SettingsMenuState {
  const SettingsMenuInProgress();
}

class SettingsMenuLoaded extends SettingsMenuState {
  SettingsMenuLoaded({
    this.themeSourcePreference = ThemeSourcePreference.defaultTheme,
    this.darkModePreference = DarkModePreference.accordingToSystemSettings,
    this.languagePreference = LanguagePreference.english,
    this.isSignOutInProgress = false,
    this.username,
  });

  final ThemeSourcePreference themeSourcePreference;
  final DarkModePreference darkModePreference;
  final LanguagePreference languagePreference;
  final bool isSignOutInProgress;
  final String? username;

  bool get isUserAuthenticated => username != null;

  SettingsMenuLoaded copyWith({
    ThemeSourcePreference? themeSourcePreference,
    DarkModePreference? darkModePreference,
    LanguagePreference? languagePreference,
    bool? isSignOutInProgress,
    String? username,
  }) {
    return SettingsMenuLoaded(
      themeSourcePreference:
          themeSourcePreference ?? this.themeSourcePreference,
      darkModePreference: darkModePreference ?? this.darkModePreference,
      languagePreference: languagePreference ?? this.languagePreference,
      isSignOutInProgress: isSignOutInProgress ?? this.isSignOutInProgress,
      username: username ?? this.username,
    );
  }

  @override
  List<Object?> get props => [
        themeSourcePreference,
        darkModePreference,
        languagePreference,
        isSignOutInProgress,
        username,
      ];
}
