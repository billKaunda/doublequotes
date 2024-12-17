import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  final VoidCallback onPressed;
  final String label;
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
                message: 'Error loading CustomTextButton Theme');
          } else if (snapshot.hasData) {
            return buildTextButton(snapshot.data!);
          } else {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading CustomTextButton Theme');
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildTextButton(defaultTheme.materialThemeData);
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for CustomTextButton',
      );
    }
  }

  TextButton buildTextButton(ThemeData theme) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: theme.colorScheme.onPrimary,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: theme.colorScheme.primary as WidgetStateColor,
      ),
    );
  }
}
