import 'update_profile_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class UpdateProfileLocalizationsEn extends UpdateProfileLocalizations {
  UpdateProfileLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Update Profile';

  @override
  String get usernameTextFieldLabel => 'Username';

  @override
  String get usernameTextFieldEmptyErrorMessage => 'Your username can\'t be empty.';

  @override
  String get usernameTextFieldInvalidErrorMessage => 'Your username must be 1-20 characters long and can only contain letters, numbers, and the underscore (_).';

  @override
  String get usernameTextFieldAlreadyTakenErrorMessage => 'This username is already taken. Please, choose another one';

  @override
  String get emailTextFieldLabel => 'Email';

  @override
  String get emailTextFieldEmptyErrorMessage => 'Your email can\'t be empty.';

  @override
  String get emailTextFieldInvalidErrorMessage => 'This email is not valid.';

  @override
  String get emailTextFieldAlreadyRegisteredErrorMessage => 'This email is already registered.';

  @override
  String get passwordTextFieldLabel => 'New Password';

  @override
  String get passwordTextFieldInvalidErrorMessage => 'Password must be at least five characters long.';

  @override
  String get passwordConfirmationTextFieldLabel => 'New Password Confirmation';

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
  String get updateProfilePictureTileLabel => 'Edit Profile Picture';

  @override
  String get updateProfilePictureSubtitleLabel => 'Set Your Profile From Selected Social Media Platforms';

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

  @override
  String get updateProfileButtonLabel => 'Update Profile';
}
