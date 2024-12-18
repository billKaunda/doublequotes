import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'quote_list_localizations_en.dart';
import 'quote_list_localizations_sw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of QuoteListLocalizations
/// returned by `QuoteListLocalizations.of(context)`.
///
/// Applications need to include `QuoteListLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/quote_list_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: QuoteListLocalizations.localizationsDelegates,
///   supportedLocales: QuoteListLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the QuoteListLocalizations.supportedLocales
/// property.
abstract class QuoteListLocalizations {
  QuoteListLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static QuoteListLocalizations of(BuildContext context) {
    return Localizations.of<QuoteListLocalizations>(context, QuoteListLocalizations)!;
  }

  static const LocalizationsDelegate<QuoteListLocalizations> delegate = _QuoteListLocalizationsDelegate();

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

  /// Error message displayed when quote list cannot be refreshed.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t refresh your items.\nPlease check your internet connectivity and then try again.'**
  String get quoteListRefreshErrorMessage;

  /// Label for choice chip used to filter quotes by the user's favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favoritesChoiceChipLabel;

  /// Label of the choice chip to enable a user filter the quote list page by author.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get authorChoiceChipLabel;

  /// Label of the choice chip to filter the quote list page by tag
  ///
  /// In en, this message translates to:
  /// **'Tag'**
  String get tagChoiceChipLabel;

  /// Label of the choice chip to filter the quote list page by user
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userChoiceChipLabel;

  /// Label for choice chip used to filter quotes hidden by the user.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get hiddenChoiceChipLabel;

  /// Label for choice chip used to filter quote list page by the user's private quotes.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get privateChoiceChipLabel;

  /// Error message displayed if a quote doesn't have a body.
  ///
  /// In en, this message translates to:
  /// **'No Quote Body Found'**
  String get noQuoteBodyErrorMessage;

  /// Title of exception indicator displayed when there is an error loading the first page.
  ///
  /// In en, this message translates to:
  /// **'First Page Fetch Error'**
  String get firstPageFetchErrorMessageTitle;

  /// Message body of the exception indicator displayed when loading the first page.
  ///
  /// In en, this message translates to:
  /// **'Error loading the first page. Please, tap Try Again'**
  String get firstPageFetchErrorMessageBody;

  /// Error message displayed when requested action on a quote can only be performed by a pro user.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get proUserRequiredErrorMessage;
}

class _QuoteListLocalizationsDelegate extends LocalizationsDelegate<QuoteListLocalizations> {
  const _QuoteListLocalizationsDelegate();

  @override
  Future<QuoteListLocalizations> load(Locale locale) {
    return SynchronousFuture<QuoteListLocalizations>(lookupQuoteListLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'sw'].contains(locale.languageCode);

  @override
  bool shouldReload(_QuoteListLocalizationsDelegate old) => false;
}

QuoteListLocalizations lookupQuoteListLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return QuoteListLocalizationsEn();
    case 'sw': return QuoteListLocalizationsSw();
  }

  throw FlutterError(
    'QuoteListLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
