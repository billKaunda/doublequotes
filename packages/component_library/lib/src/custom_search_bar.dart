//import 'dart:async';

import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    this.textEditingController,
    this.searchController,
    this.onChanged,
    this.onSubmitted,
    //required this.suggestionsBuilder,
  });

  final TextEditingController? textEditingController;
  final SearchController? searchController;
  final ValueChanged<String>? onChanged;
  final void Function(String)? onSubmitted;
  // FutureOr<Iterable<Widget>> Function(BuildContext, SearchController)
  // suggestionsBuilder;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late final TextEditingController _textController;
  late final SearchController _searchBarController;

  @override
  void initState() {
    super.initState();
    _textController = widget.textEditingController ?? TextEditingController();
    _searchBarController = widget.searchController ?? SearchController();
  }

  @override
  void dispose() {
    if (widget.textEditingController == null) {
      _textController.dispose();
    }
    if (widget.searchController == null) {
      _searchBarController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = ComponentLibraryLocalizations.of(context);
    final wallpaperTheme = WallpaperDoubleQuotesTheme.maybeOf(context);
    final defaultTheme = DefaultDoubleQuotesTheme.maybeOf(context);

    if (wallpaperTheme != null) {
      return FutureBuilder(
        future: wallpaperTheme.themeData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CenteredCircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const ExceptionIndicator(
              title: 'Theme Error',
              message: 'Unable to load theme for CustomSearchBar',
            );
          } else if (snapshot.hasData) {
            return buildSearchBar(
              snapshot.data!,
              _textController,
              l10n,
              _searchBarController
              //widget.suggestionsBuilder,
            );
          } else {
            return const ExceptionIndicator(
              title: 'Theme Error',
              message: 'Unable to load theme for CustomSearchBar',
            );
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildSearchBar(
        defaultTheme.materialThemeData,
        _textController,
        l10n,
        _searchBarController
        //widget.suggestionsBuilder,
      );
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for CustomSearchBar',
      );
    }
  }

  SearchBar buildSearchBar(
    ThemeData theme,
    TextEditingController textController,
    ComponentLibraryLocalizations l10n,
    SearchController searchBarController,
    //FutureOr<Iterable<Widget>> Function(BuildContext, SearchController)
        //suggestionsBuilder,
  ) {
    return SearchBar(
      controller: searchBarController,
      hintText: l10n.searchBarHintText,
      //suggestionsBuilder: suggestionsBuilder,
      onTap: () {
        searchBarController.openView();
      },
      //isFullScreen: false,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      leading: const Icon(Icons.search),
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      elevation: const WidgetStatePropertyAll(4.0),
      backgroundColor:
          WidgetStatePropertyAll(theme.colorScheme.surfaceContainerLow),
      surfaceTintColor: WidgetStatePropertyAll(
        theme.colorScheme.surfaceTint,
      ),
      shadowColor: WidgetStatePropertyAll(
        theme.colorScheme.surfaceContainerLowest,
      ),
    );
  }
}
