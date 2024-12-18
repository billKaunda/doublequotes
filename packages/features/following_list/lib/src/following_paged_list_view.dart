import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';

import '../following_list.dart';
import 'following_list_bloc.dart';

class FollowingPagedListView extends StatelessWidget {
  const FollowingPagedListView({
    required this.pagingController,
    super.key,
  });

  final PagingController<int, FollowingItem> pagingController;

  @override
  Widget build(BuildContext context) {
    final wallpaperTheme = WallpaperDoubleQuotesTheme.maybeOf(context);
    final defaultTheme = DefaultDoubleQuotesTheme.maybeOf(context);
    final screenMargin =
        (wallpaperTheme?.screenMargin ?? defaultTheme?.screenMargin) ??
            Spacing.mediumLarge;
    final gridSpacing =
        (wallpaperTheme?.gridSpacing ?? defaultTheme?.gridSpacing) ??
            Spacing.mediumLarge;
    final l10n = FollowingListLocalizations.of(context);
    final bloc = context.read<FollowingListBloc>();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenMargin,
      ),
      child: PagedListView.separated(
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<FollowingItem>(
          itemBuilder: (context, followingItem, index) {
            return CustomListTile(
              leading: followingItem.followingType == 'Author'
                  ? const Icon(Icons.menu_book)
                  : followingItem.followingType == 'Tag'
                      ? const Icon(Icons.loyalty)
                      : const Icon(Icons.person),
              title: followingItem.followingValue!.toTitleCase(),
              subtitle: followingItem.followingType == 'Author'
                  ? l10n.authorListTileSubtitle
                  : followingItem.followingType == 'Tag'
                      ? l10n.tagListTileSubtitle
                      : l10n.userListTileSubtitle,
              trailing: IconButton(
                onPressed: () => bloc.add(
                  FollowingListItemUnfollowed(
                    followingItem.followingType,
                    followingItem.followingId ?? '',
                  ),
                ),
                icon: const Icon(Icons.close),
              ),
            );
          },
          firstPageErrorIndicatorBuilder: (context) {
            return ExceptionIndicator(
              title: l10n.firstPageFetchErrorMessageTitle,
              message: l10n.firstPageFetchErrorMessageBody,
              onTryAgain: () => bloc.add(
                const FollowingListFailedFetchRetried(),
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
