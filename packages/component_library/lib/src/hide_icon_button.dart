import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class HideIconButton extends StatelessWidget {
  const HideIconButton({
    super.key,
    this.onTap,
    this.isHidden,
  });

  final VoidCallback? onTap;
  final bool? isHidden;

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
                message: 'Error loading HideIconButton Theme');
          } else if (snapshot.hasData) {
            return buildIconButton(l10n, snapshot.data!);
          } else {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading HideIconButton Theme');
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildIconButton(l10n, defaultTheme.materialThemeData);
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for HideIconButton',
      );
    }
  }

  IconButton buildIconButton(
    ComponentLibraryLocalizations l10n,
    ThemeData theme,
  ) {
    return IconButton(
      tooltip: l10n.hideIconButtonTooltip,
      onPressed: onTap,
      icon: isHidden == true
          ? const Icon(Icons.visibility_off)
          : const Icon(Icons.visibility),
      color: isHidden == true
          ? theme.colorScheme.primaryFixed
          : theme.colorScheme.primaryContainer,
    );
  }
}
