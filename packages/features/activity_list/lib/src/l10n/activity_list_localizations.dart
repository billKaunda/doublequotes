import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'activity_list_localizations_en.dart';
import 'activity_list_localizations_sw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ActivityListLocalizations
/// returned by `ActivityListLocalizations.of(context)`.
///
/// Applications need to include `ActivityListLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/activity_list_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ActivityListLocalizations.localizationsDelegates,
///   supportedLocales: ActivityListLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the ActivityListLocalizations.supportedLocales
/// property.
abstract class ActivityListLocalizations {
  ActivityListLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ActivityListLocalizations of(BuildContext context) {
    return Localizations.of<ActivityListLocalizations>(context, ActivityListLocalizations)!;
  }

  static const LocalizationsDelegate<ActivityListLocalizations> delegate = _ActivityListLocalizationsDelegate();

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

  /// Error message displayed when activity list cannot be refreshed.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t refresh your items.\nPlease check your internet and then try again.'**
  String get activityListRefreshErrorMessage;

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

  /// Label of the choice chip to get followers for a user, tag, or author.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get followersChoiceChipLabel;

  /// Error message displayed if an activity doesn't have a body.
  ///
  /// In en, this message translates to:
  /// **'No Activity Body Found'**
  String get noActivityBodyErrorMessage;

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

  /// Error message displayed when the activity ownerType field is null
  ///
  /// In en, this message translates to:
  /// **'OwnerType Is Missing'**
  String get activityOwnerTypeMissing;

  /// Error message shown when the field for owner_value of an activity is not found.
  ///
  /// In en, this message translates to:
  /// **'OwnerValue Not Found'**
  String get activityOwnerNotFound;

  /// Error message shown when the there is no action that has been performed by the user on the given activity
  ///
  /// In en, this message translates to:
  /// **'No action found on this activity'**
  String get activityActionNotFound;

  /// Error message shown when the trackable type of an activity is missing
  ///
  /// In en, this message translates to:
  /// **'TrackableType Missing'**
  String get activityTrackableTypeMissing;

  /// Error message displayed when the field for trackable_value is not found
  ///
  /// In en, this message translates to:
  /// **'TrackableValue Not Found'**
  String get trackableValueNotFound;

  /// Error message shown when the message body for an activity is missing
  ///
  /// In en, this message translates to:
  /// **'Message Body Empty'**
  String get activityMessageBodyNotFound;

  /// Title of the alert dialog displayed when a user wants to delete an activity
  ///
  /// In en, this message translates to:
  /// **'Delete Activity'**
  String get customAlertDialogTitle;

  /// Message body of the alert dialog to delete a given activity
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this {trackableType} activity {action} by {ownerValue}'**
  String customAlertDialogContent(String trackableType, String action, String ownerValue);

  /// Label for the button which when pressed pops off the AlertDialog and return the user to the activity list page.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButtonLabel;

  /// Label for the button to delete an activity
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButtonLabel;
}

class _ActivityListLocalizationsDelegate extends LocalizationsDelegate<ActivityListLocalizations> {
  const _ActivityListLocalizationsDelegate();

  @override
  Future<ActivityListLocalizations> load(Locale locale) {
    return SynchronousFuture<ActivityListLocalizations>(lookupActivityListLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'sw'].contains(locale.languageCode);

  @override
  bool shouldReload(_ActivityListLocalizationsDelegate old) => false;
}

ActivityListLocalizations lookupActivityListLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return ActivityListLocalizationsEn();
    case 'sw': return ActivityListLocalizationsSw();
  }

  throw FlutterError(
    'ActivityListLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
