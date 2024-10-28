import 'package:hive_local_storage/hive_local_storage.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import 'quotes.dart';

class QuotesKeyValueStorage {
  static const _qotdBoxKey = 'qotd';
  static const _quoteListPageBoxKey = 'quote-list-pages';
  static const _favoritesListPageBoxKey = 'favorites-list-pages';

  QuotesKeyValueStorage({
    @visibleForTesting HiveInterface? hive,
  }) : _hive = hive ?? Hive {
    try {
      _hive
        ..registerAdapter(DialogueLinesCMAdapter())
        ..registerAdapter(QotdCMAdapter())
        ..registerAdapter(QuoteCMAdapter())
        ..registerAdapter(QuoteListPageCMAdapter())
        ..registerAdapter(UserDetailsCMAdapter());
    } catch (_) {
      throw Exception('Avoid having more than one [QuotesKeyValueStorage] '
          'instance in the project');
    }
  }

  final HiveInterface _hive;

  Future<Box<QotdCM>> get qotdBox =>
      _openQuotesHiveBox<QotdCM>(_qotdBoxKey, isTemporary: true);

  Future<Box<QuoteListPageCM>> get quoteListPageBox =>
      _openQuotesHiveBox<QuoteListPageCM>(_quoteListPageBoxKey,
          isTemporary: true);

  Future<Box<QuoteListPageCM>> get favoritesListPageBox =>
      _openQuotesHiveBox<QuoteListPageCM>(_favoritesListPageBoxKey,
          isTemporary: true);

  Future<Box<E>> _openQuotesHiveBox<E>(String boxKey,
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
