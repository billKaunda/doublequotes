import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class DeleteIconButton extends StatelessWidget {
  const DeleteIconButton({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

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
                message: 'Error loading DeleteIconButton Theme');
          } else if (snapshot.hasData) {
            return buildIconButton(l10n, snapshot.data!);
          } else {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading DeleteIconButton Theme');
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildIconButton(l10n, defaultTheme.materialThemeData);
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for DeleteIconButton',
      );
    }
  }

  IconButton buildIconButton(
    ComponentLibraryLocalizations l10n,
    ThemeData theme,
  ) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: onTap,
      tooltip: l10n.deleteIconButtonTooltip,
      color: theme.colorScheme.primaryFixedDim,
    );
  }
}
