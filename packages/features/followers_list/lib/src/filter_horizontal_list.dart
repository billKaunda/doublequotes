import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain_models/domain_models.dart';
import 'package:component_library/component_library.dart';

import './followers_list_bloc.dart';
import '../followers_list.dart';

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
          ...TypeLookup.values.map(
            (typeLookup) => _FilterChoiceChip(
              typeLookup: typeLookup,
            ),
          ),
        ],
      ),
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
    final screenMargin =
        (WallpaperDoubleQuotesTheme.maybeOf(context)?.screenMargin ??
                DefaultDoubleQuotesTheme.maybeOf(context)?.screenMargin) ??
            Spacing.mediumLarge;
    final isLastTypeLookup = TypeLookup.values.last == typeLookup;

    return Padding(
      padding: EdgeInsets.only(
        right: isLastTypeLookup ? screenMargin : _itemSpacing,
        left: _itemSpacing,
      ),
      child: BlocSelector<FollowersListBloc, FollowersListState, TypeLookup?>(
        selector: (state) {
          final filter = state.filter;
          final selectedTypeLookup = filter is FollowersListFilterByTypeLookup
              ? filter.typeLookup
              : null;

          return selectedTypeLookup;
        },
        builder: (context, selectedTypeLookup) {
          final isSelected = selectedTypeLookup == typeLookup;
          return RoundedChoiceChip(
            label: typeLookup.toLocalizedString(context),
            isSelected: isSelected,
            onSelected: (isSelected) {
              _releaseFocus(context);
              final bloc = context.read<FollowersListBloc>();
              bloc.add(
                FollowersListTypeLookupChanged(
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
    final l10n = FollowersListLocalizations.of(context);
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
