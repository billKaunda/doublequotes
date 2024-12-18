import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';

import './quote_list_bloc.dart';
import '../quote_list.dart';

const _itemSpacing = Spacing.xSmall;

class FilterHorizontalList extends StatelessWidget {
  const FilterHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        vertical: Spacing.mediumLarge,
      ),
      child: Row(
        children: [
          const _ThemeBasedChip(builder: _buildFavoritesChip),
          ...TypeLookup.values.map(
            (typeLookup) => _FilterChoiceChip(typeLookup: typeLookup),
          ),
          const _ThemeBasedChip(builder: _buildHiddenChip),
          const _ThemeBasedChip(builder: _buildPrivateChip),
        ],
      ),
    );
  }
}

// Base widget to handle theme logic for chips
class _ThemeBasedChip extends StatelessWidget {
  const _ThemeBasedChip({
    required this.builder,
    super.key,
  });

  final Widget Function(BuildContext, ThemeData, double) builder;

  @override
  Widget build(BuildContext context) {
    final wallpaperTheme = WallpaperDoubleQuotesTheme.maybeOf(context);
    final defaultTheme = DefaultDoubleQuotesTheme.maybeOf(context);
    final screenMargin =
        (wallpaperTheme?.screenMargin ?? defaultTheme?.screenMargin) ??
            Spacing.mediumLarge;

    if (wallpaperTheme != null) {
      return FutureBuilder<ThemeData>(
        future: wallpaperTheme.themeData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CenteredCircularProgressIndicator();
          } else if (snapshot.hasError || !snapshot.hasData) {
            return const ExceptionIndicator(
              title: 'Theme Error',
              message: 'Error loading chip theme',
            );
          }
          return builder(context, snapshot.data!, screenMargin);
        },
      );
    } else if (defaultTheme != null) {
      return builder(context, defaultTheme.materialThemeData, screenMargin);
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'Error loading chip theme',
      );
    }
  }
}

// Favorites Chip
Widget _buildFavoritesChip(
  BuildContext context,
  ThemeData theme,
  double screenMargin,
) {
  return _Chip(
    theme: theme,
    screenMargin: screenMargin,
    label: QuoteListLocalizations.of(context).favoritesChoiceChipLabel,
    isSelected: (state) => state.filter is QuoteListFilterByFavorites,
    onToggle: (context, bloc) =>
        bloc.add(const QuoteListFilterByFavoritesToggled()),
    selectedIcon: Icons.favorite,
    unselectedIcon: Icons.favorite_border_outlined,
  );
}

// Hidden Chip
Widget _buildHiddenChip(
    BuildContext context, ThemeData theme, double screenMargin) {
  return _Chip(
    theme: theme,
    screenMargin: screenMargin,
    label: QuoteListLocalizations.of(context).hiddenChoiceChipLabel,
    isSelected: (state) => state.filter is QuoteListFilterByHidden,
    onToggle: (context, bloc) =>
        bloc.add(const QuoteListFilterByHiddenToggled()),
    selectedIcon: Icons.visibility_off,
    unselectedIcon: Icons.visibility,
  );
}

// Private Chip
Widget _buildPrivateChip(
    BuildContext context, ThemeData theme, double screenMargin) {
  return _Chip(
    theme: theme,
    screenMargin: screenMargin,
    label: QuoteListLocalizations.of(context).privateChoiceChipLabel,
    isSelected: (state) => state.filter is QuoteListFilterByPrivate,
    onToggle: (context, bloc) =>
        bloc.add(const QuoteListFilterByPrivateToggled()),
    selectedIcon: Icons.public_off,
    unselectedIcon: Icons.public,
  );
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.theme,
    required this.screenMargin,
    required this.label,
    required this.isSelected,
    required this.onToggle,
    required this.selectedIcon,
    required this.unselectedIcon,
  });

  final ThemeData theme;
  final double screenMargin;
  final String label;
  final bool Function(QuoteListState) isSelected;
  final void Function(BuildContext, QuoteListBloc) onToggle;
  final IconData selectedIcon;
  final IconData unselectedIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: _itemSpacing,
        left: screenMargin,
      ),
      child: BlocSelector<QuoteListBloc, QuoteListState, bool>(
        selector: isSelected,
        builder: (context, isSelected) {
          return RoundedChoiceChip(
            label: label,
            avatar: Icon(
              isSelected ? selectedIcon : unselectedIcon,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.primaryContainer,
            ),
            isSelected: isSelected,
            onSelected: (isSelected) {
              _releaseFocus(context);
              onToggle(context, context.read<QuoteListBloc>());
            },
          );
        },
      ),
    );
  }
}

// Filter Choice Chip for TypeLookup
class _FilterChoiceChip extends StatelessWidget {
  const _FilterChoiceChip({
    required this.typeLookup,
    super.key,
  });

  final TypeLookup typeLookup;

  @override
  Widget build(BuildContext context) {
    final isLastType = TypeLookup.values.last == typeLookup;
    final screenMargin =
        (WallpaperDoubleQuotesTheme.maybeOf(context)?.screenMargin ??
                DefaultDoubleQuotesTheme.maybeOf(context)?.screenMargin) ??
            0.0;

    return Padding(
      padding: EdgeInsets.only(
        right: isLastType ? screenMargin : _itemSpacing,
        left: _itemSpacing,
      ),
      child: BlocSelector<QuoteListBloc, QuoteListState, TypeLookup?>(
        selector: (state) => state.filter is QuoteListFilterByTypeLookup
            ? (state.filter as QuoteListFilterByTypeLookup).typeLookup
            : null,
        builder: (context, selectedTypeLookup) {
          final isSelected = selectedTypeLookup == typeLookup;
          return RoundedChoiceChip(
            label: typeLookup.toLocalizedString(context),
            isSelected: isSelected,
            onSelected: (isSelected) {
              _releaseFocus(context);
              context.read<QuoteListBloc>().add(
                    QuoteListTypeLookupChanged(
                      typeLookup: isSelected ? typeLookup : null,
                    ),
                  );
            },
          );
        },
      ),
    );
  }
}

void _releaseFocus(BuildContext context) => FocusScope.of(context).unfocus();

extension on TypeLookup {
  String toLocalizedString(BuildContext context) {
    final l10n = QuoteListLocalizations.of(context);
    switch (this) {
      case TypeLookup.author:
        return l10n.authorChoiceChipLabel;
      case TypeLookup.tag:
        return l10n.tagChoiceChipLabel;
      case TypeLookup.user:
        return l10n.userChoiceChipLabel;
    }
  }
}
