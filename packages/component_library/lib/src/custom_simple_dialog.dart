import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class CustomSimpleDialog extends StatelessWidget {
  const CustomSimpleDialog({
    super.key,
    this.title,
    this.children,
  });

  final String? title;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
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
              message: 'Unable to load CustomSimpleDialog theme',
            );
          } else if (snapshot.hasData) {
            return buildSimpleDialog(snapshot.data!);
          } else {
            return const ExceptionIndicator(
              title: 'Theme Error',
              message: 'Unable to load CustomSimpleDialog theme',
            );
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildSimpleDialog(defaultTheme.materialThemeData);
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for CustomSimpleDialog',
      );
    }
  }

  SimpleDialog buildSimpleDialog(ThemeData theme) {
    return SimpleDialog(
      title: Text(
        title ?? '',
        style: theme.textTheme.titleMedium,
      ),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.onSurface,
      ),
      elevation: 4.0,
      children: children ?? <Widget>[],
      backgroundColor: theme.colorScheme.surfaceBright,
      shadowColor: theme.colorScheme.surfaceDim,
      surfaceTintColor: theme.colorScheme.surfaceTint,
    );
  }
}
