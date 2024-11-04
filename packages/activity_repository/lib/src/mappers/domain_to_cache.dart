import 'package:domain_models/domain_models.dart';
import 'package:key_value_storage/key_value_storage.dart';

extension ActivityDomainToCM on Activity {
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

extension ActivitiesListPageDomainToCM on ActivitiesListPage {
  ActivitiesListPageCM toCacheModel() {
    return ActivitiesListPageCM(
      activities:
          activities!.map((activity) => activity.toCacheModel()).toList(),
    );
  }
}

extension FollowersListPageDomainToCM on FollowersListPage {
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

extension FollowingItemDomainToCM on FollowingItem {
  FollowingItemCM toCacheModel() {
    return FollowingItemCM(
      followingType: followingType,
      followingId: followingId,
      followingValue: followingValue,
    );
  }
}

extension FollowingListPageDomainToCM on FollowingListPage{
  FollowingListPageCM toCacheModel() {
    return FollowingListPageCM(
      page: page,
      isLastPage: isLastPage,
      followingItems:
          followingItems!.map((item) => item.toCacheModel()).toList(),
    );
  }
}
