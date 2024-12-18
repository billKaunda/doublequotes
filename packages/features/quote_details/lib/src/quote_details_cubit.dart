import 'dart:async';

import 'package:domain_models/domain_models.dart';
import 'package:quote_repository/quote_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:fav_qs_api_v2/fav_qs_api_v2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quote_details_state.dart';

//To create a cubit, you have to extend Cubit and specify your base
// state class as the generic type.
class QuoteDetailsCubit extends Cubit<QuoteDetailsState> {
  QuoteDetailsCubit({
    required this.quoteId,
    required this.quoteRepository,
    this.personalTags,
    this.lines,
    this.source,
    this.context,
    this.tags,
    this.author,
    this.body,
  }) : super(
          //You have to pass an instance of the initial state that
          // will be provided to the UI when the screen first opens
          const QuoteDetailsInProgress(),
        ) {
    _fetchQuoteDetails();
  }

  final int quoteId;
  final QuoteRepository quoteRepository;
  final List<String>? personalTags;
  final List<DialogueLine>? lines;
  final String? source;
  final String? context;
  final List<String>? tags;
  final String? author;
  final String? body;

  Future<void> _fetchQuoteDetails() async {
    try {
      final quote = await quoteRepository.getQuoteDetails(quoteId);
      emit(
        QuoteDetailsSuccess(quote: quote),
      );
    } catch (error) {
      emit(
        const QuoteDetailsFailure(),
      );
    }
  }

  //On tapping try again button, this function is called
  Future<void> refetch() async {
    emit(
      const QuoteDetailsInProgress(),
    );
    _fetchQuoteDetails();
  }

  void favoriteQuote() async {
    await _executeActionOnQuoteOperation(
      () => quoteRepository.favoriteQuote(quoteId),
    );
  }

  void unfavoriteQuote() async {
    await _executeActionOnQuoteOperation(
      () => quoteRepository.unfavoriteQuote(
        quoteId,
      ),
    );
  }

  void upvoteQuote() async {
    await _executeActionOnQuoteOperation(
      () => quoteRepository.upvoteQuote(quoteId),
    );
  }

  void downvoteQuote() async {
    await _executeActionOnQuoteOperation(
      () => quoteRepository.downvoteQuote(quoteId),
    );
  }

  void clearvoteOnQuote() async {
    await _executeActionOnQuoteOperation(
      () => quoteRepository.clearvoteOnQuote(quoteId),
    );
  }

  void addPersonalTagsToQuote() async {
    await _executeActionOnQuoteOperation(
      () => quoteRepository.addPersonalTagsToQuote(quoteId, personalTags),
    );
  }

  void hideQuote() async {
    await _executeActionOnQuoteOperation(
      () => quoteRepository.hideQuote(quoteId),
    );
  }

  void unhideQuote() async {
    await _executeActionOnQuoteOperation(
      () => quoteRepository.unhideQuote(quoteId),
    );
  }

  void addQuote() async {
    await _executeActionOnQuoteOperation(
      () => quoteRepository.addQuote(
        author!,
        body!,
      ),
    );
  }

  void addDialogueToQuote() async {
    await _executeActionOnQuoteOperation(
      () => quoteRepository.addDialogue(
        lines!.map((line) => line.toRemoteModel()).toList(),
        source: source,
        context: context,
        tags: tags,
      ),
    );
  }

  void updateQuote() async {
    await _executeActionOnQuoteOperation(
      () => quoteRepository.updateQuote(
        quoteId,
        author: author!,
        body: body!,
      ),
    );
  }

  void updateDialogue() async {
    await _executeActionOnQuoteOperation(
      () => quoteRepository.updateDialogue(
        quoteId,
        lines!.map((line) => line.toRemoteModel()).toList(),
        source: source,
        context: context,
        tags: tags,
      ),
    );
  }

  void makeQuotePublic() async {
    await _executeActionOnQuoteOperation(
      () => quoteRepository.makeQuotePublic(quoteId),
    );
  }

  void deleteQuote() async {
    try {
      await quoteRepository.deleteQuote(quoteId);

      emit(
        const QuoteDeletedSucessfully(),
      );
    } catch (error) {
      final lastState = state;
      if (lastState is QuoteDetailsSuccess) {
        emit(
          QuoteDetailsSuccess(
              quote: lastState.quote,
              quoteUpdateError: (error is QuoteNotFound)
                  ? QuoteError.quoteNotFoundError
                  : (error is ProUserRequired)
                      ? QuoteError.proUserRequiredError
                      : QuoteError.genericError),
        );
      }
    }
  }

  Future<void> _executeActionOnQuoteOperation(
    Future<Quote> Function() updateQuote,
  ) async {
    try {
      final updatedQuote = await updateQuote();
      emit(
        QuoteDetailsSuccess(quote: updatedQuote),
      );
    } catch (error) {
      final lastState = state;
      if (lastState is QuoteDetailsSuccess) {
        emit(
          QuoteDetailsSuccess(
            quote: lastState.quote,
            quoteUpdateError: switch (error) {
              QuoteNotFound() => QuoteError.quoteNotFoundError,
              CannotUnfavPrivateQuotes() =>
                QuoteError.cannotUnfavPrivateQuoteError,
              ProUserRequired() => QuoteError.proUserRequiredError,
              _ => QuoteError.genericError,
            },
          ),
        );
      }
    }
  }
}

extension on DialogueLine {
  DialogueLineRequestRM toRemoteModel() {
    return DialogueLineRequestRM(
      author: author!,
      body: body!,
    );
  }
}
