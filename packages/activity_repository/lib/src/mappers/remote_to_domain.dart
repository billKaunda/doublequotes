import 'package:fav_qs_api_v2/fav_qs_api_v2.dart';
import 'package:domain_models/domain_models.dart';

extension ActivityRMToDomain on ActivityRM {
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

extension ActivitiesListPageRMToDomain on ActivitiesListPageRM {
  ActivitiesListPage toDomainModel() {
    return ActivitiesListPage(
      activities:
          activities!.map((activity) => activity.toDomainModel()).toList(),
    );
  }
}

extension FollowersListPageRMToDomain on FollowersListPageRM {
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

extension FollowingItemRMToDomain on FollowingItemRM {
  FollowingItem toDomainModel() {
    return FollowingItem(
      followingType: followingType,
      followingId: followingId,
      followingValue: followingValue,
    );
  }
}

extension FollowingListPageRMToDomain on FollowingListPageRM {
  FollowingListPage toDomainModel() {
    return FollowingListPage(
      page: page,
      isLastPage: isLastPage,
      followingItems:
          followingItems!.map((item) => item.toDomainModel()).toList(),
    );
  }
}
