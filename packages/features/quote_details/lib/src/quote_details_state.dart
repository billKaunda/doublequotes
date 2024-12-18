part of 'quote_details_cubit.dart';

enum QuoteError {
  quoteNotFoundError,
  proUserRequiredError,
  couldNotCreateQuoteError,
  cannotUnfavPrivateQuoteError,
  genericError,
}

abstract class QuoteDetailsState extends Equatable {
  const QuoteDetailsState();
}

class QuoteDetailsInProgress extends QuoteDetailsState {
  const QuoteDetailsInProgress();

  @override
  List<Object?> get props => [];
}

class QuoteDetailsSuccess extends QuoteDetailsState {
  const QuoteDetailsSuccess({
    required this.quote,
    this.quoteUpdateError,
  });

  final Quote quote;
  final dynamic quoteUpdateError;

  @override
  List<Object?> get props => [
        quote,
        quoteUpdateError,
      ];
}

class QuoteDetailsFailure extends QuoteDetailsState {
  const QuoteDetailsFailure();

  @override
  List<Object?> get props => [];
}

class QuoteDeletedSucessfully extends QuoteDetailsState {
  const QuoteDeletedSucessfully();

  @override
  List<Object?> get props => [];
}
