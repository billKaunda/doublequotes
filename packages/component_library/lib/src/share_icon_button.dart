import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class ShareIconButton extends StatelessWidget {
  const ShareIconButton({
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
      return FutureBuilder<ThemeData>(
        future: wallpaperTheme.themeData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CenteredCircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading ShareIconButton Theme');
          } else if (snapshot.hasData) {
            return buildIconButton(snapshot.data!, l10n);
          } else {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading ShareIconButton Theme');
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildIconButton(
        defaultTheme.materialThemeData,
        l10n,
      );
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for ShareIconButton',
      );
    }
  }

  IconButton buildIconButton(
    ThemeData theme,
    ComponentLibraryLocalizations l10n,
  ) {
    return IconButton(
      icon: Icon(
        Icons.share,
        color: theme.colorScheme.onPrimaryContainer,
      ),
      onPressed: onTap,
      tooltip: l10n.shareIconButtonTooltip,
    );
  }
}
