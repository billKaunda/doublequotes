import 'package:hive_local_storage/hive_local_storage.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import './typeahead.dart';

class TypeaheadKeyValueStorage {
  static const _typeaheadBoxKey = 'typeahead';

  TypeaheadKeyValueStorage({
    @visibleForTesting HiveInterface? hive,
  }) : _hive = hive ?? Hive {
    try {
      _hive
        ..registerAdapter(FilterDetailsCMAdapter())
        ..registerAdapter(TypeaheadCMAdapter());
    } catch (_) {
      throw Exception('Avoid having more than one [TypeaheadKeyValueStorage] '
          'instance in the project');
    }
  }

  final HiveInterface _hive;

  Future<Box<TypeaheadCM>> get typeaheadBox =>
      _openTypeaheadHiveBox<TypeaheadCM>(_typeaheadBoxKey, isTemporary: true);

  Future<Box<E>> _openTypeaheadHiveBox<E>(String boxKey,
      {required bool isTemporary}) async {
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
