import 'package:hive/hive.dart';
import './quote_cm.dart';

part 'qotd_cm.g.dart';

@HiveType(typeId: 11)
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
