import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:component_library/component_library.dart';
import 'package:user_repository/user_repository.dart';
import 'package:activity_repository/activity_repository.dart';

import './l10n/followers_list_localizations.dart';
import './filter_horizontal_list.dart';
import './followers_list_bloc.dart';
import './followers_paged_list_view.dart';

class FollowersListScreen extends StatelessWidget {
  const FollowersListScreen({
    required this.activityRepository,
    required this.userRepository,
    super.key,
  });

  final ActivityRepository activityRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FollowersListBloc>(
      create: (_) => FollowersListBloc(
        userRepository: userRepository,
        activityRepository: activityRepository,
      ),
      child: const FollowersListView(),
    );
  }
}

@visibleForTesting
class FollowersListView extends StatefulWidget {
  const FollowersListView({
    super.key,
  });

  @override
  State<FollowersListView> createState() => _FollowersListViewState();
}

class _FollowersListViewState extends State<FollowersListView> {
  final PagingController<int, String> _pagingController = PagingController(
    firstPageKey: 1,
  );

  final TextEditingController _textEditingController = TextEditingController();

  FollowersListBloc get _bloc => context.read<FollowersListBloc>();

  @override
  void initState() {
    //Forward subsequent page requests to the bloc
    _pagingController.addPageRequestListener((pageNumber) {
      final isSubsequentPage = pageNumber > 1;
      if (isSubsequentPage) {
        _bloc.add(
          FollowersListNextPageRequested(
            pageNumber: pageNumber,
          ),
        );
      }
    });

    _textEditingController.addListener(() {
      _bloc.add(
        FollowersListSearchTermChanged(
          _textEditingController.text,
        ),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenMargin =
        (WallpaperDoubleQuotesTheme.maybeOf(context)?.screenMargin ??
                DefaultDoubleQuotesTheme.maybeOf(context)?.screenMargin) ??
            Spacing.mediumLarge;
    final l10n = FollowersListLocalizations.of(context);

    return BlocListener<FollowersListBloc, FollowersListState>(
      listener: (context, state) {
        final searchBarText = _textEditingController.text;
        final isSearching = state.filter != null &&
            state.filter is FollowersListFilterBySearchTerm;

        if (searchBarText.isNotEmpty && !isSearching) {
          _textEditingController.text = '';
        }

        if (state.refreshError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.followersListRefreshErrorMessage),
            ),
          );
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
                        _bloc.add(const FollowersListRefreshed());

                        /*
                          Returning a Future inside onRefresh() argument
                          enables the loading indicator to disappear
                          automatically once the refresh is complete.
                        */
                        final stateChangeFuture = _bloc.stream.first;
                        return stateChangeFuture;
                      },
                      child: FollowersPagedListView(
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
