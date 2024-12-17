import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'component_library_localizations_en.dart';
import 'component_library_localizations_sw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ComponentLibraryLocalizations
/// returned by `ComponentLibraryLocalizations.of(context)`.
///
/// Applications need to include `ComponentLibraryLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/component_library_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ComponentLibraryLocalizations.localizationsDelegates,
///   supportedLocales: ComponentLibraryLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the ComponentLibraryLocalizations.supportedLocales
/// property.
abstract class ComponentLibraryLocalizations {
  ComponentLibraryLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ComponentLibraryLocalizations of(BuildContext context) {
    return Localizations.of<ComponentLibraryLocalizations>(context, ComponentLibraryLocalizations)!;
  }

  static const LocalizationsDelegate<ComponentLibraryLocalizations> delegate = _ComponentLibraryLocalizationsDelegate();

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

  /// Tooltip for the icon button if the user doesn't like the selected quote.
  ///
  /// In en, this message translates to:
  /// **'Unlike'**
  String get downvoteIconButtonTooltip;

  /// Tooltip for the icon button if a user want to upvote a quote.
  ///
  /// In en, this message translates to:
  /// **'Like'**
  String get upvoteIconButtonTooltip;

  /// Placeholder for the seach bar hint text.
  ///
  /// In en, this message translates to:
  /// **'journey'**
  String get searchBarHintText;

  /// Label text for the input field where a user can enter filter arguments to perform a search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchBarLabelText;

  /// Tooltip for the button which allows a user to share a given quote to other apps.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareIconButtonTooltip;

  /// Tooltip for the button which marks a quote as favorite by a given user.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favoriteIconButtonTooltip;

  /// Tooltip for the button to delete the selected quote
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteIconButtonTooltip;

  /// Tooltip for the button to update the profile picture source.
  ///
  /// In en, this message translates to:
  /// **'Change Picture'**
  String get editPicSourceIconButtonTooltip;

  /// Tooltip for the button to hide the selected quote
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get hideIconButtonTooltip;

  /// Title of the exception indicator displayed when trying to fetch quote details.
  ///
  /// In en, this message translates to:
  /// **'Sorry, something went wrong'**
  String get exceptionIndicatorGenericTitle;

  /// Label for the try again button of the exception indicator.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get exceptionIndicatorTryAgainButton;

  /// Error messsage displayed when something goes wrong when trying to fetch quote detials.
  ///
  /// In en, this message translates to:
  /// **'There has been an error.\nPlease, check your internet connection and then try again.'**
  String get exceptionIndicatorGenericMessage;

  /// Generic Error message given in the snackbar.
  ///
  /// In en, this message translates to:
  /// **'An error occured. Please, check you internet connection.'**
  String get genericErrorSnackBarMessage;

  /// Error message requiring the user to sign in in order to proceed with the given request.
  ///
  /// In en, this message translates to:
  /// **'To perform this action, kindly sign in.'**
  String get authenticationRequiredErrorSnackBarMessage;

  /// Label for the sign in button which a user taps to sign into the app.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButtonLabel;

  /// Label for the sign out button that a user can tap to end his session in FavQs.com
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOutButtonLabel;
}

class _ComponentLibraryLocalizationsDelegate extends LocalizationsDelegate<ComponentLibraryLocalizations> {
  const _ComponentLibraryLocalizationsDelegate();

  @override
  Future<ComponentLibraryLocalizations> load(Locale locale) {
    return SynchronousFuture<ComponentLibraryLocalizations>(lookupComponentLibraryLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'sw'].contains(locale.languageCode);

  @override
  bool shouldReload(_ComponentLibraryLocalizationsDelegate old) => false;
}

ComponentLibraryLocalizations lookupComponentLibraryLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return ComponentLibraryLocalizationsEn();
    case 'sw': return ComponentLibraryLocalizationsSw();
  }

  throw FlutterError(
    'ComponentLibraryLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
