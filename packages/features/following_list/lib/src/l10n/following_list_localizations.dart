import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'following_list_localizations_en.dart';
import 'following_list_localizations_sw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of FollowingListLocalizations
/// returned by `FollowingListLocalizations.of(context)`.
///
/// Applications need to include `FollowingListLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/following_list_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: FollowingListLocalizations.localizationsDelegates,
///   supportedLocales: FollowingListLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the FollowingListLocalizations.supportedLocales
/// property.
abstract class FollowingListLocalizations {
  FollowingListLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static FollowingListLocalizations of(BuildContext context) {
    return Localizations.of<FollowingListLocalizations>(context, FollowingListLocalizations)!;
  }

  static const LocalizationsDelegate<FollowingListLocalizations> delegate = _FollowingListLocalizationsDelegate();

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

  /// Error message displayed when following list cannot be refreshed.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t refresh your items.\nPlease check your internet connectivity and then try again.'**
  String get followingListRefreshErrorMessage;

  /// Label of the choice chip to filter the activity list page by user
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userChoiceChipLabel;

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

  /// Subtitle of the list tile for an author following a user.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get authorListTileSubtitle;

  /// Subtitle of the list tile for a given tag following a user.
  ///
  /// In en, this message translates to:
  /// **'Tag'**
  String get tagListTileSubtitle;

  /// Subtitle of the list tile for a user following a user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userListTileSubtitle;
}

class _FollowingListLocalizationsDelegate extends LocalizationsDelegate<FollowingListLocalizations> {
  const _FollowingListLocalizationsDelegate();

  @override
  Future<FollowingListLocalizations> load(Locale locale) {
    return SynchronousFuture<FollowingListLocalizations>(lookupFollowingListLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'sw'].contains(locale.languageCode);

  @override
  bool shouldReload(_FollowingListLocalizationsDelegate old) => false;
}

FollowingListLocalizations lookupFollowingListLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return FollowingListLocalizationsEn();
    case 'sw': return FollowingListLocalizationsSw();
  }

  throw FlutterError(
    'FollowingListLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
