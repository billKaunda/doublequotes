import 'followers_list_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class FollowersListLocalizationsSw extends FollowersListLocalizations {
  FollowersListLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get followersListRefreshErrorMessage => 'Hatukuweza kuonyesha upya vipengee vyako.\nTafadhali angalia muunganisho wako wa mtandao kisha ujaribu tena.';

  @override
  String get firstPageFetchErrorMessageTitle => 'Hitilafu ya Kuleta Ukurasa wa Kwanza';

  @override
  String get firstPageFetchErrorMessageBody => 'Hitilafu katika kupakia ukurasa wa kwanza. Tafadhali, jaribu tena';

  @override
  String get authorChoiceChipLabel => 'Mwandishi';

  @override
  String get tagChoiceChipLabel => 'Tagi';

  @override
  String get userChoiceChipLabel => 'Mtumiaji';
}
