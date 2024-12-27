part of 'profile_menu_bloc.dart';

abstract class ProfileMenuState extends Equatable {
  const ProfileMenuState();

  @override
  List<Object?> get props => [];
}

class ProfileMenuInProgress extends ProfileMenuState {
  const ProfileMenuInProgress();
}

class ProfileMenuLoaded extends ProfileMenuState {
  const ProfileMenuLoaded({
    this.themeSourcePreference = ThemeSourcePreference.defaultTheme,
    this.darkModePreference = DarkModePreference.accordingToSystemSettings,
    this.languagePreference = LanguagePreference.english,
    this.isSignOutInProgress = false,
    this.username,
    this.picUrl,
    this.publicFavoritesCount,
    this.followers,
    this.following,
    this.isProUser = false,
    this.accountDetails,
  });
  final ThemeSourcePreference themeSourcePreference;
  final DarkModePreference darkModePreference;
  final LanguagePreference languagePreference;
  final bool isSignOutInProgress;
  final String? username;
  final String? picUrl;
  final int? publicFavoritesCount;
  final int? followers;
  final int? following;
  final bool isProUser;
  final AccountDetails? accountDetails;

  bool get isUserAuthenticated => username != null;

  ProfileMenuLoaded copyWith({
    ThemeSourcePreference? themeSourcePreference,
    DarkModePreference? darkModePreference,
    LanguagePreference? languagePreference,
    bool? isSignOutInProgress,
    String? username,
    String? picUrl,
    int? publicFavoritesCount,
    int? followers,
    int? following,
    bool? isProUser,
    AccountDetails? accountDetails,
  }) {
    return ProfileMenuLoaded(
      themeSourcePreference: themeSourcePreference ?? this.themeSourcePreference,
      darkModePreference: darkModePreference ?? this.darkModePreference,
      languagePreference: languagePreference ?? this.languagePreference,
      isSignOutInProgress: isSignOutInProgress ?? this.isSignOutInProgress,
      username: username ?? this.username,
      picUrl: picUrl ?? this.picUrl,
      publicFavoritesCount: publicFavoritesCount ?? this.publicFavoritesCount,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      isProUser: isProUser ?? this.isProUser,
      accountDetails: accountDetails ?? this.accountDetails,
    );
  }

  @override
  List<Object?> get props => [
        themeSourcePreference,
        darkModePreference,
        languagePreference,
        isSignOutInProgress,
        username,
        picUrl,
        publicFavoritesCount,
        followers,
        following,
        isProUser,
        accountDetails,
      ];
}
