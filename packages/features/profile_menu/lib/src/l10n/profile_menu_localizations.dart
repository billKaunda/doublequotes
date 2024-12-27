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

  /// No description provided for @signedInUserGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hi {username} '**
  String signedInUserGreeting(String username);

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

  /// Title of the tile which a user can tap to update/modify his profile.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get updateProfileTitleLabel;

  /// Subtitle for the list tile that allows a user to update his profile when tapped.
  ///
  /// In en, this message translates to:
  /// **'Edit your profile'**
  String get updateProfileSubtitleLabel;

  /// Label for the tile which a user can tap to change theme settings for the app.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeSettingsTileLabel;

  /// Label for the tile to select the app's default theme settings.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultThemeTileLabel;

  /// Label for the tile to select theme as determined from the user's wallpaper.
  ///
  /// In en, this message translates to:
  /// **'Inspired by my wallpaper'**
  String get themeFromMyWallpaperTileLabel;

  /// Label of the list tile that allows a user to select his preffered language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageListTileLabel;

  /// Title of the simple dialog box that allows a user to choose his preferred language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languagePrefSimpleDialogTitle;

  /// Label of the tile to select English language.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get englishOptionTileLabel;

  /// Label of the tile to select Swahili language.
  ///
  /// In en, this message translates to:
  /// **'Swahili'**
  String get swahiliOptionTileLabel;

  /// Label of the list tile that allows a user to select his preffered dark mode settings.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode Preference'**
  String get darkModePreferencesListTileLabel;

  /// Title of the simple dialog box that allows a user to choose his dark mode preference.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode Preference'**
  String get darkModePrefSimpleDialogTitle;

  /// Label for the high contrast dark mode preference
  ///
  /// In en, this message translates to:
  /// **'High Contrast Dark'**
  String get highContrastDarkOptionLabel;

  /// Label for dark mode preference tile
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkOptionTileLabel;

  /// Label for light mode preference tile
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightOptionTileLabel;

  /// Label for high contrast light mode preference tile
  ///
  /// In en, this message translates to:
  /// **'High Contrast Light'**
  String get highContrastLightOptionTileLabel;

  /// Label for setting the dark mode preference according to the system settings.
  ///
  /// In en, this message translates to:
  /// **'Use System Settings'**
  String get useSystemSettingsOptionTileLabel;

  /// Label for the tile a user can tap to select his preferred language of choice.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTileLabel;

  /// Label for English language choice
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get englishLanguageOptionLabel;

  /// Label for Swahili language choice
  ///
  /// In en, this message translates to:
  /// **'Kiswahili'**
  String get swahiliLanguageOptionLabel;
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
