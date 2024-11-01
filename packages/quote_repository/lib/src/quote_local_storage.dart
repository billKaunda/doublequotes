import 'package:key_value_storage/key_value_storage.dart';

class QuoteLocalStorage {
  QuoteLocalStorage({
    required this.quotesKeyValueStorage,
  });

  final QuotesKeyValueStorage quotesKeyValueStorage;

  Future<void> upsertQuoteListPage(
    int page,
    QuoteListPageCM quoteListPageCM, {
    bool favoritesOnly = false,
    bool hiddenQuotesOnly = false,
    bool privateQuotesOnly = false,
  }) async {
    final box = await (() {
      if (favoritesOnly) {
        return quotesKeyValueStorage.favoriteQuotesListPageBox;
      } else if (hiddenQuotesOnly) {
        return quotesKeyValueStorage.hiddenQuotesListPageBox;
      } else if (privateQuotesOnly) {
        return quotesKeyValueStorage.privateQuotesListPageBox;
      } else {
        return quotesKeyValueStorage.quoteListPageBox;
      }
    })();

    await box.put(page, quoteListPageCM);
  }

  Future<void> upsertQotd(
    String date,
    QotdCM qotdCM,
  ) async {
    final box = await quotesKeyValueStorage.qotdBox;
    if (qotdCM.date == date) {
      return box.put(date, qotdCM);
    }
    return;
  }

  Future<void> clearQuoteListPageList({
    bool favoritesOnly = false,
    bool hiddenQuotesOnly = false,
    bool privateQuotesOnly = false,
  }) async {
    final box = await (() {
      if (favoritesOnly) {
        return quotesKeyValueStorage.favoriteQuotesListPageBox;
      } else if (hiddenQuotesOnly) {
        return quotesKeyValueStorage.hiddenQuotesListPageBox;
      } else if (privateQuotesOnly) {
        return quotesKeyValueStorage.privateQuotesListPageBox;
      } else {
        return quotesKeyValueStorage.quoteListPageBox;
      }
    })();

    await box.clear();
  }

  Future<void> clearQotd() async {
    final box = await quotesKeyValueStorage.qotdBox;
    await box.clear();
  }

  Future<void> clear() async {
    Future<void> clearBox(Future<Box> boxFuture) async {
      final box = await boxFuture;
      await box.clear();
    }

    await Future.wait([
      clearBox(quotesKeyValueStorage.favoriteQuotesListPageBox),
      clearBox(quotesKeyValueStorage.hiddenQuotesListPageBox),
      clearBox(quotesKeyValueStorage.privateQuotesListPageBox),
      clearBox(quotesKeyValueStorage.quoteListPageBox),
      clearBox(quotesKeyValueStorage.qotdBox),
    ]);
  }

  Future<QotdCM?> getQotd(String date) async {
    final qotdBox = await quotesKeyValueStorage.qotdBox;
    final qotdList = [...qotdBox.values];

    try {
      return qotdList.firstWhere((qotd) => qotd.date == date);
    } catch (_) {
      return null;
    }
  }

  Future<QuoteListPageCM?> getQuoteListPage(
    int page, {
    bool favoritesOnly = false,
    bool hiddenQuotesOnly = false,
    bool privateQuotesOnly = false,
  }) async {
    final box = await (() {
      if (favoritesOnly) {
        return quotesKeyValueStorage.favoriteQuotesListPageBox;
      } else if (hiddenQuotesOnly) {
        return quotesKeyValueStorage.hiddenQuotesListPageBox;
      } else if (privateQuotesOnly) {
        return quotesKeyValueStorage.privateQuotesListPageBox;
      } else {
        return quotesKeyValueStorage.quoteListPageBox;
      }
    })();

    return box.get(page);
  }

  Future<QuoteCM?> getQuote(int quoteId) async {
    final favoritesBox = await quotesKeyValueStorage.favoriteQuotesListPageBox;
    final hiddenQuotesBox = await quotesKeyValueStorage.hiddenQuotesListPageBox;
    final privateQuotesBox =
        await quotesKeyValueStorage.privateQuotesListPageBox;
    final quotesBox = await quotesKeyValueStorage.quoteListPageBox;

    final allQuotesList = [
      ...favoritesBox.values,
      ...hiddenQuotesBox.values,
      ...privateQuotesBox.values,
      ...quotesBox.values,
    ].expand((eachList) => eachList.quotes!);

    try {
      return allQuotesList.firstWhere((quote) => quote.quoteId == quoteId);
    } catch (_) {
      return null;
    }
  }

  Future<void> deleteQuote(int quoteId) async {
    final quoteToDelete = await getQuote(quoteId);

    if (quoteToDelete != null) {
      try {
        // Define cache update tasks based on the caches in which the quote exists
        final cacheActions = [
          // Attempt deletion from favorites, hidden, private, and main caches
          quotesKeyValueStorage.favoriteQuotesListPageBox.then((box) async {
            for (var page in box.values) {
              page.quotes?.removeWhere((quote) => quote.quoteId == quoteId);
            }
          }),
          quotesKeyValueStorage.hiddenQuotesListPageBox.then((box) async {
            for (var page in box.values) {
              page.quotes?.removeWhere((quote) => quote.quoteId == quoteId);
            }
          }),
          quotesKeyValueStorage.privateQuotesListPageBox.then((box) async {
            for (var page in box.values) {
              page.quotes?.removeWhere((quote) => quote.quoteId == quoteId);
            }
          }),
          quotesKeyValueStorage.quoteListPageBox.then((box) async {
            for (var page in box.values) {
              page.quotes?.removeWhere((quote) => quote.quoteId == quoteId);
            }
          }),
        ];

        // Execute all cache updates in parallel
        await Future.wait(cacheActions);
      } catch (_) {
        return;
      }
    } else {
      return;
    }
  }

  Future<void> performActionOnQuote(
    QuoteCM updatedQuote, {
    bool shouldUpdateFavorites = false,
    bool shouldUpdateHiddenQuotes = false,
    bool shouldUpdatePrivateQuotes = false,
  }) async {
    // Fetch boxes concurrently to improve performance.
    final boxes = await Future.wait([
      quotesKeyValueStorage.quoteListPageBox,
      if (shouldUpdateFavorites)
        quotesKeyValueStorage.favoriteQuotesListPageBox,
      if (shouldUpdateHiddenQuotes)
        quotesKeyValueStorage.hiddenQuotesListPageBox,
      if (shouldUpdatePrivateQuotes)
        quotesKeyValueStorage.privateQuotesListPageBox,
    ]);

    // Perform actions on each selected box.
    await Future.wait(
        boxes.map((box) => box.performActionOnQuote(updatedQuote)));
  }
}

extension on Box<QuoteListPageCM> {
  Future<void> performActionOnQuote(QuoteCM updatedQuote) async {
    final eachPage = values.toList();

    try {
      final outdatedPage = eachPage.firstWhere(
        (page) =>
            page.quotes!.any((quote) => quote.quoteId == updatedQuote.quoteId),
      );

      final outdatedPageIndex = eachPage.indexOf(outdatedPage);

      final updatedQuotePage = QuoteListPageCM(
        isLastPage: outdatedPage.isLastPage,
        quotes: outdatedPage.quotes!
            .map((quote) =>
                quote.quoteId == updatedQuote.quoteId ? updatedQuote : quote)
            .toList(),
      );

      //Indeces are zero-based but page numbers are not
      final pageNumber = outdatedPageIndex + 1;
      return put(pageNumber, updatedQuotePage);
    } catch (_) {}
  }
}
