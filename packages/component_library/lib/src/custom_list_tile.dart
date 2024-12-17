import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.leading,
    required this.title,
    this.titleFontSize,
    this.subtitle,
    this.subtitleFontSize,
    this.trailing,
    this.enabled,
    this.selected,
    this.visualDensity,
    this.dense,
    this.onTap,
  });

  final Widget? leading;
  final String title;
  final double? titleFontSize;
  final String? subtitle;
  final double? subtitleFontSize;
  final Widget? trailing;
  final bool? enabled;
  final bool? selected;
  final double? visualDensity;
  final bool? dense;
  final VoidCallback? onTap;

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
                message: 'Error loading CustomListTile Theme');
          } else if (snapshot.hasData) {
            return buildListTile(snapshot.data!);
          } else {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading CustomListTile Theme');
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildListTile(defaultTheme.materialThemeData);
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for CustomListTile',
      );
    }
  }

  ListTile buildListTile(ThemeData theme) {
    return ListTile(
      leading: leading,
      title: Text(
        title,
      ),
      titleTextStyle: TextStyle(
        fontSize: titleFontSize ?? FontSize.mediumLarge,
      ),
      subtitle: Text(
        subtitle ?? '',
      ),
      subtitleTextStyle: TextStyle(
        fontSize: subtitleFontSize ?? FontSize.medium,
      ),
      trailing: trailing,
      enabled: enabled ?? true,
      selected: selected ?? false,
      onTap: onTap,
      visualDensity: visualDensity as VisualDensity,
      dense: dense,
      tileColor: theme.colorScheme.surfaceContainer,
      selectedTileColor: theme.colorScheme.surfaceDim,
      textColor: theme.colorScheme.onSurface,
    );
  }
}
