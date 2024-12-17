import 'package:flutter/material.dart';
import '../component_library.dart';

class ChevronListTile extends StatelessWidget {
  const ChevronListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final Icon? leading;
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
                message: 'Error loading ChevronListTile Theme');
          } else if (snapshot.hasData) {
            return buildListTile(snapshot.data!);
          } else {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading ChevronListTile Theme');
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildListTile(defaultTheme.materialThemeData);
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for ChevronListTile',
      );
    }
  }

  ListTile buildListTile(ThemeData theme) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: FontSize.mediumLarge,
        ),
      ),
      subtitle: Text(
        subtitle ?? '',
        style: const TextStyle(
          fontSize: FontSize.medium,
        ),
      ),
      leading: leading,
      trailing: const Icon(
        Icons.chevron_right_outlined,
      ),
      tileColor: theme.colorScheme.surface,
      selectedTileColor: theme.colorScheme.surfaceDim,
      onTap: onTap,
    );
  }
}
