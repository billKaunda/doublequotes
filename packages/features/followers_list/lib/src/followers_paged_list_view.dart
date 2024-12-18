import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:component_library/component_library.dart';

import '../followers_list.dart';
import 'followers_list_bloc.dart';

class FollowersPagedListView extends StatelessWidget {
  const FollowersPagedListView({
    required this.pagingController,
    super.key,
  });

  final PagingController<int, String> pagingController;

  @override
  Widget build(BuildContext context) {
    final wallpaperTheme = WallpaperDoubleQuotesTheme.maybeOf(context);
    final defaultTheme = DefaultDoubleQuotesTheme.maybeOf(context);
    final screenMargin =
        (WallpaperDoubleQuotesTheme.maybeOf(context)?.screenMargin ??
                DefaultDoubleQuotesTheme.maybeOf(context)?.screenMargin) ??
            Spacing.mediumLarge;
    final gridSpacing =
        (wallpaperTheme?.gridSpacing ?? defaultTheme?.gridSpacing) ??
            Spacing.mediumLarge;
    final l10n = FollowersListLocalizations.of(context);
    final bloc = context.read<FollowersListBloc>();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenMargin,
      ),
      child: PagedListView.separated(
        pagingController: pagingController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        builderDelegate: PagedChildBuilderDelegate<String>(
          itemBuilder: (context, followerEntity, index) {
            return CustomListTile(
              title: followerEntity[index].toTitleCase(),
              visualDensity: VisualDensity.minimumDensity,
              dense: true,
            );
          },
          firstPageErrorIndicatorBuilder: (context) {
            return ExceptionIndicator(
              title: l10n.firstPageFetchErrorMessageTitle,
              message: l10n.firstPageFetchErrorMessageBody,
              onTryAgain: () => bloc.add(
                const FollowersListFailedFetchRetried(),
              ),
            );
          },
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: gridSpacing,
        ),
      ),
    );
  }
}

extension on String {
  String toTitleCase() {
    if (isEmpty) {
      return this;
    }
    final words = split(' ');
    final modifiedWord = words
        .map((word) =>
            word.isEmpty ? word : word[0] + word.substring(1).toLowerCase())
        .toList();
    return modifiedWord.join(' ');
  }
}
