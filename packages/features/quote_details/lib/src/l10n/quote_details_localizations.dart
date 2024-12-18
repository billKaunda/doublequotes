import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'quote_details_localizations_en.dart';
import 'quote_details_localizations_sw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of QuoteDetailsLocalizations
/// returned by `QuoteDetailsLocalizations.of(context)`.
///
/// Applications need to include `QuoteDetailsLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/quote_details_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: QuoteDetailsLocalizations.localizationsDelegates,
///   supportedLocales: QuoteDetailsLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the QuoteDetailsLocalizations.supportedLocales
/// property.
abstract class QuoteDetailsLocalizations {
  QuoteDetailsLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static QuoteDetailsLocalizations of(BuildContext context) {
    return Localizations.of<QuoteDetailsLocalizations>(context, QuoteDetailsLocalizations)!;
  }

  static const LocalizationsDelegate<QuoteDetailsLocalizations> delegate = _QuoteDetailsLocalizationsDelegate();

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

  /// Error message displayed if a selected quote cannot be found.
  ///
  /// In en, this message translates to:
  /// **'Quote Not Found'**
  String get quoteNotFoundErrorMessageTitle;

  /// The body of the quote not found error message showing that the requested quote can't be found.
  ///
  /// In en, this message translates to:
  /// **'Ooopss, the requested quote cannot be retrieved, please try again.'**
  String get quoteNotFoundErrorMessageBody;

  /// Label for the MenuItemButton which a user can tap to add a quote to FavQs.com
  ///
  /// In en, this message translates to:
  /// **'Add Quote'**
  String get addQuoteMenuItemButtonLabel;

  /// Label for the MenuItemButton which a user can tap to add personal tags to a quote.
  ///
  /// In en, this message translates to:
  /// **'Add tag to quote'**
  String get addTagToQuoteMenuItemButtonLabel;

  /// Label for the MenuItemButton which publicizes a quote on request.
  ///
  /// In en, this message translates to:
  /// **'Make quote public'**
  String get makeQuotePublicMenuItemButtonLabel;

  /// Label for the MenuItemButton which turns on the private field of the given quote.
  ///
  /// In en, this message translates to:
  /// **'Make quote private'**
  String get makeQuotePrivateMenuItemButtonLabel;

  /// Error message given if a pro user tries to unfav a private quote added by him.
  ///
  /// In en, this message translates to:
  /// **'Private quotes cannot be unfav\'d'**
  String get cannotUnfavPrivateQuoteErrorMessage;

  /// Error message displayed if the requested action can only be performed by a signed in user.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to continue'**
  String get userSessionNotFoundErrorMessage;

  /// Error message displayed when requested action on a quote can only be performed by a pro user.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get proUserRequiredErrorMessage;

  /// Error message shown when a quote cannot be added.
  ///
  /// In en, this message translates to:
  /// **'Ooopss, could not create quote'**
  String get couldNotCreateQuoteErrorMessage;

  /// Placeholder value when the author of a quote is null.
  ///
  /// In en, this message translates to:
  /// **'Unknown author'**
  String get unknownAuthorPlaceholder;

  /// Placeholder value when the body of a quote dialogue line is empty.
  ///
  /// In en, this message translates to:
  /// **'No content available'**
  String get noContentAvailablePlaceholder;
}

class _QuoteDetailsLocalizationsDelegate extends LocalizationsDelegate<QuoteDetailsLocalizations> {
  const _QuoteDetailsLocalizationsDelegate();

  @override
  Future<QuoteDetailsLocalizations> load(Locale locale) {
    return SynchronousFuture<QuoteDetailsLocalizations>(lookupQuoteDetailsLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'sw'].contains(locale.languageCode);

  @override
  bool shouldReload(_QuoteDetailsLocalizationsDelegate old) => false;
}

QuoteDetailsLocalizations lookupQuoteDetailsLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return QuoteDetailsLocalizationsEn();
    case 'sw': return QuoteDetailsLocalizationsSw();
  }

  throw FlutterError(
    'QuoteDetailsLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
