import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({
    required this.isSignOutInProgress,
    required this.expandedElevatedButton,
  });

  final bool isSignOutInProgress;
  final ExpandedElevatedButton expandedElevatedButton;

  @override
  Widget build(BuildContext context) {
    final wallpaperTheme = WallpaperDoubleQuotesTheme.maybeOf(context);
    final defaultTheme = DefaultDoubleQuotesTheme.maybeOf(context);
    final l10n = ComponentLibraryLocalizations.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: wallpaperTheme != null
            ? wallpaperTheme.screenMargin
            : defaultTheme!.screenMargin,
        right: wallpaperTheme != null
            ? wallpaperTheme.screenMargin
            : defaultTheme!.screenMargin,
        bottom: Spacing.xLarge,
      ),
      child: isSignOutInProgress
          ? ExpandedElevatedButton.inProgress(
              label: l10n.signOutButtonLabel,
            )
          : expandedElevatedButton,
    );
  }
}
