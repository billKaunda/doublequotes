import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class UpvoteIconButton extends StatelessWidget {
  const UpvoteIconButton({
    super.key,
    required this.count,
    required this.isUpvoted,
    this.onTap,
  });

  final int count;
  final bool isUpvoted;
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
                message: 'Error loading UpvoteIconButton Theme');
          } else if (snapshot.hasData) {
            return buildCountIndicatorButton(snapshot.data!, l10n);
          } else {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading UpvoteIconButton Theme');
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildCountIndicatorButton(
        defaultTheme.materialThemeData,
        l10n,
      );
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for UpvoteIconButton',
      );
    }
  }

  CountIndicatorIconButton buildCountIndicatorButton(
    ThemeData theme,
    ComponentLibraryLocalizations l10n,
  ) {
    return CountIndicatorIconButton(
      count: count,
      iconData: Icons.thumb_up,
      iconColor: isUpvoted
          ? theme.colorScheme.primary
          : theme.colorScheme.primaryContainer,
      onTap: onTap,
      tooltip: l10n.upvoteIconButtonTooltip,
    );
  }
}
