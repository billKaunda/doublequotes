part of 'activity_list_bloc.dart';

abstract class ActivityListEvent extends Equatable {
  const ActivityListEvent();

  @override
  List<Object?> get props => [];
}

class ActivityListTypeLookupChanged extends ActivityListEvent {
  const ActivityListTypeLookupChanged({
    this.typeLookup,
  });

  final TypeLookup? typeLookup;

  @override
  List<Object?> get props => [
        typeLookup,
      ];
}

class ActivityListSearchTermChanged extends ActivityListEvent {
  const ActivityListSearchTermChanged(
    this.searchTerm,
  );

  final String searchTerm;

  @override
  List<Object?> get props => [
        searchTerm,
      ];
}

class ActivityListRefreshed extends ActivityListEvent {
  const ActivityListRefreshed();
}

class ActivityListNextPageRequested extends ActivityListEvent {
  const ActivityListNextPageRequested({
    required this.pageNumber,
  });

  final int pageNumber;

  @override
  List<Object?> get props => [
        pageNumber,
      ];
}

class ActivityListFailedFetchRetried extends ActivityListEvent {
  const ActivityListFailedFetchRetried();
}

class ActivityListUsernameObtained extends ActivityListEvent {
  const ActivityListUsernameObtained();
}

class ActivityListItemUpdated extends ActivityListEvent {
  const ActivityListItemUpdated(this.updatedActivity);

  final Activity updatedActivity;
}

class ActivityListItemDeleteRequest extends ActivityListEvent {
  ActivityListItemDeleteRequest(
    this.activityId,
  );

  final int activityId;
  @override
  List<Object?> get props => [
        activityId,
      ];
}
