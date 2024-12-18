import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:component_library/component_library.dart';
import 'package:user_repository/user_repository.dart';
import 'package:activity_repository/activity_repository.dart';
import 'package:domain_models/domain_models.dart';

import './l10n/following_list_localizations.dart';
import './filter_horizontal_list.dart';
import './following_list_bloc.dart';
import './following_paged_list_view.dart';

class FollowingListScreen extends StatelessWidget {
  const FollowingListScreen({
    required this.activityRepository,
    required this.userRepository,
    required this.onAuthenticationError,
    super.key,
  });

  final ActivityRepository activityRepository;
  final UserRepository userRepository;
  final void Function(BuildContext context) onAuthenticationError;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FollowingListBloc>(
      create: (_) => FollowingListBloc(
        userRepository: userRepository,
        activityRepository: activityRepository,
      ),
      child: FollowingListView(
        onAuthenticationError: onAuthenticationError,
      ),
    );
  }
}

@visibleForTesting
class FollowingListView extends StatefulWidget {
  const FollowingListView({
    required this.onAuthenticationError,
    super.key,
  });

  final void Function(BuildContext context) onAuthenticationError;

  @override
  State<FollowingListView> createState() => _FollowingListViewState();
}

class _FollowingListViewState extends State<FollowingListView> {
  final PagingController<int, FollowingItem> _pagingController =
      PagingController(
    firstPageKey: 1,
  );

  final TextEditingController _textEditingController = TextEditingController();

  FollowingListBloc get _bloc => context.read<FollowingListBloc>();

  @override
  void initState() {
    //Forward subsequent page requests to the bloc
    _pagingController.addPageRequestListener((pageNumber) {
      final isSubsequentPage = pageNumber > 1;
      if (isSubsequentPage) {
        _bloc.add(
          FollowingListNextPageRequested(
            pageNumber: pageNumber,
          ),
        );
      }
    });

    _textEditingController.addListener(() {
      _bloc.add(
        FollowingListSearchTermChanged(
          _textEditingController.text,
        ),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = FollowingListLocalizations.of(context);
    final screenMargin =
        (WallpaperDoubleQuotesTheme.maybeOf(context)?.screenMargin ??
                DefaultDoubleQuotesTheme.maybeOf(context)?.screenMargin) ??
            Spacing.mediumLarge;

    return BlocListener<FollowingListBloc, FollowingListState>(
      listener: (context, state) {
        final searchBarText = _textEditingController.text;
        final isSearching = state.filter != null &&
            state.filter is FollowingListFilterBySearchTerm;

        if (searchBarText.isNotEmpty && !isSearching) {
          _textEditingController.text = '';
        }

        if (state.refreshError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.followingListRefreshErrorMessage),
            ),
          );
        } else if (state.followToggleError != null) {
          final snackBar = state.followToggleError is UserSessionNotFound
              ? const AuthenticationRequiredErrorSnackBar()
              : const GenericErrorSnackBar();

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);

          widget.onAuthenticationError(context);
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
                    ),
                  ),
                  const FilterHorizontalList(),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        _bloc.add(const FollowingListRefreshed());

                        /*
                          Returning a Future inside onRefresh() argument
                          enables the loading indicator to disappear
                          automatically once the refresh is complete.
                        */
                        final stateChangeFuture = _bloc.stream.first;
                        return stateChangeFuture;
                      },
                      child: FollowingPagedListView(
                        pagingController: _pagingController,
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
