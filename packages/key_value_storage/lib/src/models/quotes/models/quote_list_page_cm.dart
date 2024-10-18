import 'package:hive/hive.dart';
import './quote_cm.dart';

part 'quote_list_page_cm.g.dart';

@HiveType(typeId: 10)
class QuoteListPageCM {
  const QuoteListPageCM({
    this.page,
    this.isLastPage,
    this.quotes,
  });

  @HiveField(0)
  final int? page;

  @HiveField(1)
  final bool? isLastPage;

  @HiveField(2)
  final List<QuoteCM>? quotes;
}
