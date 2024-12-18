import 'activity_list_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class ActivityListLocalizationsSw extends ActivityListLocalizations {
  ActivityListLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get activityListRefreshErrorMessage => 'Hatukuweza kuonyesha upya vipengee vyako.\nTafadhali angalia muunganisho wako wa mtandao kisha ujaribu tena.';

  @override
  String get authorChoiceChipLabel => 'Mwandishi';

  @override
  String get tagChoiceChipLabel => 'Tagi';

  @override
  String get userChoiceChipLabel => 'Mtumiaji';

  @override
  String get followersChoiceChipLabel => 'Wafuasi';

  @override
  String get noActivityBodyErrorMessage => 'Hakuna Mwili wa Shughuli uliopatikana';

  @override
  String get firstPageFetchErrorMessageTitle => 'Hitilafu ya Kuleta Ukurasa wa Kwanza';

  @override
  String get firstPageFetchErrorMessageBody => 'Hitilafu katika kupakia ukurasa wa kwanza. Tafadhali, jaribu tena.';

  @override
  String get activityOwnerTypeMissing => 'Aina ya Mmiliki Haipo';

  @override
  String get activityOwnerNotFound => 'Thamani ya Mmiliki Haijapatikana';

  @override
  String get activityActionNotFound => 'Hakuna kitendo kilichopatikana kwenye shughuli hii';

  @override
  String get activityTrackableTypeMissing => 'Aina Inayofuatiliwa Haipo';

  @override
  String get trackableValueNotFound => 'Thamani Inayoweza Kufuatiliwa Haijapatikana';

  @override
  String get activityMessageBodyNotFound => 'Mwili wa Ujumbe Utupu';

  @override
  String get customAlertDialogTitle => 'Futa Shughuli';

  @override
  String customAlertDialogContent(String trackableType, String action, String ownerValue) {
    return 'Je, una uhakika unataka kufuta shughuli hii ya $trackableType ya $ownerValue';
  }

  @override
  String get cancelButtonLabel => 'Ghairi';

  @override
  String get deleteButtonLabel => 'Futa';
}
