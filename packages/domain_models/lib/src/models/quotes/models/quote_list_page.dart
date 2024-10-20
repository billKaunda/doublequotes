import 'package:equatable/equatable.dart';
import './quote.dart';

class QuoteListPage extends Equatable {
  const QuoteListPage({
    this.page,
    this.isLastPage,
    this.quotes,
  });

  final int? page;

  final bool? isLastPage;

  final List<Quote>? quotes;

  @override
  List<Object?> get props => [
        page,
        isLastPage,
        quotes,
      ];
}
