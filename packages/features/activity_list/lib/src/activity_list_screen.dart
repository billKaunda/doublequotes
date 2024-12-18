import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:component_library/component_library.dart';
import 'package:user_repository/user_repository.dart';
import 'package:activity_repository/activity_repository.dart';
import 'package:domain_models/domain_models.dart';

import './l10n/activity_list_localizations.dart';
import './filter_horizontal_list.dart';
import './activity_list_bloc.dart';
import './activity_paged_list_view.dart';

typedef ActivityLongPressed = Future<Activity?> Function(
    int longPressedActivity);

class ActivityListScreen extends StatelessWidget {
  const ActivityListScreen({
    required this.activityRepository,
    required this.userRepository,
    required this.onAuthenticationError,
    this.onActivityLongPressed,
    super.key,
  });

  final ActivityRepository activityRepository;
  final UserRepository userRepository;
  final void Function(BuildContext context) onAuthenticationError;
  final ActivityLongPressed? onActivityLongPressed;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ActivityListBloc>(
      create: (_) => ActivityListBloc(
        userRepository: userRepository,
        activityRepository: activityRepository,
      ),
      child: ActivityListView(
        onAuthenticationError: onAuthenticationError,
        onActivityLongPressed: onActivityLongPressed,
      ),
    );
  }
}

@visibleForTesting
class ActivityListView extends StatefulWidget {
  const ActivityListView({
    required this.onAuthenticationError,
    this.onActivityLongPressed,
    super.key,
  });

  final void Function(BuildContext context) onAuthenticationError;
  final ActivityLongPressed? onActivityLongPressed;

  @override
  State<ActivityListView> createState() => _ActivityListViewState();
}

class _ActivityListViewState extends State<ActivityListView> {
  final PagingController<int, Activity> _pagingController = PagingController(
    firstPageKey: 1,
  );

  final TextEditingController _textEditingController = TextEditingController();

  ActivityListBloc get _bloc => context.read<ActivityListBloc>();

  @override
  void initState() {
    //Forward subsequent page requests to the bloc
    _pagingController.addPageRequestListener((pageNumber) {
      final isSubsequentPage = pageNumber > 1;
      if (isSubsequentPage) {
        _bloc.add(
          ActivityListNextPageRequested(
            pageNumber: pageNumber,
          ),
        );
      }
    });

    _textEditingController.addListener(() {
      _bloc.add(
        ActivityListSearchTermChanged(
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
    final l10n = ActivityListLocalizations.of(context);

    return BlocListener<ActivityListBloc, ActivityListState>(
      listener: (context, state) {
        final searchBarText = _textEditingController.text;
        final isSearching = state.filter != null &&
            state.filter is ActivityListFilterBySearchTerm;

        if (searchBarText.isNotEmpty && !isSearching) {
          _textEditingController.text = '';
        }

        if (state.refreshError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.activityListRefreshErrorMessage),
            ),
          );
        } else if (state.deleteActivityError != null ||
            state.followToggleError != null) {
          final snackBar = state.deleteActivityError is UserSessionNotFound ||
                  state.followToggleError is UserSessionNotFound
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
                        _bloc.add(const ActivityListRefreshed());

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
                      child: ActivityPagedListView(
                        pagingController: _pagingController,
                        onActivityLongPressed: widget.onActivityLongPressed,
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
