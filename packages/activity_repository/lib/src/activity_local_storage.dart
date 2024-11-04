import 'package:key_value_storage/key_value_storage.dart';

class ActivityLocalStorage {
  ActivityLocalStorage({
    required this.activityKeyValueStorage,
  });

  final ActivityKeyValueStorage activityKeyValueStorage;

  Future<void> upsertActivitiesListPage(
    int page,
    ActivitiesListPageCM activitiesListPageCM,
  ) async {
    final box = await activityKeyValueStorage.activitiesListPageBox;
    return box.put(page, activitiesListPageCM);
  }

  Future<void> upsertFollowersListPage(
    int page,
    FollowersListPageCM followersListPageCM,
  ) async {
    final box = await activityKeyValueStorage.followersListPageBox;
    return box.put(page, followersListPageCM);
  }

  Future<void> upsertFollowingListPage(
    int page,
    FollowingListPageCM followingListPageCM,
  ) async {
    final box = await activityKeyValueStorage.followingListPageBox;
    return box.put(page, followingListPageCM);
  }

  Future<ActivitiesListPageCM?> getActivitiesListPage(int page) async {
    final box = await activityKeyValueStorage.activitiesListPageBox;
    return box.get(page);
  }

  Future<ActivityCM?> getActivity(int activityId) async {
    final activityBox = await activityKeyValueStorage.activitiesListPageBox;
    final activitiesList =
        [...activityBox.values].expand((eachList) => eachList.activities!);

    try {
      return activitiesList
          .firstWhere((activity) => activity.activityId == activityId);
    } catch (_) {
      return null;
    }
  }

  Future<FollowersListPageCM?> getFollowersListPage(int page) async {
    final box = await activityKeyValueStorage.followersListPageBox;
    return box.get(page);
  }

  Future<FollowingListPageCM?> getFollowingListPage(int page) async {
    final box = await activityKeyValueStorage.followingListPageBox;
    return box.get(page);
  }

  Future<void> clearActivitiesListPageList() async {
    final box = await activityKeyValueStorage.activitiesListPageBox;
    await box.clear();
  }

  Future<void> clearFollowersListPageList() async {
    final box = await activityKeyValueStorage.followersListPageBox;
    await box.clear();
  }

  Future<void> clearFollowingListPageList() async {
    final box = await activityKeyValueStorage.followingListPageBox;
    await box.clear();
  }

  Future<void> clear() async {
    await Future.wait([
      activityKeyValueStorage.activitiesListPageBox.then(
        (box) => box.clear(),
      ),
      activityKeyValueStorage.followersListPageBox.then(
        (box) => box.clear(),
      ),
      activityKeyValueStorage.followingListPageBox.then(
        (box) => box.clear(),
      ),
    ]);
  }

  Future<void> deleteActivity(int activityId) async {
    final activity = await getActivity(activityId);

    if (activity != null) {
      try {
        await activityKeyValueStorage.activitiesListPageBox.then((box) async {
          for (var page in box.values) {
            page.activities?.removeWhere(
              (activity) => activity.activityId == activityId,
            );
          }
        });
      } catch (_) {}
    } else {
      return;
    }
  }
}
