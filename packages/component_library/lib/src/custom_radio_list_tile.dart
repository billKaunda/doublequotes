import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class CustomRadioListTile<T> extends StatelessWidget {
  const CustomRadioListTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.title,
  });

  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final String? title;

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
              message: 'Unable to load theme for CustomSimpleDialog',
            );
          } else if (snapshot.hasData) {
            return buildRadioListTile(snapshot.data!);
          } else {
            return const ExceptionIndicator(
              title: 'Theme Error',
              message: 'Unable to load theme for CustomSimpleDialog',
            );
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildRadioListTile(defaultTheme.materialThemeData);
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for CustomSimpleDialog',
      );
    }
  }

  RadioListTile<dynamic> buildRadioListTile(ThemeData theme) {
    return RadioListTile<T>(
      title: Text(
        title ?? '',
        style: theme.textTheme.bodyMedium,
      ),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      tileColor: theme.colorScheme.onSurface,
      selectedTileColor: theme.colorScheme.primaryContainer,
      activeColor: theme.colorScheme.primary,
    );
  }
}
