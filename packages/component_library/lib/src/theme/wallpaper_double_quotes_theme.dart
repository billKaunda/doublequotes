import 'd_q_theme_from_wallpaper.dart';
import 'package:flutter/material.dart';

class WallpaperDoubleQuotesTheme extends InheritedWidget {
  const WallpaperDoubleQuotesTheme({
    super.key,
    required super.child,
    required this.lightTheme,
    required this.darkTheme,
  });

  final DQThemeDataFromWallpaper lightTheme;
  final DQThemeDataFromWallpaper darkTheme;

  @override
  bool updateShouldNotify(WallpaperDoubleQuotesTheme oldWidget) =>
      oldWidget.lightTheme != lightTheme || oldWidget.darkTheme != darkTheme;

  // Returns the nearest `WallpaperDoubleQuotesTheme` instance in the
  // widget tree.
  // Throws an error if not found.
  static DQThemeDataFromWallpaper of(BuildContext context) {
    final WallpaperDoubleQuotesTheme? inheritedWidget = context
        .dependOnInheritedWidgetOfExactType<WallpaperDoubleQuotesTheme>();
    assert(inheritedWidget != null,
        'No WallpaperDoubleQuotesTheme found in context');
    final currentBrightness = Theme.of(context).brightness;
    return currentBrightness == Brightness.dark
        ? inheritedWidget!.darkTheme
        : inheritedWidget!.lightTheme;
  }

  // Returns the nearest `WallpaperDoubleQuotesTheme` instance in the
  // widget tree.
  // Returns `null` if not found.
  static DQThemeDataFromWallpaper? maybeOf(BuildContext context) {
    final WallpaperDoubleQuotesTheme? inheritedWidget = context
        .dependOnInheritedWidgetOfExactType<WallpaperDoubleQuotesTheme>();
    if (inheritedWidget == null) return null;
    final currentBrightness = Theme.of(context).brightness;
    return currentBrightness == Brightness.dark
        ? inheritedWidget.darkTheme
        : inheritedWidget.lightTheme;
  }
}
