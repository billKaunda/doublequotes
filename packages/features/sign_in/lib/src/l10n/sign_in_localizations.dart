import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'sign_in_localizations_en.dart';
import 'sign_in_localizations_sw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of SignInLocalizations
/// returned by `SignInLocalizations.of(context)`.
///
/// Applications need to include `SignInLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/sign_in_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: SignInLocalizations.localizationsDelegates,
///   supportedLocales: SignInLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the SignInLocalizations.supportedLocales
/// property.
abstract class SignInLocalizations {
  SignInLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static SignInLocalizations of(BuildContext context) {
    return Localizations.of<SignInLocalizations>(context, SignInLocalizations)!;
  }

  static const LocalizationsDelegate<SignInLocalizations> delegate = _SignInLocalizationsDelegate();

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

  /// Error message displayed if the user's account is not active.
  ///
  /// In en, this message translates to:
  /// **'Username is not active. Contact support@favqs.com'**
  String get inactiveUsernameErrorMessage;

  /// Error message shown when the username or password field is missing during submission.
  ///
  /// In en, this message translates to:
  /// **'Username or password is missing'**
  String get missingCredentialsErrorMessage;

  /// Error message given when a user session is missing in FavQs.com
  ///
  /// In en, this message translates to:
  /// **'User session not found'**
  String get sessionNotFoundErrorMessage;

  /// Error message displayed when a user is cannot be retrieved from FavQs.com
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get userNotFoundErrorMessage;

  /// Title of the appBar where a user can sign in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get appBarTitle;

  /// Lable of the email address input field.
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
  /// **'This email is not valid.'**
  String get emailTextFieldInvalidErrorMessage;

  /// Label for password input field during a sign in form filling.
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

  /// Label for the forgot password button which a user can tap to retrieve his password.
  ///
  /// In en, this message translates to:
  /// **'Forgot my password'**
  String get forgotMyPasswordButtonLabel;

  /// Label for the sign in button which a user taps to sign into the app.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInButtonLabel;

  /// A text message that asks the user if he has an account or not.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Click here'**
  String get signUpOpeningText;

  /// Label for the sign up button that a visitor can tap to open an account in FavQs.com
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpButtonLabel;
}

class _SignInLocalizationsDelegate extends LocalizationsDelegate<SignInLocalizations> {
  const _SignInLocalizationsDelegate();

  @override
  Future<SignInLocalizations> load(Locale locale) {
    return SynchronousFuture<SignInLocalizations>(lookupSignInLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'sw'].contains(locale.languageCode);

  @override
  bool shouldReload(_SignInLocalizationsDelegate old) => false;
}

SignInLocalizations lookupSignInLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return SignInLocalizationsEn();
    case 'sw': return SignInLocalizationsSw();
  }

  throw FlutterError(
    'SignInLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
