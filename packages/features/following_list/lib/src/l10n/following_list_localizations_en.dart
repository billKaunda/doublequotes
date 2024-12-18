import 'following_list_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class FollowingListLocalizationsEn extends FollowingListLocalizations {
  FollowingListLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get followingListRefreshErrorMessage => 'We couldn\'t refresh your items.\nPlease check your internet connectivity and then try again.';

  @override
  String get userChoiceChipLabel => 'User';

  @override
  String get firstPageFetchErrorMessageTitle => 'First Page Fetch Error';

  @override
  String get firstPageFetchErrorMessageBody => 'Error loading the first page. Please, tap Try Again';

  @override
  String get authorListTileSubtitle => 'Author';

  @override
  String get tagListTileSubtitle => 'Tag';

  @override
  String get userListTileSubtitle => 'User';
}
