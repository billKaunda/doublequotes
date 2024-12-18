import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'followers_list_localizations_en.dart';
import 'followers_list_localizations_sw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of FollowersListLocalizations
/// returned by `FollowersListLocalizations.of(context)`.
///
/// Applications need to include `FollowersListLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/followers_list_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: FollowersListLocalizations.localizationsDelegates,
///   supportedLocales: FollowersListLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the FollowersListLocalizations.supportedLocales
/// property.
abstract class FollowersListLocalizations {
  FollowersListLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static FollowersListLocalizations of(BuildContext context) {
    return Localizations.of<FollowersListLocalizations>(context, FollowersListLocalizations)!;
  }

  static const LocalizationsDelegate<FollowersListLocalizations> delegate = _FollowersListLocalizationsDelegate();

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

  /// Error message displayed when the followers list cannot be refreshed.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t refresh your items.\nPlease check your internet connectivity and then try again.'**
  String get followersListRefreshErrorMessage;

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

  /// Label of the choice chip to enable a user filter the activity list page by author.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get authorChoiceChipLabel;

  /// Label of the choice chip to filter the activity list page by tag
  ///
  /// In en, this message translates to:
  /// **'Tag'**
  String get tagChoiceChipLabel;

  /// Label of the choice chip to filter the activity list page by user
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userChoiceChipLabel;
}

class _FollowersListLocalizationsDelegate extends LocalizationsDelegate<FollowersListLocalizations> {
  const _FollowersListLocalizationsDelegate();

  @override
  Future<FollowersListLocalizations> load(Locale locale) {
    return SynchronousFuture<FollowersListLocalizations>(lookupFollowersListLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'sw'].contains(locale.languageCode);

  @override
  bool shouldReload(_FollowersListLocalizationsDelegate old) => false;
}

FollowersListLocalizations lookupFollowersListLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return FollowersListLocalizationsEn();
    case 'sw': return FollowersListLocalizationsSw();
  }

  throw FlutterError(
    'FollowersListLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
