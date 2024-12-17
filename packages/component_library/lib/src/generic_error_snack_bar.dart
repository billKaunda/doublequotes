import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class GenericErrorSnackBar extends SnackBar {
  const GenericErrorSnackBar({
    super.key,
  }) : super(content: const _GenericErrorSnackBarMessage());
}

class _GenericErrorSnackBarMessage extends StatelessWidget {
  // ignore: unused_element
  const _GenericErrorSnackBarMessage({super.key});

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
                message: 'Error loading GenericErrorSnackBarMessage Theme');
          } else if (snapshot.hasData) {
            return buildText(l10n, snapshot.data!);
          } else {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading GenericErrorSnackBarMessage Theme');
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildText(l10n, defaultTheme.materialThemeData);
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for GenericErrorSnackBarMessage',
      );
    }
  }

  Text buildText(
    ComponentLibraryLocalizations l10n,
    ThemeData theme,
  ) {
    return Text(
      l10n.genericErrorSnackBarMessage,
      style: TextStyle(
        backgroundColor: theme.colorScheme.error,
        color: theme.colorScheme.onError,
      ),
    );
  }
}
