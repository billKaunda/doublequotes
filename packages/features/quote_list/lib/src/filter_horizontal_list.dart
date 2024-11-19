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
          const FavoritesChip(),
          ...TypeLookup.values.map(
            (typeLookup) => _FilterChoiceChip(
              typeLookup: typeLookup,
            ),
          ),
          const HiddenChip(),
          const PrivateChip(),
        ],
      ),
    );
  }
}

class FavoritesChip extends StatelessWidget {
  const FavoritesChip({super.key});

  @override
  Widget build(BuildContext context) {
    final wallpaperTheme = WallpaperDoubleQuotesTheme.of(context);
    return FutureBuilder(
      future: wallpaperTheme.themeData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CenteredCircularProgressIndicator();
        } else if (snapshot.hasError) {
          throw const ExceptionIndicator(
            title: 'Unable to load theme',
            message: 'Error loading theme for FavoritesChip',
          );
        } else if (snapshot.hasData) {
          final theme = snapshot.data!;
          return Padding(
            padding: EdgeInsets.only(
              right: _itemSpacing,
              left: wallpaperTheme.screenMargin,
            ),
            child: BlocSelector<QuoteListBloc, QuoteListState, bool>(
              selector: (state) {
                final isFilteringByFavorites =
                    state.filter is QuoteListFilterByFavorites;

                return isFilteringByFavorites;
              },
              builder: (context, isFavoritesOnly) {
                final l10n = QuoteListLocalizations.of(context);
                return RoundedChoiceChip(
                  label: l10n.favoritesChoiceChipLabel,
                  avatar: Icon(
                    isFavoritesOnly
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: isFavoritesOnly
                        ? theme.colorScheme.primary
                        : theme.colorScheme.primaryContainer,
                  ),
                  isSelected: isFavoritesOnly,
                  onSelected: (isSelected) {
                    _releaseFocus(context);
                    final bloc = context.read<QuoteListBloc>();
                    bloc.add(
                      const QuoteListFilterByFavoritesToggled(),
                    );
                  },
                );
              },
            ),
          );
        } else {
          throw Exception(
            'Error loading theme for FavoritesChip',
          );
        }
      },
    );
  }
}

class _FilterChoiceChip extends StatelessWidget {
  const _FilterChoiceChip({
    required this.typeLookup,
  });

  final TypeLookup typeLookup;

  @override
  Widget build(BuildContext context) {
    final theme = WallpaperDoubleQuotesTheme.of(context);
    final isLastTypeLookup = TypeLookup.values.last == typeLookup;
    return Padding(
      padding: EdgeInsets.only(
        right: isLastTypeLookup ? theme.screenMargin : _itemSpacing,
        left: _itemSpacing,
      ),
      child: BlocSelector<QuoteListBloc, QuoteListState, TypeLookup?>(
        selector: (state) {
          final filter = state.filter;
          final selectedTypeLookup =
              filter is QuoteListFilterByTypeLookup ? filter.typeLookup : null;

          return selectedTypeLookup;
        },
        builder: (context, selectedTypeLookup) {
          final isSelected = selectedTypeLookup == typeLookup;
          return RoundedChoiceChip(
            label: typeLookup.toLocalizedString(context),
            isSelected: isSelected,
            onSelected: (isSelected) {
              _releaseFocus(context);
              final bloc = context.read<QuoteListBloc>();
              bloc.add(
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

class HiddenChip extends StatelessWidget {
  const HiddenChip({super.key});

  @override
  Widget build(BuildContext context) {
    final wallpaperTheme = WallpaperDoubleQuotesTheme.of(context);
    return FutureBuilder(
      future: wallpaperTheme.themeData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CenteredCircularProgressIndicator();
        } else if (snapshot.hasError) {
          throw const ExceptionIndicator(
            title: 'Theme Error',
            message: 'Error loading theme for HiddenChoiceChip',
          );
        } else if (snapshot.hasData) {
          final theme = snapshot.data!;
          return Padding(
            padding: EdgeInsets.only(
              right: _itemSpacing,
              left: wallpaperTheme.screenMargin,
            ),
            child: BlocSelector<QuoteListBloc, QuoteListState, bool>(
              selector: (state) {
                final isFilteringByHidden =
                    state.filter is QuoteListFilterByHidden;

                return isFilteringByHidden;
              },
              builder: (context, isHiddenOnly) {
                final l10n = QuoteListLocalizations.of(context);
                return RoundedChoiceChip(
                  label: l10n.hiddenChoiceChipLabel,
                  avatar: Icon(
                    isHiddenOnly ? Icons.visibility_off : Icons.visibility,
                    color: isHiddenOnly
                        ? theme.colorScheme.primary
                        : theme.colorScheme.primaryContainer,
                  ),
                  isSelected: isHiddenOnly,
                  onSelected: (isSelected) {
                    _releaseFocus(context);
                    final bloc = context.read<QuoteListBloc>();
                    bloc.add(
                      const QuoteListFilterByHiddenToggled(),
                    );
                  },
                );
              },
            ),
          );
        } else {
          throw Exception(
            'Error loading theme for HiddenChoiceChip',
          );
        }
      },
    );
  }
}

class PrivateChip extends StatelessWidget {
  const PrivateChip({super.key});

  @override
  Widget build(BuildContext context) {
    final wallpaperTheme = WallpaperDoubleQuotesTheme.of(context);
    return FutureBuilder(
      future: wallpaperTheme.themeData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CenteredCircularProgressIndicator();
        } else if (snapshot.hasError) {
          throw const ExceptionIndicator(
            title: 'Theme Error',
            message: 'Error loading theme for PrivateChoiceChip',
          );
        } else if (snapshot.hasData) {
          final theme = snapshot.data!;
          return Padding(
            padding: EdgeInsets.only(
              right: _itemSpacing,
              left: wallpaperTheme.screenMargin,
            ),
            child: BlocSelector<QuoteListBloc, QuoteListState, bool>(
              selector: (state) {
                final isFilteringByPrivate =
                    state.filter is QuoteListFilterByPrivate;

                return isFilteringByPrivate;
              },
              builder: (context, isPrivateOnly) {
                final l10n = QuoteListLocalizations.of(context);
                return RoundedChoiceChip(
                  label: l10n.privateChoiceChipLabel,
                  avatar: Icon(
                    isPrivateOnly ? Icons.public_off : Icons.public,
                    color: isPrivateOnly
                        ? theme.colorScheme.primary
                        : theme.colorScheme.primaryContainer,
                  ),
                  isSelected: isPrivateOnly,
                  onSelected: (isSelected) {
                    _releaseFocus(context);
                    final bloc = context.read<QuoteListBloc>();
                    bloc.add(
                      const QuoteListFilterByPrivateToggled(),
                    );
                  },
                );
              },
            ),
          );
        } else {
          throw Exception(
            'Error loading theme for PrivateChoiceChip',
          );
        }
      },
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
    }
  }
}
