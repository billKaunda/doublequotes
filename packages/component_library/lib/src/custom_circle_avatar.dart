import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
    this.imageUrl,
    this.maxRadius,
  });

  final String? imageUrl;
  final double? maxRadius;

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
                message: 'Error loading CustomCircleAvatar Theme');
          } else if (snapshot.hasData) {
            return buildCircleAvatar(snapshot.data!);
          } else {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading CustomCircleAvatar Theme');
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildCircleAvatar(defaultTheme.materialThemeData);
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for CustomCircleAvatar',
      );
    }
  }

  CircleAvatar buildCircleAvatar(ThemeData theme) {
    return CircleAvatar(
      backgroundImage: NetworkImage(imageUrl!),
      backgroundColor: theme.colorScheme.primary,
      maxRadius: maxRadius,
    );
  }
}
