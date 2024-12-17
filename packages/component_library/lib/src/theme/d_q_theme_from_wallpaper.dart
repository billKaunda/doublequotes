import 'package:component_library/src/theme/wallpaper_service.dart';
import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

//Since the number of properties is too big, they have be grouped
// into classes in the widget_colors class.

abstract class DQThemeDataFromWallpaper {
  ThemeMode get materialThemeMode;

  Future<ThemeData> generateThemeFromImage();

  Future<ThemeData> get themeData;

  double screenMargin = Spacing.mediumLarge;

  double gridSpacing = Spacing.mediumLarge;

  Future<Color> get quoteSvgColor;

  TextStyle quoteTextStyle = const TextStyle(
    fontFamily: 'Fondamento',
    package: 'component_library',
  );
}

class LightDoubleQuotesThemeData extends DQThemeDataFromWallpaper {
  @override
  ThemeMode get materialThemeMode => ThemeMode.light;

  @override
  Future<ThemeData> generateThemeFromImage() async {
    final wallpaperService = WallpaperService();
    final provider = await wallpaperService.toImageProvider();
    final colorScheme = await ColorScheme.fromImageProvider(
      provider: provider,
      brightness: Brightness.light,
    );
    //TODO Set textTheme property
    return ThemeData.from(
      colorScheme: colorScheme,
      useMaterial3: true,
    );
  }

  @override
  Future<ThemeData> get themeData async => await generateThemeFromImage();

  @override
  Future<Color> get quoteSvgColor async =>
      (await themeData).colorScheme.onSurfaceVariant;
}

class DarkDoubleQuotesThemeData extends DQThemeDataFromWallpaper {
  @override
  ThemeMode get materialThemeMode => ThemeMode.dark;

  @override
  Future<ThemeData> generateThemeFromImage() async {
    final wallpaperService = WallpaperService();
    final provider = await wallpaperService.toImageProvider();
    final colorScheme = await ColorScheme.fromImageProvider(
      provider: provider,
      brightness: Brightness.dark,
    );
    return ThemeData.from(
      colorScheme: colorScheme,
      useMaterial3: true,
    );
  }

  @override
  Future<ThemeData> get themeData async => await generateThemeFromImage();

  @override
  Future<Color> get quoteSvgColor async =>
      (await themeData).colorScheme.onSurfaceVariant;
}

