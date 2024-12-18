import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:component_library/component_library.dart';

import 'following_list_bloc.dart';
import '../following_list.dart';

const _itemSpacing = Spacing.xSmall;

class FilterHorizontalList extends StatelessWidget {
  const FilterHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(
        vertical: Spacing.mediumLarge,
      ),
      child: Row(
        children: [
          UserChip(),
        ],
      ),
    );
  }
}

class UserChip extends StatelessWidget {
  const UserChip({super.key});

  @override
  Widget build(BuildContext context) {
    final wallpaperTheme = WallpaperDoubleQuotesTheme.maybeOf(context);
    final defaultTheme = DefaultDoubleQuotesTheme.maybeOf(context);
    final screenMargin =
        (wallpaperTheme?.screenMargin ?? defaultTheme?.screenMargin) ??
            Spacing.mediumLarge;

    if (wallpaperTheme != null) {
      return FutureBuilder(
        future: wallpaperTheme.themeData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CenteredCircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const ExceptionIndicator(
              title: 'Theme Error',
              message: 'Error loading UserChip theme',
            );
          } else if (snapshot.hasData) {
            return buildRoundedChoiceChip(
              snapshot.data!,
              screenMargin,
              wallpaperTheme: wallpaperTheme,
            );
          } else {
            return const ExceptionIndicator(
              title: 'Theme Error',
              message: 'Error loading FavoritesChip theme',
            );
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildRoundedChoiceChip(
        defaultTheme.materialThemeData,
        screenMargin,
        defaultTheme: defaultTheme,
      );
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No theme available for FavoritesChip theme',
      );
    }
  }

  Padding buildRoundedChoiceChip(
    ThemeData theme,
    double screenMargin, {
    DQThemeDataFromWallpaper? wallpaperTheme,
    DefaultDQThemeData? defaultTheme,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        right: _itemSpacing,
        left: screenMargin,
      ),
      child: BlocSelector<FollowingListBloc, FollowingListState, bool>(
        selector: (state) {
          final isFilteringByUsername =
              state.filter is FollowingListFilterByUsername;

          return isFilteringByUsername;
        },
        builder: (context, isUsernameOnly) {
          final l10n = FollowingListLocalizations.of(context);
          return RoundedChoiceChip(
            label: l10n.userChoiceChipLabel,
            avatar: Icon(
              isUsernameOnly ? Icons.person_2 : Icons.person_2_outlined,
              color: isUsernameOnly
                  ? theme.colorScheme.primary
                  : theme.colorScheme.primaryContainer,
            ),
            isSelected: isUsernameOnly,
            onSelected: (isSelected) {
              _releaseFocus(context);
              final bloc = context.read<FollowingListBloc>();
              bloc.add(
                const FollowingListFilterByUsernameToggled(),
              );
            },
          );
        },
      ),
    );
  }
}

void _releaseFocus(BuildContext context) => FocusScope.of(context).unfocus();
