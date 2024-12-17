import 'component_library_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ComponentLibraryLocalizationsEn extends ComponentLibraryLocalizations {
  ComponentLibraryLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get downvoteIconButtonTooltip => 'Unlike';

  @override
  String get upvoteIconButtonTooltip => 'Like';

  @override
  String get searchBarHintText => 'journey';

  @override
  String get searchBarLabelText => 'Search';

  @override
  String get shareIconButtonTooltip => 'Share';

  @override
  String get favoriteIconButtonTooltip => 'Favorite';

  @override
  String get deleteIconButtonTooltip => 'Delete';

  @override
  String get editPicSourceIconButtonTooltip => 'Change Picture';

  @override
  String get hideIconButtonTooltip => 'Hide';

  @override
  String get exceptionIndicatorGenericTitle => 'Sorry, something went wrong';

  @override
  String get exceptionIndicatorTryAgainButton => 'Try Again';

  @override
  String get exceptionIndicatorGenericMessage => 'There has been an error.\nPlease, check your internet connection and then try again.';

  @override
  String get genericErrorSnackBarMessage => 'An error occured. Please, check you internet connection.';

  @override
  String get authenticationRequiredErrorSnackBarMessage => 'To perform this action, kindly sign in.';

  @override
  String get signInButtonLabel => 'Sign In';

  @override
  String get signOutButtonLabel => 'Sign Out';
}
