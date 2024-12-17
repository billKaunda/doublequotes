import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    this.onSignInTap,
  });

  final VoidCallback? onSignInTap;

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
        top: Spacing.xxLarge,
      ),
      child: ExpandedElevatedButton(
        onTap: onSignInTap,
        label: l10n.signInButtonLabel,
        icon: const Icon(
          Icons.login,
        ),
      ),
    );
  }
}
