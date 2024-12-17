import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

const double _borderRadius = 8;

class CustomInkwell extends StatelessWidget {
  const CustomInkwell({
    super.key,
    this.onTap,
    required this.number,
    required this.label,
  });

  final VoidCallback? onTap;
  final int number;
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
                message: 'Error loading CustomInkwell Theme');
          } else if (snapshot.hasData) {
            return buildInkWell(snapshot.data!);
          } else {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading CustomInkWell Theme');
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildInkWell(defaultTheme.materialThemeData);
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for CustomInkWell',
      );
    }
  }

  InkWell buildInkWell(ThemeData theme) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(_borderRadius),
      splashColor: theme.colorScheme.onSurfaceVariant,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            number.toString(),
            style: const TextStyle(
              fontSize: FontSize.large,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: FontSize.medium,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
