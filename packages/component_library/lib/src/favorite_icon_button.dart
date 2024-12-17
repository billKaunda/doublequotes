import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({
    super.key,
    required this.isFavorite,
    this.onTap,
  });

  final bool isFavorite;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = ComponentLibraryLocalizations.of(context);
    final wallpaperTheme = WallpaperDoubleQuotesTheme.maybeOf(context);
    final defaultTheme = DefaultDoubleQuotesTheme.maybeOf(context);

    if (wallpaperTheme != null) {
      return FutureBuilder<ThemeData>(
        future: wallpaperTheme.themeData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CenteredCircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading FavoriteIconButton Theme');
          } else if (snapshot.hasData) {
            return buildIconButton(l10n, snapshot.data!);
          } else {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading FavoriteIconButton Theme');
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildIconButton(l10n, defaultTheme.materialThemeData);
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for FavoriteIconButton',
      );
    }
  }

  IconButton buildIconButton(
    ComponentLibraryLocalizations l10n,
    ThemeData theme,
  ) {
    return IconButton(
      onPressed: onTap,
      tooltip: l10n.favoriteIconButtonTooltip,
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
        color: isFavorite
            ? theme.colorScheme.onTertiaryContainer
            : theme.colorScheme.tertiaryContainer,
      ),
    );
  }
}
