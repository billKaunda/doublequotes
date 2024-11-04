import 'package:fav_qs_api_v2/fav_qs_api_v2.dart';
import 'package:key_value_storage/key_value_storage.dart';

extension ActivityRMToCM on ActivityRM {
  ActivityCM toCacheModel() {
    return ActivityCM(
      activityId: activityId,
      ownerType: ownerType,
      ownerId: ownerId,
      ownerValue: ownerValue,
      action: action,
      trackableType: trackableType,
      trackableId: trackableId,
      trackableValue: trackableValue,
    );
  }
}

extension ActivitiesListPageRMToCM on ActivitiesListPageRM {
  ActivitiesListPageCM toCacheModel() {
    return ActivitiesListPageCM(
      activities:
          activities!.map((activity) => activity.toCacheModel()).toList(),
    );
  }
}

extension FollowersListPageRMToCM on FollowersListPageRM {
  FollowersListPageCM toCacheModel() {
    return FollowersListPageCM(
      page: page,
      isLastPage: isLastPage,
      users: users,
      authors: authors,
      tags: tags,
    );
  }
}

extension FollowingItemRMToCM on FollowingItemRM {
  FollowingItemCM toCacheModel() {
    return FollowingItemCM(
      followingType: followingType,
      followingId: followingId,
      followingValue: followingValue,
    );
  }
}

extension FollowingListPageRMToCM on FollowingListPageRM {
  FollowingListPageCM toCacheModel() {
    return FollowingListPageCM(
      page: page,
      isLastPage: isLastPage,
      followingItems: followingItems!.map((item) => item.toCacheModel()).toList(),
    );
  }
}
