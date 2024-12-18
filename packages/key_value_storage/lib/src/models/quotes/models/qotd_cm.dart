import 'package:hive_local_storage/hive_local_storage.dart';
import './quote_cm.dart';

part 'qotd_cm.g.dart';

@HiveType(typeId: 7)
class QotdCM {
  const QotdCM({
    required this.date,
    required this.quote,
  });

  @HiveField(0)
  final String date;

  @HiveField(1)
  final QuoteCM quote;
}
