import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'forgot_my_password_localizations_en.dart';
import 'forgot_my_password_localizations_sw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ForgotMyPasswordLocalizations
/// returned by `ForgotMyPasswordLocalizations.of(context)`.
///
/// Applications need to include `ForgotMyPasswordLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/forgot_my_password_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ForgotMyPasswordLocalizations.localizationsDelegates,
///   supportedLocales: ForgotMyPasswordLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the ForgotMyPasswordLocalizations.supportedLocales
/// property.
abstract class ForgotMyPasswordLocalizations {
  ForgotMyPasswordLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ForgotMyPasswordLocalizations of(BuildContext context) {
    return Localizations.of<ForgotMyPasswordLocalizations>(context, ForgotMyPasswordLocalizations)!;
  }

  static const LocalizationsDelegate<ForgotMyPasswordLocalizations> delegate = _ForgotMyPasswordLocalizationsDelegate();

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

  /// Title of dialog where users can request a password reset.
  ///
  /// In en, this message translates to:
  /// **'Forgot My Password'**
  String get dialogTitle;

  /// Label for the email input field in the password reset dialog.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailTextFieldLabel;

  /// Error message displayed when the email field is left empty.
  ///
  /// In en, this message translates to:
  /// **'Your email can\'t be empty.'**
  String get emailTextFieldEmptyErrorMessage;

  /// Error message displayed when the email format is invalid.
  ///
  /// In en, this message translates to:
  /// **'This email is not valid.'**
  String get emailTextFieldInvalidErrorMessage;

  /// Message shown to users when a password reset link is successfully requested
  ///
  /// In en, this message translates to:
  /// **'If you have registered your email with us, a link will be sent to you with instructions on how to reset your password.'**
  String get emailRequestSuccessMessage;

  /// Label for the confirmation button to submit the password reset request.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButtonLabel;

  /// Label for the button to cancel password reset dialog box.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButtonLabel;

  /// General error shown when there is a network or any other error.
  ///
  /// In en, this message translates to:
  /// **'An error occured. Please, check your internet connection.'**
  String get errorMessage;
}

class _ForgotMyPasswordLocalizationsDelegate extends LocalizationsDelegate<ForgotMyPasswordLocalizations> {
  const _ForgotMyPasswordLocalizationsDelegate();

  @override
  Future<ForgotMyPasswordLocalizations> load(Locale locale) {
    return SynchronousFuture<ForgotMyPasswordLocalizations>(lookupForgotMyPasswordLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'sw'].contains(locale.languageCode);

  @override
  bool shouldReload(_ForgotMyPasswordLocalizationsDelegate old) => false;
}

ForgotMyPasswordLocalizations lookupForgotMyPasswordLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return ForgotMyPasswordLocalizationsEn();
    case 'sw': return ForgotMyPasswordLocalizationsSw();
  }

  throw FlutterError(
    'ForgotMyPasswordLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
