import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import './dark_mode_preference.dart';

class DarkModePrefKVStorage {
  static const _darkModePreferenceBoxKey = 'dark-mode-preference';

  DarkModePrefKVStorage({
    @visibleForTesting HiveInterface? hive,
  }) : _hive = hive ?? Hive {
    try {
      _hive..registerAdapter(DarkModePreferenceCMAdapter());
    } catch (_) {
      throw Exception(
          'Avoid having more than one [DarkModePrefKeyValueStorage] '
          'instance in the project');
    }
  }

  final HiveInterface _hive;

  Future<Box<DarkModePreferenceCM>> get darkModePreferenceBox =>
      _openDarkModeHiveBox<DarkModePreferenceCM>(_darkModePreferenceBoxKey,
          isTemporary: false);

  Future<Box<E>> _openDarkModeHiveBox<E>(
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
