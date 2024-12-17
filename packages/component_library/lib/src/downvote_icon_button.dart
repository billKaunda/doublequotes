import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class DownvoteIconButton extends StatelessWidget {
  const DownvoteIconButton({
    super.key,
    required this.count,
    required this.isDownvoted,
    this.onTap,
  });

  final int count;
  final bool isDownvoted;
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
                message: 'Error loading DownvoteIconButton Theme');
          } else if (snapshot.hasData) {
            final theme = snapshot.data!;
            return buildCountIndicatorButton(l10n, theme);
          } else {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading DownvoteIconButton Theme');
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildCountIndicatorButton(
        l10n,
        defaultTheme.materialThemeData,
      );
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for DownvoteIconButton',
      );
    }
  }

  CountIndicatorIconButton buildCountIndicatorButton(
    ComponentLibraryLocalizations l10n,
    ThemeData theme,
  ) {
    return CountIndicatorIconButton(
      count: count,
      onTap: onTap,
      tooltip: l10n.downvoteIconButtonTooltip,
      iconData: Icons.thumb_down,
      iconColor: isDownvoted
          ? theme.colorScheme.primary
          : theme.colorScheme.primaryContainer,
    );
  }
}
