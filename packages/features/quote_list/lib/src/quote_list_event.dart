part of 'quote_list_bloc.dart';

abstract class QuoteListEvent extends Equatable {
  const QuoteListEvent();

  @override
  List<Object?> get props => [];
}

class QuoteListFilterByFavoritesToggled extends QuoteListEvent {
  const QuoteListFilterByFavoritesToggled();
}

class QuoteListFilterByHiddenToggled extends QuoteListEvent {
  const QuoteListFilterByHiddenToggled();
}

class QuoteListFilterByPrivateToggled extends QuoteListEvent {
  const QuoteListFilterByPrivateToggled();
}

class QuoteListTypeLookupChanged extends QuoteListEvent {
  const QuoteListTypeLookupChanged({
    this.typeLookup,
  });

  final TypeLookup? typeLookup;

  @override
  List<Object?> get props => [
        typeLookup,
      ];
}

class QuoteListSearchTermChanged extends QuoteListEvent {
  const QuoteListSearchTermChanged(
    this.searchTerm,
  );

  final String searchTerm;

  @override
  List<Object?> get props => [
        searchTerm,
      ];
}

class QuoteListRefreshed extends QuoteListEvent {
  const QuoteListRefreshed();
}

class QuoteListNextPageRequested extends QuoteListEvent {
  const QuoteListNextPageRequested({
    required this.pageNumber,
  });

  final int pageNumber;

  @override
  List<Object?> get props => [
        pageNumber,
      ];
}

abstract class QuoteListItemFavoriteToggled extends QuoteListEvent {
  const QuoteListItemFavoriteToggled(
    this.quoteId,
  );

  final int quoteId;
}

class QuoteListItemFavorited extends QuoteListItemFavoriteToggled {
  const QuoteListItemFavorited(
    super.quoteId,
  );
}

class QuoteListItemUnfavorited extends QuoteListItemFavoriteToggled {
  const QuoteListItemUnfavorited(
    super.quoteId,
  );
}

abstract class QuoteListItemHideToggled extends QuoteListEvent {
  const QuoteListItemHideToggled(this.quoteId);

  final int quoteId;
}

class QuoteListItemHidden extends QuoteListItemHideToggled {
  const QuoteListItemHidden(super.quoteId);
}

class QuoteListItemUnhidden extends QuoteListItemHideToggled {
  const QuoteListItemUnhidden(super.quoteId);
}

abstract class QuoteListItemPrivateToggled extends QuoteListEvent {
  const QuoteListItemPrivateToggled(this.quoteId);

  final int quoteId;
}

class QuoteListItemMadePrivate extends QuoteListItemPrivateToggled {
  const QuoteListItemMadePrivate(super.quoteId);
}

class QuoteListItemMadePublic extends QuoteListItemPrivateToggled {
  const QuoteListItemMadePublic(super.quoteId);
}

class QuoteListFailedFetchRetried extends QuoteListEvent {
  const QuoteListFailedFetchRetried();
}

class QuoteListUsernameObtained extends QuoteListEvent {
  const QuoteListUsernameObtained();
}

class QuoteListItemUpdated extends QuoteListEvent {
  const QuoteListItemUpdated(
    this.updatedQuote,
  );

  final Quote updatedQuote;
}
