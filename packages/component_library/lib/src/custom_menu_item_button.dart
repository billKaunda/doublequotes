import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class CustomMenuItemButton extends StatelessWidget {
  const CustomMenuItemButton({
    super.key,
    required this.label,
    this.trailingIcon,
    this.onTap,
  });

  final VoidCallback? onTap;
  final Icon? trailingIcon;
  final String label;

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
                message: 'Error loading CustomMenuItemButton Theme');
          } else if (snapshot.hasData) {
            return buildMenuItemButton(snapshot.data!);
          } else {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading CustomMenuItemButton Theme');
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildMenuItemButton(defaultTheme.materialThemeData);
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for CustomMenuItemButton',
      );
    }
  }

  MenuItemButton buildMenuItemButton(ThemeData theme) {
    return MenuItemButton(
      onPressed: onTap,
      trailingIcon: trailingIcon,
      child: Text(label),
      style: ButtonStyle(
        backgroundColor: theme.colorScheme.onSurface as WidgetStateColor,
        shadowColor: theme.colorScheme.onSurfaceVariant as WidgetStateColor,
      ),
    );
  }
}
