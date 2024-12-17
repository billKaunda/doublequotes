import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class ExceptionIndicator extends StatelessWidget {
  const ExceptionIndicator({
    super.key,
    this.title,
    this.message,
    this.onTryAgain,
  });

  final String? title;
  final String? message;
  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) {
    final l10n = ComponentLibraryLocalizations.of(context);
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
                message: 'Error loading ExceptionIndicator Theme');
          } else if (snapshot.hasData) {
            return buildCenter(snapshot.data!, l10n);
          } else {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading ExceptionIndicator Theme');
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildCenter(defaultTheme.materialThemeData, l10n);
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for ExceptionIndicator',
      );
    }
  }

  Center buildCenter(
    ThemeData theme,
    ComponentLibraryLocalizations l10n,
  ) {
    return Center(
      child: Container(
        color: theme.colorScheme.errorContainer,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 32,
            horizontal: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                size: 48,
                color: theme.colorScheme.onErrorContainer,
              ),
              const SizedBox(
                height: Spacing.xxLarge,
              ),
              Text(
                title ?? l10n.exceptionIndicatorGenericTitle,
                style: TextStyle(
                    fontSize: FontSize.mediumLarge,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onError),
              ),
              const SizedBox(
                height: Spacing.mediumLarge,
              ),
              Text(
                message ?? l10n.exceptionIndicatorGenericMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: theme.colorScheme.onError,
                ),
              ),
              if (onTryAgain != null)
                const SizedBox(
                  height: Spacing.xxxLarge,
                ),
              if (onTryAgain != null)
                ExpandedElevatedButton(
                  onTap: onTryAgain,
                  icon: const Icon(Icons.refresh),
                  label: l10n.exceptionIndicatorTryAgainButton,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
