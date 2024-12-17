import 'package:flutter/material.dart';
import 'default_d_q_theme_data.dart';

class DefaultDoubleQuotesTheme extends InheritedWidget {
  const DefaultDoubleQuotesTheme({
    super.key,
    required super.child,
    required this.lightTheme,
    required this.highContrastLightTheme,
    required this.darkTheme,
    required this.highContrastDarkTheme,
  });

  final DefaultDQThemeData lightTheme;
  final DefaultDQThemeData highContrastLightTheme;
  final DefaultDQThemeData darkTheme;
  final DefaultDQThemeData highContrastDarkTheme;

  @override
  bool updateShouldNotify(DefaultDoubleQuotesTheme oldWidget) =>
      oldWidget.lightTheme != lightTheme ||
      oldWidget.highContrastLightTheme != highContrastLightTheme ||
      oldWidget.darkTheme != darkTheme ||
      oldWidget.highContrastDarkTheme != highContrastDarkTheme;

  // Returns the nearest `DefaultDoubleQuotesTheme` instance in the
  // widget tree.
  // Throws an error if not found.
  static DefaultDQThemeData of(BuildContext context) {
    final DefaultDoubleQuotesTheme? inheritedWidget =
        context.dependOnInheritedWidgetOfExactType<DefaultDoubleQuotesTheme>();
    assert(inheritedWidget != null, 'No DefaultDoubleTheme found in context');
    final currentBrightness = Theme.of(context).brightness;
    return currentBrightness == Brightness.dark
        ? inheritedWidget!.darkTheme
        : inheritedWidget!.lightTheme;
  }

  // Returns the nearest `DefaultDoubleQuotesTheme` instance in the
  // widget tree.
  // Returns `null` if not found.
  static DefaultDQThemeData? maybeOf(BuildContext context) {
    final DefaultDoubleQuotesTheme? inheritedWidget =
        context.dependOnInheritedWidgetOfExactType<DefaultDoubleQuotesTheme>();
    if (inheritedWidget == null) return null;
    final currentBrightness = Theme.of(context).brightness;
    return currentBrightness == Brightness.dark
        ? inheritedWidget.darkTheme
        : inheritedWidget.lightTheme;
  }
}
