import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class CenteredCircularProgressIndicator extends StatelessWidget {
  const CenteredCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final wallpaperTheme = WallpaperDoubleQuotesTheme.maybeOf(context);
    final defaultTheme = DefaultDoubleQuotesTheme.maybeOf(context);

    if (wallpaperTheme != null) {
      return FutureBuilder<ThemeData>(
        future: wallpaperTheme.themeData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message:
                    'Error loading CenteredCircularProgressIndicator Theme');
          } else if (snapshot.hasData) {
            final theme = snapshot.data!;
            return buildCircularProgressIndicator(theme);
          } else {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message:
                    'Error loading CenteredCircularProgressIndicator Theme');
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildCircularProgressIndicator(defaultTheme.materialThemeData);
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message:
            'No valid theme available for CenteredCircularProgressIndicator',
      );
    }
  }

  CircularProgressIndicator buildCircularProgressIndicator(
    ThemeData theme,
  ) {
    return CircularProgressIndicator(
      color: theme.colorScheme.primaryFixedDim,
    );
  }
}
