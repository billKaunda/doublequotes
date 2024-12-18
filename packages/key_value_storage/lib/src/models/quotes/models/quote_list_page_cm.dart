import 'package:hive_local_storage/hive_local_storage.dart';
import './quote_cm.dart';

part 'quote_list_page_cm.g.dart';

@HiveType(typeId: 9)
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
