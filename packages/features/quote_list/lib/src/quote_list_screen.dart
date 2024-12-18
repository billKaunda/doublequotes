import 'package:component_library/component_library.dart';
import 'package:user_repository/user_repository.dart';
import 'package:quote_repository/quote_repository.dart';
import 'package:monitoring/monitoring.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import './l10n/quote_list_localizations.dart';
import './filter_horizontal_list.dart';
import './quote_list_bloc.dart';
import './quote_paged_grid_view.dart';
import './quote_paged_list_view.dart';

typedef QuoteSelected = Future<Quote?> Function(int selectedQuote);

class QuoteListScreen extends StatelessWidget {
  const QuoteListScreen({
    required this.quoteRepository,
    required this.userRepository,
    required this.onAuthenticationError,
    required this.remoteValueService,
    this.onQuoteSelected,
    super.key,
  });

  final QuoteRepository quoteRepository;
  final UserRepository userRepository;
  final void Function(BuildContext context) onAuthenticationError;
  final RemoteValueService remoteValueService;
  final QuoteSelected? onQuoteSelected;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuoteListBloc>(
      create: (_) => QuoteListBloc(
        userRepository: userRepository,
        quoteRepository: quoteRepository,
      ),
      child: QuoteListView(
        onAuthenticationError: onAuthenticationError,
        onQuoteSelected: onQuoteSelected,
        remoteValueService: remoteValueService,
      ),
    );
  }
}

@visibleForTesting
class QuoteListView extends StatefulWidget {
  const QuoteListView({
    required this.onAuthenticationError,
    required this.remoteValueService,
    this.onQuoteSelected,
    super.key,
  });

  final void Function(BuildContext context) onAuthenticationError;
  final RemoteValueService remoteValueService;
  final QuoteSelected? onQuoteSelected;

  @override
  State<QuoteListView> createState() => _QuoteListViewState();
}

class _QuoteListViewState extends State<QuoteListView> {
  final PagingController<int, Quote> _pagingController = PagingController(
    firstPageKey: 1,
  );

  final TextEditingController _textEditingController = TextEditingController();

  QuoteListBloc get _bloc => context.read<QuoteListBloc>();

  @override
  void initState() {
    //Forward subsequent page requests to the bloc
    _pagingController.addPageRequestListener((pageNumber) {
      final isSubsequentPage = pageNumber > 1;
      if (isSubsequentPage) {
        _bloc.add(
          QuoteListNextPageRequested(
            pageNumber: pageNumber,
          ),
        );
      }
    });

    _textEditingController.addListener(() {
      _bloc.add(
        QuoteListSearchTermChanged(
          _textEditingController.text,
        ),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = QuoteListLocalizations.of(context);
    final screenMargin =
        (WallpaperDoubleQuotesTheme.maybeOf(context)?.screenMargin ??
                DefaultDoubleQuotesTheme.maybeOf(context)?.screenMargin) ??
            Spacing.mediumLarge;

    return BlocListener<QuoteListBloc, QuoteListState>(
      listener: (context, state) {
        final searchBarText = _textEditingController.text;
        final isSearching =
            state.filter != null && state.filter is QuoteListFilterBySearchTerm;

        if (searchBarText.isNotEmpty && !isSearching) {
          _textEditingController.text = '';
        }

        if (state.refreshError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.quoteListRefreshErrorMessage),
            ),
          );
        } else if (state.favoriteToggleError != null ||
            state.hideToggleError != null) {
          final snackBar = state.favoriteToggleError is UserSessionNotFound ||
                  state.hideToggleError is UserSessionNotFound
              ? const AuthenticationRequiredErrorSnackBar()
              : const GenericErrorSnackBar();

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);

          widget.onAuthenticationError(context);
        } else if (state.makePrivateToggleError != null) {
          if (state.makePrivateToggleError is UserSessionNotFound) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(l10n.proUserRequiredErrorMessage),
                ),
              );
          }
        }

        _pagingController.value = state.toPagingState();
      },
      child: StyledStatusBar.dark(
        child: SafeArea(
          child: Scaffold(
            body: GestureDetector(
              onTap: () => _releaseFocus(context),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenMargin,
                    ),
                    child: CustomSearchBar(
                      textEditingController: _textEditingController,
                      //suggestionsBuilder: (context, searchController) {},
                    ),
                  ),
                  const FilterHorizontalList(),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        _bloc.add(const QuoteListRefreshed());

                        /*
                          Returning a Future inside onRefresh() argument
                          enables the loading indicator to disappear
                          automatically once the refresh is complete.
                        */
                        final stateChangeFuture = _bloc.stream.first;
                        return stateChangeFuture;
                      },
                      /*
                      Display different UI based on the value in 
                      the grid_quotes_view_enabled parameter of RemoteConfig
                      */
                      child: widget.remoteValueService.isGridQuotesViewEnabled
                          ? QuotePagedGridView(
                              pagingController: _pagingController,
                              onQuoteSelected: widget.onQuoteSelected,
                            )
                          : QuotePagedListView(
                              pagingController: _pagingController,
                              onQuoteSelected: widget.onQuoteSelected,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _releaseFocus(BuildContext context) => FocusScope.of(context).unfocus();

  @override
  void dispose() {
    _pagingController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }
}
