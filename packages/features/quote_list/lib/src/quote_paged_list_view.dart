import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';

import '../quote_list.dart';
import 'quote_list_bloc.dart';

class QuotePagedListView extends StatelessWidget {
  const QuotePagedListView({
    required this.pagingController,
    this.onQuoteSelected,
    super.key,
  });

  final PagingController<int, Quote> pagingController;
  final QuoteSelected? onQuoteSelected;

  @override
  Widget build(BuildContext context) {
    final theme = WallpaperDoubleQuotesTheme.of(context);
    final l10n = QuoteListLocalizations.of(context);
    final bloc = context.read<QuoteListBloc>();
    final onQuoteSelected = this.onQuoteSelected;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.screenMargin,
      ),
      child: PagedListView.separated(
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<Quote>(
          itemBuilder: (context, quote, index) {
            final isFavorite = quote.isFavorite ?? false;
            final isHidden = quote.userDetails?.isHidden ?? false;
            final isPrivate = quote.isPrivate ?? false;
            return QuoteCard(
              statement: quote.body ?? l10n.noQuoteBodyErrorMessage,
              author: quote.author,
              isFavorite: isFavorite,
              top: const OpeningQuoteSvgAsset(),
              bottom: const ClosingQuoteSvgAsset(),
              isHidden: isHidden,
              isPrivate: isPrivate,
              onFavorite: () => bloc.add(
                isFavorite
                    ? QuoteListItemUnfavorited(quote.quoteId)
                    : QuoteListItemFavorited(quote.quoteId),
              ),
              onHide: () => bloc.add(
                isHidden
                    ? QuoteListItemUnhidden(quote.quoteId)
                    : QuoteListItemHidden(quote.quoteId),
              ),
              onPrivate: () => bloc.add(
                isPrivate
                    ? QuoteListItemMadePublic(quote.quoteId)
                    : QuoteListItemMadePrivate(quote.quoteId),
              ),
              onTap: onQuoteSelected != null
                  ? () async {
                      final updatedQuote = await onQuoteSelected(quote.quoteId);

                      if (updatedQuote != null &&
                          (updatedQuote.isFavorite != quote.isFavorite ||
                              updatedQuote.userDetails?.isHidden !=
                                  quote.userDetails?.isHidden ||
                              updatedQuote.isPrivate != quote.isPrivate)) {
                        bloc.add(QuoteListItemUpdated(updatedQuote));
                      }
                    }
                  : null,
            );
          },
          firstPageErrorIndicatorBuilder: (context) {
            return ExceptionIndicator(
              title: l10n.firstPageFetchErrorMessageTitle,
              message: l10n.firstPageFetchErrorMessageBody,
              onTryAgain: () => bloc.add(
                const QuoteListFailedFetchRetried(),
              ),
            );
          },
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: theme.gridSpacing,
        ),
      ),
    );
  }
}
