import 'package:key_value_storage/key_value_storage.dart';
import 'package:domain_models/domain_models.dart';

extension ActivityCMToDomain on ActivityCM {
  Activity toDomainModel() {
    return Activity(
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

extension ActivitiesListPageCMToDomain on ActivitiesListPageCM {
  ActivitiesListPage toDomainModel() {
    return ActivitiesListPage(
      activities:
          activities!.map((activity) => activity.toDomainModel()).toList(),
    );
  }
}

extension FollowersListPageCMToDomain on FollowersListPageCM {
  FollowersListPage toDomainModel() {
    return FollowersListPage(
      page: page,
      isLastPage: isLastPage,
      users: users,
      authors: authors,
      tags: tags,
    );
  }
}

extension FollowingItemCMToDomain on FollowingItemCM {
  FollowingItem toDomainModel() {
    return FollowingItem(
      followingType: followingType,
      followingId: followingId,
      followingValue: followingValue,
    );
  }
}

extension FollowingListPageCMToDomain on FollowingListPageCM {
  FollowingListPage toDomainModel() {
    return FollowingListPage(
      page: page,
      isLastPage: isLastPage,
      followingItems:
          followingItems!.map((item) => item.toDomainModel()).toList(),
    );
  }
}
