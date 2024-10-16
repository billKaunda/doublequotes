import 'package:json_annotation/json_annotation.dart';
import './quote_rm.dart';

part 'quote_list_page_rm.g.dart';

@JsonSerializable(createToJson: false)
class QuoteListPageRM {
  const QuoteListPageRM({
    this.page,
    this.isLastPage,
    this.quotes,
  });

  @JsonKey(name: 'page')
  final int? page;
  
  @JsonKey(name: 'last_page')
  final bool? isLastPage;

  @JsonKey(name: 'quotes')
  final List<QuoteRM>? quotes;

  static const fromJson = _$QuoteListPageRMFromJson;
}
