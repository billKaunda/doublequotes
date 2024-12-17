import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class RoundedChoiceChip extends StatelessWidget {
  const RoundedChoiceChip({
    super.key,
    required this.label,
    required this.isSelected,
    this.avatar,
    this.labelColor,
    this.selectedLabelColor,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.onSelected,
  });

  final String label;
  final bool isSelected;
  final Widget? avatar;
  final Color? labelColor;
  final Color? selectedLabelColor;
  final Color? backgroundColor;
  final Color? selectedBackgroundColor;
  final ValueChanged<bool>? onSelected;

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
                message: 'Error loading RoundedChoiceChip Theme');
          } else if (snapshot.hasData) {
            return buildChoiceChip(snapshot.data!);
          } else {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading RoundedChoiceChip Theme');
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildChoiceChip(
        defaultTheme.materialThemeData,
      );
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for RoundedChoiceChip',
      );
    }
  }

  ChoiceChip buildChoiceChip(ThemeData theme) {
    return ChoiceChip(
      shape: const StadiumBorder(
        side: BorderSide(),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: isSelected
              ? (selectedLabelColor ?? theme.colorScheme.onSecondary)
              : (labelColor ?? theme.colorScheme.onSecondaryContainer),
        ),
      ),
      selected: isSelected,
      onSelected: onSelected,
      showCheckmark: false,
      avatar: avatar,
      backgroundColor: backgroundColor ?? theme.colorScheme.secondaryContainer,
      selectedColor: selectedBackgroundColor ?? theme.colorScheme.secondary,
    );
  }
}
