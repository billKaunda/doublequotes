import 'profile_menu_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ProfileMenuLocalizationsEn extends ProfileMenuLocalizations {
  ProfileMenuLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get signInButtonLabel => 'Sign In';

  @override
  String signInUserGreeting(String username) {
    return 'Hi $username ';
  }

  @override
  String get updateProfileTileLabel => 'Update Profile';

  @override
  String get signOutButtonLabel => 'Sign Out';

  @override
  String get signUpOpeningText => 'Don\'t have an account?';

  @override
  String get signUpButtonLabel => 'Sign Up';

  @override
  String get usernameLabel => 'Username';

  @override
  String get usernameTextFieldEmptyErrorMessage => 'Your username can\'t be empty.';

  @override
  String get usernameTextFieldInvalidErrorMessage => 'Your username must be 1-20 characters long and can only contain letters, numbers, and the underscore (_).';

  @override
  String get usernameTextFieldAlreadyTakenErrorMessage => 'This username is already taken.';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailTextFieldEmptyErrorMessage => 'Your email can\'t be empty.';

  @override
  String get emailTextFieldInvalidErrorMessage => 'This email is not valid.';

  @override
  String get emailTextFieldAlreadyRegisteredErrorMessage => 'This email is already registered.';

  @override
  String get updatePasswordTileLabel => 'Update Password';

  @override
  String get passwordLabel => 'New Password';

  @override
  String get passwordTextFieldInvalidErrorMessage => 'Password must be at least five characters long.';

  @override
  String get passwordConfirmationLabel => 'New Password Confirmation';

  @override
  String get passwordConfirmationTextFieldInvalidErrorMessage => 'Your passwords don\'t match.';

  @override
  String get xUsernameLabel => 'X Username';

  @override
  String get xUsernameTextFieldEmptyErrorMessage => 'Your X username can\'t be empty.';

  @override
  String get xUsernameTextFieldInvalidErrorMessage => 'Your X username must be 4-15 characters long and can only contain letters, numbers, underscore (_) and the (@) symbol.';

  @override
  String get facebookUsernameLabel => 'Facebook Username';

  @override
  String get facebookUsernameTextFieldEmptyErrorMessage => 'Your facebook username can\'t be empty.';

  @override
  String get facebookUsernameTextFieldInvalidErrorMessage => 'Your facebook username must be 4-15 characters long and can only contain letters, numbers, underscore (_) and the (@) symbol.';

  @override
  String get profanityFilterTileLabel => 'Profanity Filter';

  @override
  String get enableProfanityFilterSubtitle => 'Allow profane quotes to be displayed';

  @override
  String get disableProfanityFilterSubtitle => 'Disable profane quotes from being displayed';

  @override
  String get updateProfileButtonLabel => 'Update Profile';

  @override
  String get followersLabel => 'Followers';

  @override
  String get followingLabel => 'Following';

  @override
  String get publicFavoritesLabel => 'Public Favorites';

  @override
  String get facebookTitle => 'Facebook';

  @override
  String get setPicFromFacebookSubtitle => 'Set profile picture from Facebook';

  @override
  String get emptyFacebookUsernameErrorMessage => 'Oops, you haven\'t set your facebook username yet. Please update it then try again';

  @override
  String get xTitle => 'X';

  @override
  String get setPicFromXSubtitle => 'Set profile picture from X';

  @override
  String get emptyXUsernameErrorMessage => 'Oops, you haven\'t set your X username yet. Please update it then try again';

  @override
  String get emailGravaterTitle => 'Email Gravater';

  @override
  String get setPicFromEmailSubtitle => 'Set profile picture from Email Gravater';

  @override
  String get emptyEmailGravaterErrorMessage => 'Oops, you haven\'t set Email Gravater yet. Please update it then try again';
}
