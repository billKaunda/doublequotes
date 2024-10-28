import 'package:hive_local_storage/hive_local_storage.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import './activity.dart';

/*
This class wraps [Hive] so that we can register all adapters and
manage all keys from a single place

To use this class, just unwrap one of its exposed boxes, like 
[quoteListPageBox], and execute operations in it, for example

(await activitiesListPageBox).clear();

Storing non-primitive types in Hive requires us to use incremental
[typeId]s. Having all these models and boxes in a single package
allows us avoid conflicts
*/

class ActivityKeyValueStorage {
  static const _activitiesListPageBoxKey = 'activity-list-pages';
  static const _followersListPageBoxKey = 'followers-list-pages';
  static const _followingListPageBoxKey = 'following-list-pages';

  ActivityKeyValueStorage({
    @visibleForTesting HiveInterface? hive,
  }) : _hive = hive ?? Hive {
    try {
      _hive
        ..registerAdapter(ActivitiesListPageCMAdapter())
        ..registerAdapter(ActivityCMAdapter())
        ..registerAdapter(FollowersListPageCMAdapter())
        ..registerAdapter(FollowingListPageCMAdapter())
        ..registerAdapter(FollowingItemCMAdapter());
    } catch (_) {
      throw Exception('Avoid having more than one [ActivityKeyValueStorage] '
          'instance in the project');
    }
  }

  final HiveInterface _hive;

  Future<Box<ActivitiesListPageCM>> get activitiesListPageBox =>
      _openActivityHiveBox<ActivitiesListPageCM>(_activitiesListPageBoxKey,
          isTemporary: true);

  Future<Box<FollowersListPageCM>> get followersListPageBox =>
      _openActivityHiveBox<FollowersListPageCM>(_followersListPageBoxKey,
          isTemporary: true);

  Future<Box<FollowingListPageCM>> get followingListPageBox =>
      _openActivityHiveBox<FollowingListPageCM>(_followingListPageBoxKey,
          isTemporary: true);

  Future<Box<E>> _openActivityHiveBox<E>(
    String boxKey, {
    required bool isTemporary,
  }) async {
    if (_hive.isBoxOpen(boxKey)) {
      return _hive.box(boxKey);
    } else {
      final directory = await (isTemporary
          ? getTemporaryDirectory()
          : getApplicationDocumentsDirectory());
      return _hive.openBox<E>(boxKey, path: directory.path);
    }
  }
}
