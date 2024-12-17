import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class EditPicSourceButton extends StatelessWidget {
  const EditPicSourceButton({
    super.key,
    required this.onPressed,
    this.icon,
    this.iconSize,
  });

  final VoidCallback onPressed;
  final Icon? icon;
  final double? iconSize;

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
                message: 'Error loading EditPicSourceButton Theme');
          } else if (snapshot.hasData) {
            final theme = snapshot.data!;
            return buildIconButton(l10n, theme);
          } else {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading EditPicSourceButton Theme');
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildIconButton(
        l10n,
        defaultTheme.materialThemeData,
      );
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for EditPicSourceButton',
      );
    }
  }

  IconButton buildIconButton(
    ComponentLibraryLocalizations l10n,
    ThemeData theme,
  ) {
    return IconButton(
      onPressed: onPressed,
      icon: icon ??
          const Icon(
            Icons.camera_alt,
          ),
      iconSize: iconSize,
      tooltip: l10n.editPicSourceIconButtonTooltip,
      color: theme.colorScheme.primaryContainer,
      splashColor: theme.colorScheme.outlineVariant,
    );
  }
}
