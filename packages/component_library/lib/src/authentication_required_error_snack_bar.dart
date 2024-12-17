import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class AuthenticationRequiredErrorSnackBar extends SnackBar {
  const AuthenticationRequiredErrorSnackBar({super.key})
      : super(
          content: const _AuthenticationRequiredErrorSnackBarMessage(),
        );
}

class _AuthenticationRequiredErrorSnackBarMessage extends StatelessWidget {
  // ignore: unused_element
  const _AuthenticationRequiredErrorSnackBarMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = ComponentLibraryLocalizations.of(context);
    final wallpaperTheme = WallpaperDoubleQuotesTheme.maybeOf(context);
    final defaultTheme = DefaultDoubleQuotesTheme.maybeOf(context);

    if (wallpaperTheme != null) {
      return FutureBuilder<ThemeData>(
        future: wallpaperTheme.themeData, //Access async theme data
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading AuthenticationErrorSnackbarTheme');
          } else if (snapshot.hasData) {
            return buildText(l10n, snapshot.data!);
          } else {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading AuthenticationErrorSnackbarTheme');
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildText(l10n, defaultTheme.materialThemeData);
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message:
            'No valid theme available for AuthenticationErrorSnackbarTheme',
      );
    }
  }

  Text buildText(ComponentLibraryLocalizations l10n, ThemeData themeData) {
    return Text(
      l10n.authenticationRequiredErrorSnackBarMessage,
      style: TextStyle(
        backgroundColor: themeData.colorScheme.error,
        color: themeData.colorScheme.onError,
      ),
    );
  }
}
