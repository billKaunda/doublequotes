import 'followers_list_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class FollowersListLocalizationsEn extends FollowersListLocalizations {
  FollowersListLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get followersListRefreshErrorMessage => 'We couldn\'t refresh your items.\nPlease check your internet connectivity and then try again.';

  @override
  String get firstPageFetchErrorMessageTitle => 'First Page Fetch Error';

  @override
  String get firstPageFetchErrorMessageBody => 'Error loading the first page. Please, tap Try Again';

  @override
  String get authorChoiceChipLabel => 'Author';

  @override
  String get tagChoiceChipLabel => 'Tag';

  @override
  String get userChoiceChipLabel => 'User';
}
