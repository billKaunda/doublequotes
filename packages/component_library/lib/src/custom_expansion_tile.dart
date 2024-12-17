import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile({
    super.key,
    required this.title,
    this.subtitle,
    this.children,
  });

  final String title;
  final String? subtitle;
  final List<Widget>? children;
  @override
  Widget build(BuildContext context) {
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
                message: 'Error loading CustomExpansionTile Theme');
          } else if (snapshot.hasData) {
            return buildExpansionTile(snapshot.data!);
          } else {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading CustomExpansionTile Theme');
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildExpansionTile(defaultTheme.materialThemeData);
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for CustomExpansionTile',
      );
    }
  }

  ExpansionTile buildExpansionTile(ThemeData theme) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: FontSize.mediumLarge,
        ),
      ),
      subtitle: Text(
        subtitle ?? '',
        style: const TextStyle(
          fontSize: FontSize.medium,
        ),
      ),
      children: children ?? [],
      backgroundColor: theme.colorScheme.surface,
      collapsedBackgroundColor: theme.colorScheme.surfaceDim,
      textColor: theme.colorScheme.onSurface,
      collapsedTextColor: theme.colorScheme.onSurfaceVariant,
    );
  }
}
