import 'activity_list_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ActivityListLocalizationsEn extends ActivityListLocalizations {
  ActivityListLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get activityListRefreshErrorMessage => 'We couldn\'t refresh your items.\nPlease check your internet and then try again.';

  @override
  String get authorChoiceChipLabel => 'Author';

  @override
  String get tagChoiceChipLabel => 'Tag';

  @override
  String get userChoiceChipLabel => 'User';

  @override
  String get followersChoiceChipLabel => 'Followers';

  @override
  String get noActivityBodyErrorMessage => 'No Activity Body Found';

  @override
  String get firstPageFetchErrorMessageTitle => 'First Page Fetch Error';

  @override
  String get firstPageFetchErrorMessageBody => 'Error loading the first page. Please, tap Try Again';

  @override
  String get activityOwnerTypeMissing => 'OwnerType Is Missing';

  @override
  String get activityOwnerNotFound => 'OwnerValue Not Found';

  @override
  String get activityActionNotFound => 'No action found on this activity';

  @override
  String get activityTrackableTypeMissing => 'TrackableType Missing';

  @override
  String get trackableValueNotFound => 'TrackableValue Not Found';

  @override
  String get activityMessageBodyNotFound => 'Message Body Empty';

  @override
  String get customAlertDialogTitle => 'Delete Activity';

  @override
  String customAlertDialogContent(String trackableType, String action, String ownerValue) {
    return 'Are you sure you want to delete this $trackableType activity $action by $ownerValue';
  }

  @override
  String get cancelButtonLabel => 'Cancel';

  @override
  String get deleteButtonLabel => 'Delete';
}
