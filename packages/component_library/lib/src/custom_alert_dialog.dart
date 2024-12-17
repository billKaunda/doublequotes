import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

const double _borderRadius = 12;

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
  });

  final String? title;
  final String? content;
  final List<Widget>? actions;

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
                message: 'Error loading CustomAlertDialog Theme');
          } else if (snapshot.hasData) {
            return buildAlertDialog(snapshot.data!);
          } else {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading CustomAlertDialog Theme');
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildAlertDialog(defaultTheme.materialThemeData);
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for CustomAlertDialog',
      );
    }
  }

  AlertDialog buildAlertDialog(ThemeData theme) {
    return AlertDialog(
      title: Text(
        title!,
      ),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.onSurface,
      ),
      content: Text(
        content!,
      ),
      contentTextStyle: TextStyle(
        fontWeight: FontWeight.normal,
        color: theme.colorScheme.onSurface,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      elevation: 4.0,
      backgroundColor: theme.colorScheme.surfaceContainer,
      surfaceTintColor: theme.colorScheme.surfaceContainerLow,
      actions: actions,
    );
  }
}
