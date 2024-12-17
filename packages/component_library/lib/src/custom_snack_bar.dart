import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

const double snackBarTopRadius = 10;

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar({
    super.key,
    required this.content,
  });

  final String content;

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
              message: 'Unable to load CustomSnackBar theme',
            );
          } else if (snapshot.hasData) {
            return buildSnackBar(snapshot.data!);
          } else {
            return const ExceptionIndicator(
              title: 'Theme Error',
              message: 'Unable to load CustomSnackBar theme ',
            );
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildSnackBar(defaultTheme.materialThemeData);
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for CustomSnackBar',
      );
    }
  }

  SnackBar buildSnackBar(ThemeData theme) {
    return SnackBar(
      backgroundColor: theme.colorScheme.errorContainer,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      content: Text(
        content,
        style: TextStyle(
            color: theme.colorScheme.onErrorContainer,
            fontSize: FontSize.medium),
      ),
      duration: const Duration(seconds: 3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(snackBarTopRadius),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    );
  }
}
