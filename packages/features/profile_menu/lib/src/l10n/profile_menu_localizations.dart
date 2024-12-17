import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'profile_menu_localizations_en.dart';
import 'profile_menu_localizations_sw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ProfileMenuLocalizations
/// returned by `ProfileMenuLocalizations.of(context)`.
///
/// Applications need to include `ProfileMenuLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/profile_menu_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ProfileMenuLocalizations.localizationsDelegates,
///   supportedLocales: ProfileMenuLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the ProfileMenuLocalizations.supportedLocales
/// property.
abstract class ProfileMenuLocalizations {
  ProfileMenuLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ProfileMenuLocalizations of(BuildContext context) {
    return Localizations.of<ProfileMenuLocalizations>(context, ProfileMenuLocalizations)!;
  }

  static const LocalizationsDelegate<ProfileMenuLocalizations> delegate = _ProfileMenuLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('sw')
  ];

  /// Label for the sign in button which a user taps to sign into the app.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButtonLabel;

  /// No description provided for @signInUserGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hi {username} '**
  String signInUserGreeting(String username);

  /// Label for the tile which a user can tap to update/modify his profile.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get updateProfileTileLabel;

  /// Label for the sign out button that a user can tap to end his session in FavQs.com
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOutButtonLabel;

  /// Text message displayed that prompts a visitor to open an account in FavQs.com
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get signUpOpeningText;

  /// Label for the sign up button that a visitor can tap to open an account in FavQs.com
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpButtonLabel;

  /// Label of the field for updating one's username
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get usernameLabel;

  /// Error message shown when the username field has been left empty
  ///
  /// In en, this message translates to:
  /// **'Your username can\'t be empty.'**
  String get usernameTextFieldEmptyErrorMessage;

  /// Error message displayed when the username has an invalid format
  ///
  /// In en, this message translates to:
  /// **'Your username must be 1-20 characters long and can only contain letters, numbers, and the underscore (_).'**
  String get usernameTextFieldInvalidErrorMessage;

  /// Error message given when the username entered already exists in FavQs.com
  ///
  /// In en, this message translates to:
  /// **'This username is already taken.'**
  String get usernameTextFieldAlreadyTakenErrorMessage;

  /// Label of the email field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// Error message shown when the email text field has been left empty.
  ///
  /// In en, this message translates to:
  /// **'Your email can\'t be empty.'**
  String get emailTextFieldEmptyErrorMessage;

  /// Error message displayed when the email entered has an invalid format.
  ///
  /// In en, this message translates to:
  /// **'This email is not valid.'**
  String get emailTextFieldInvalidErrorMessage;

  /// Error message given when the entered email already exists in FavQs.com
  ///
  /// In en, this message translates to:
  /// **'This email is already registered.'**
  String get emailTextFieldAlreadyRegisteredErrorMessage;

  /// Label of the expansion tile that allows a user to start updating his password
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePasswordTileLabel;

  /// Label of the text field for inputing a new password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get passwordLabel;

  /// Error message displayed when the password entered doesn't meet the required validation standards.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least five characters long.'**
  String get passwordTextFieldInvalidErrorMessage;

  /// Label of the text field for confirming the new password entered.
  ///
  /// In en, this message translates to:
  /// **'New Password Confirmation'**
  String get passwordConfirmationLabel;

  /// Error message displayed when the passwords don't match.
  ///
  /// In en, this message translates to:
  /// **'Your passwords don\'t match.'**
  String get passwordConfirmationTextFieldInvalidErrorMessage;

  /// Label of the field for updating one's x username
  ///
  /// In en, this message translates to:
  /// **'X Username'**
  String get xUsernameLabel;

  /// Error message shown when the x username field has been left empty
  ///
  /// In en, this message translates to:
  /// **'Your X username can\'t be empty.'**
  String get xUsernameTextFieldEmptyErrorMessage;

  /// Error message displayed when the username has an invalid format
  ///
  /// In en, this message translates to:
  /// **'Your X username must be 4-15 characters long and can only contain letters, numbers, underscore (_) and the (@) symbol.'**
  String get xUsernameTextFieldInvalidErrorMessage;

  /// Label of the field for updating one's facebook username
  ///
  /// In en, this message translates to:
  /// **'Facebook Username'**
  String get facebookUsernameLabel;

  /// Error message shown when the facebook username field has been left empty
  ///
  /// In en, this message translates to:
  /// **'Your facebook username can\'t be empty.'**
  String get facebookUsernameTextFieldEmptyErrorMessage;

  /// Error message displayed when the username has an invalid format
  ///
  /// In en, this message translates to:
  /// **'Your facebook username must be 4-15 characters long and can only contain letters, numbers, underscore (_) and the (@) symbol.'**
  String get facebookUsernameTextFieldInvalidErrorMessage;

  /// Label of the tile that a user can use to enable/disable profane quotes
  ///
  /// In en, this message translates to:
  /// **'Profanity Filter'**
  String get profanityFilterTileLabel;

  /// Subtitle for enabling profane quotes to be fetched
  ///
  /// In en, this message translates to:
  /// **'Allow profane quotes to be displayed'**
  String get enableProfanityFilterSubtitle;

  /// Subtitle for disabling profane quotes
  ///
  /// In en, this message translates to:
  /// **'Disable profane quotes from being displayed'**
  String get disableProfanityFilterSubtitle;

  /// Label for the elevated button which a user taps to update his profile
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get updateProfileButtonLabel;

  /// Label of the number of followers for a given user.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get followersLabel;

  /// Label of the users followed by this user.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get followingLabel;

  /// Label of the public quotes that have been favorited by this user.
  ///
  /// In en, this message translates to:
  /// **'Public Favorites'**
  String get publicFavoritesLabel;

  /// Title of the ListTile for choosing to set profile picture from Facebook
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebookTitle;

  /// Subtitle for the ListTile to set profile picture from Facebook.
  ///
  /// In en, this message translates to:
  /// **'Set profile picture from Facebook'**
  String get setPicFromFacebookSubtitle;

  /// Error message displayed when a user tries to update his profile pic to Facebook but the facebookUsername field is empty
  ///
  /// In en, this message translates to:
  /// **'Oops, you haven\'t set your facebook username yet. Please update it then try again'**
  String get emptyFacebookUsernameErrorMessage;

  /// Title of the ListTile for choosing to set profile picture from Twitter-X
  ///
  /// In en, this message translates to:
  /// **'X'**
  String get xTitle;

  /// Subtitle for the ListTile to set profile picture from X.
  ///
  /// In en, this message translates to:
  /// **'Set profile picture from X'**
  String get setPicFromXSubtitle;

  /// Error message displayed when a user tries to update his profile pic to X but the xUsername field is empty.
  ///
  /// In en, this message translates to:
  /// **'Oops, you haven\'t set your X username yet. Please update it then try again'**
  String get emptyXUsernameErrorMessage;

  /// Title of the ListTile for choosing to set profile picture from email Gravater
  ///
  /// In en, this message translates to:
  /// **'Email Gravater'**
  String get emailGravaterTitle;

  /// Subtitle for the ListTile to set profile picture from Email Gravater.
  ///
  /// In en, this message translates to:
  /// **'Set profile picture from Email Gravater'**
  String get setPicFromEmailSubtitle;

  /// Error message displayed when a user tries to update his profile pic to Email Gravater but his email field is empty.
  ///
  /// In en, this message translates to:
  /// **'Oops, you haven\'t set Email Gravater yet. Please update it then try again'**
  String get emptyEmailGravaterErrorMessage;
}

class _ProfileMenuLocalizationsDelegate extends LocalizationsDelegate<ProfileMenuLocalizations> {
  const _ProfileMenuLocalizationsDelegate();

  @override
  Future<ProfileMenuLocalizations> load(Locale locale) {
    return SynchronousFuture<ProfileMenuLocalizations>(lookupProfileMenuLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'sw'].contains(locale.languageCode);

  @override
  bool shouldReload(_ProfileMenuLocalizationsDelegate old) => false;
}

ProfileMenuLocalizations lookupProfileMenuLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return ProfileMenuLocalizationsEn();
    case 'sw': return ProfileMenuLocalizationsSw();
  }

  throw FlutterError(
    'ProfileMenuLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
