import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'sign_up_localizations_en.dart';
import 'sign_up_localizations_sw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of SignUpLocalizations
/// returned by `SignUpLocalizations.of(context)`.
///
/// Applications need to include `SignUpLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/sign_up_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: SignUpLocalizations.localizationsDelegates,
///   supportedLocales: SignUpLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the SignUpLocalizations.supportedLocales
/// property.
abstract class SignUpLocalizations {
  SignUpLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static SignUpLocalizations of(BuildContext context) {
    return Localizations.of<SignUpLocalizations>(context, SignUpLocalizations)!;
  }

  static const LocalizationsDelegate<SignUpLocalizations> delegate = _SignUpLocalizationsDelegate();

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

  /// Error message shown to the user if the email and/or password provided are invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid email and/or password.'**
  String get invalidCredentialsErrorMessage;

  /// Title of the app bar where users can sign up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get appBarTitle;

  /// Label for the button to request for a user sign up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpButtonLabel;

  /// Label for the username input field during a sign up form filling.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get usernameTextFieldLabel;

  /// Error message displayed to the user if the username field has been left empty.
  ///
  /// In en, this message translates to:
  /// **'Your username can\'t be empty'**
  String get usernameTextFieldEmptyErrorMessage;

  /// Error message show to the user when the username format is invalid.
  ///
  /// In en, this message translates to:
  /// **'Username can only be 1-20 characters long, and can contain letters, numbers, and the underscore only.'**
  String get usernameTextFieldInvalidErrorMessage;

  /// Error shown to the aspiring user if the username entered already exists in FavQs.com
  ///
  /// In en, this message translates to:
  /// **'This username is already taken.'**
  String get usernameTextFieldAlreadyTakenErrorMessage;

  /// Label for the email input field during a sign up form filling session.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailTextFieldLabel;

  /// Error message given when the email input field has been left empty.
  ///
  /// In en, this message translates to:
  /// **'Your email can\'t be empty.'**
  String get emailTextFieldEmptyErrorMessage;

  /// Error message shown when the email entered has an invalid format.
  ///
  /// In en, this message translates to:
  /// **'This email address is not valid.'**
  String get emailTextFieldInvalidErrorMessage;

  /// Error message displayed when the email provided already exists in FavQs.com
  ///
  /// In en, this message translates to:
  /// **'Sorry, this email is already registered with us.'**
  String get emailTextFieldAlreadyRegisteredErrorMessage;

  /// Label for password input field during a sign up form filling.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordTextFieldLabel;

  /// Error message given when the password input field has been left empty.
  ///
  /// In en, this message translates to:
  /// **'Your password can\'t be empty.'**
  String get passwordTextFieldEmptyErrorMessage;

  /// Error message shown when the password entered has an invalid format.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 5 characters long.'**
  String get passwordTextFieldInvalidErrorMessage;

  /// Label for password confirmation input field during a sign up form filling session.
  ///
  /// In en, this message translates to:
  /// **'Password Confirmation'**
  String get passwordConfirmationTextFieldLabel;

  /// Error message given when the password confirmation input field has been left empty.
  ///
  /// In en, this message translates to:
  /// **'This field can\'t be emtpy.'**
  String get passwordConfirmationTextFieldEmptyErrorMessage;

  /// Error message shown when the password entered in the password confirmation field has an invalid format or doesn't match the one in password field.
  ///
  /// In en, this message translates to:
  /// **'Your password don\'t match.'**
  String get passwordConfirmationTextFieldInvalidErrorMessage;
}

class _SignUpLocalizationsDelegate extends LocalizationsDelegate<SignUpLocalizations> {
  const _SignUpLocalizationsDelegate();

  @override
  Future<SignUpLocalizations> load(Locale locale) {
    return SynchronousFuture<SignUpLocalizations>(lookupSignUpLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'sw'].contains(locale.languageCode);

  @override
  bool shouldReload(_SignUpLocalizationsDelegate old) => false;
}

SignUpLocalizations lookupSignUpLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return SignUpLocalizationsEn();
    case 'sw': return SignUpLocalizationsSw();
  }

  throw FlutterError(
    'SignUpLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
