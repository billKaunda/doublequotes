import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

abstract class DefaultDQThemeData {
  ThemeMode get materialThemeMode;

  ColorScheme get colorScheme;

  ThemeData get materialThemeData;

  double screenMargin = Spacing.mediumLarge;

  double gridSpacing = Spacing.mediumLarge;

  DefaultChoiceChipColors get defaultChoiceChipColors;

  TextStyle quoteTextStyle = const TextStyle(
    fontFamily: 'Fondamento',
    package: 'component_library',
  );
}

class DefaultLightDQThemeData extends DefaultDQThemeData {
  @override
  ThemeMode get materialThemeMode => ThemeMode.light;

  @override
  ColorScheme get colorScheme => ColorScheme.light(
        brightness: Brightness.light,
        secondaryContainer: Colors.deepPurple.shade100,
        secondary: Colors.grey.shade800,
        onSecondaryContainer: Colors.blueGrey.shade900,
        onSecondary: Colors.white70,
        secondaryFixedDim: Colors.grey.shade900,
        primaryContainer: Colors.indigoAccent.shade100,
        onPrimaryContainer: Colors.indigo.shade900,
        primary: Colors.indigo,
        onPrimary: Colors.white,
        surface: Colors.white70,
        surfaceDim: Colors.grey.shade300,
        surfaceTint: Colors.indigo.shade100,
        surfaceBright: Colors.white, // Slightly brighter than `surface`
        surfaceContainer:
            Colors.grey.shade200, // Neutral light grey for containers
        surfaceContainerHigh:
            Colors.grey.shade300, // Slightly darker for elevated containers
        surfaceContainerHighest:
            Colors.grey.shade400, // Darkest for highest elevation
        surfaceContainerLow:
            Colors.grey.shade100, // Lightest container for low elevation
        surfaceContainerLowest:
            Colors.white70, // Matches `surface`, suitable for lowest
        onSurface: Colors.black,
        onSurfaceVariant: Colors.grey.shade800,
        tertiaryContainer: Colors.pink.shade100,
        onTertiaryContainer: Colors.pink.shade900,
        tertiary: Colors.pink.shade800,
        onTertiary: Colors.white,
        tertiaryFixed: Colors.pink.shade200,
        tertiaryFixedDim: Colors.pink.shade700,
        onTertiaryFixed: Colors.black,
        onTertiaryFixedVariant: Colors.pink.shade600,
        error: Colors.red.shade900,
        onError: Colors.white,
        errorContainer: Colors.red.shade100,
        onErrorContainer: Colors.pink.shade900,
      );

  @override
  ThemeData get materialThemeData => ThemeData(
        colorScheme: colorScheme,
        dividerTheme: DividerThemeData(
          space: 0,
          color: colorScheme.outlineVariant,
        ),
        useMaterial3: true,
      );

  @override
  DefaultChoiceChipColors get defaultChoiceChipColors =>
      DefaultChoiceChipColors(
        backgroundColor: colorScheme.secondaryContainer,
        selectedBackgroundColor: colorScheme.secondary,
        labelColor: colorScheme.onSecondaryContainer,
        selectedLabelColor: colorScheme.onSecondary,
        avatarColor: colorScheme.secondaryFixedDim,
        selectedAvatarColor: colorScheme.secondaryContainer,
        checkmarkColor: colorScheme.onTertiary,
      );
}

/* 
  To achieve highContrastLight mode, ...container colors are made slightly 
  darker or lighter to improve contrast while on... colors are 
  made black or white for high readability, matching high-contrast 
  standards
*/
class DefaultHightContrastLightDQThemeData extends DefaultDQThemeData {
  @override
  ThemeMode get materialThemeMode => ThemeMode.light;

  @override
  ColorScheme get colorScheme => ColorScheme.highContrastLight(
        brightness: Brightness.light,
        secondaryContainer: Colors.deepPurple.shade200, // Increase contrast
        secondary: Colors.grey.shade900, // Darker for high contrast
        onSecondaryContainer: Colors.blueGrey.shade800, // Adjusted for contrast
        onSecondary: Colors.white, // High contrast white
        secondaryFixedDim: Colors.grey.shade800, // High contrast adjustment
        primaryContainer: Colors.indigoAccent.shade200, // Increase contrast
        onPrimaryContainer: Colors.indigo.shade800, // Adjusted for readability
        primary: Colors.indigo.shade800, // Higher contrast for primary color
        onPrimary: Colors.white, // High contrast white
        surface: Colors.white, // Use solid white for higher contrast
        surfaceDim: Colors.grey.shade400, // Lightened for contrast
        surfaceTint: Colors.indigoAccent,
        surfaceBright: Colors.grey.shade100, // Bright surface for contrast
        surfaceContainer:
            Colors.grey.shade300, // Neutral container for high visibility
        surfaceContainerHigh:
            Colors.grey.shade400, // Darker for elevated visibility
        surfaceContainerHighest:
            Colors.grey.shade500, // Stronger contrast at highest elevation
        surfaceContainerLow:
            Colors.grey.shade200, // Subtle contrast for lower containers
        surfaceContainerLowest: Colors.grey.shade100, // Lowest-level container
        onSurface: Colors.black, // High contrast black
        onSurfaceVariant: Colors.grey.shade700, // Darker for contrast
        tertiaryContainer: Colors.pink.shade200, // Higher contrast
        onTertiaryContainer: Colors.pink.shade800, // Darker for readability
        tertiary: Colors.pink.shade900, // Higher contrast tertiary color
        onTertiary: Colors.white, // High contrast white
        tertiaryFixed:
            Colors.pink.shade300, // Lighter for emphasis, but still distinct
        tertiaryFixedDim: Colors.pink.shade700, // Darker shade for contrast
        onTertiaryFixed: Colors.white, //High contrast for legibility
        onTertiaryFixedVariant:
            Colors.pink.shade600, // Mid-tone for intermediate use
        error: Colors.red.shade800, // Higher contrast for error color
        onError: Colors.white, // High contrast white
        errorContainer: Colors.red.shade200, // Adjusted for visibility
        onErrorContainer: Colors.red.shade900, // Darker for readability
      );

  @override
  DefaultChoiceChipColors get defaultChoiceChipColors =>
      DefaultChoiceChipColors(
        backgroundColor: colorScheme.secondaryContainer,
        selectedBackgroundColor: colorScheme.secondary,
        labelColor: colorScheme.onSecondaryContainer,
        selectedLabelColor: colorScheme.onSecondary,
        avatarColor: colorScheme.secondaryFixedDim,
        selectedAvatarColor: colorScheme.secondaryContainer,
        checkmarkColor: colorScheme.onTertiary,
      );

  @override
  ThemeData get materialThemeData => ThemeData(
        colorScheme: colorScheme,
        dividerTheme: DividerThemeData(
          space: 0,
          color: colorScheme.outlineVariant,
        ),
        useMaterial3: true,
      );
}

//For default dark mode, the light background colors are darkened
// and the dark text colors become lighter.
class DefaultDarkDQThemeData extends DefaultDQThemeData {
  @override
  ThemeMode get materialThemeMode => ThemeMode.dark;

  @override
  ColorScheme get colorScheme => ColorScheme.dark(
        brightness: Brightness.dark,
        secondaryContainer:
            Colors.deepPurple.shade900, // Darker version of secondary container
        secondary: Colors.grey.shade300, // Lighter grey for secondary
        onSecondaryContainer: Colors
            .blueGrey.shade100, // Lighter version for onSecondaryContainer
        onSecondary: Colors.black87, // Darker for onSecondary
        secondaryFixedDim:
            Colors.grey.shade300, // Lighter grey for fixed dim secondary
        primaryContainer:
            Colors.indigoAccent.shade700, // Darker primary container
        onPrimaryContainer:
            Colors.indigo.shade100, // Lighter onPrimaryContainer
        primary: Colors.indigo.shade300, // Lighter primary color
        onPrimary: Colors.black, // Darker for onPrimary
        surface: Colors.black87, // Darker surface
        surfaceDim: Colors.grey.shade700, // Darker dim surface
        surfaceTint: Colors.indigo.shade100,
        surfaceBright: Colors
            .grey.shade800, // Slightly lighter for contrast on bright surfaces
        surfaceContainer: Colors.grey.shade900, // Rich dark for container
        surfaceContainerHigh:
            Colors.grey.shade800, // Lighter for elevated container
        surfaceContainerHighest:
            Colors.grey.shade700, // Highest elevated container
        surfaceContainerLow:
            Colors.black87, // Dark but distinguishable from default surface
        surfaceContainerLowest:
            Colors.black, // Deepest dark for lowest container
        onSurface: Colors.white, // Light text on dark surface
        onSurfaceVariant: Colors.grey.shade300, // Lighter variant for surface
        tertiaryContainer: Colors.pink.shade900, // Darker tertiary container
        onTertiaryContainer:
            Colors.pink.shade100, // Lighter onTertiaryContainer
        tertiary: Colors.pink.shade300, // Lighter tertiary
        onTertiary: Colors.black, // Darker text on tertiary
        tertiaryFixed:
            Colors.pink.shade700, // A mid-tone pink for a fixed tertiary
        tertiaryFixedDim:
            Colors.pink.shade500, //Slightly lighter for fixed dim tertiary
        onTertiaryFixed: Colors.white70, // Light text for readability
        onTertiaryFixedVariant:
            Colors.pink.shade200, // Softer, lighter pink for contrast
        error: Colors.red.shade100, // Lighter error
        onError: Colors.black, // Darker text on error
        errorContainer: Colors.red.shade900, // Darker error container
        onErrorContainer: Colors.pink.shade100, // Lighter onErrorContainer
      );

  @override
  DefaultChoiceChipColors get defaultChoiceChipColors =>
      DefaultChoiceChipColors(
        backgroundColor: colorScheme.secondaryContainer,
        selectedBackgroundColor: colorScheme.secondary,
        labelColor: colorScheme.onSecondaryContainer,
        selectedLabelColor: colorScheme.onSecondary,
        avatarColor: colorScheme.secondaryFixedDim,
        selectedAvatarColor: colorScheme.secondaryContainer,
        checkmarkColor: colorScheme.onTertiary,
      );

  @override
  ThemeData get materialThemeData => ThemeData(
        colorScheme: colorScheme,
        dividerTheme: DividerThemeData(
          space: 0,
          color: colorScheme.outlineVariant,
        ),
        useMaterial3: true,
      );
}

/*
  Lighter colors like secondary, primary, tertiary, and error are 
  balanced with their darker counterparts in secondaryContainer, 
  primaryContainer, and tertiaryContainer to ensure the theme suits 
  a high-contrast dark environment.

  on...colors are either pure black or white for high readability on
  their respective backgrounds.
*/
class DefaultHighContrastDarkDQThemeData extends DefaultDQThemeData {
  @override
  ThemeMode get materialThemeMode => ThemeMode.dark;

  @override
  ColorScheme get colorScheme => ColorScheme.highContrastDark(
        brightness: Brightness.dark,
        secondaryContainer:
            Colors.deepPurple.shade900, // Darker version of secondary container
        secondary: Colors.grey.shade300, // Lighter grey for secondary
        onSecondaryContainer: Colors
            .blueGrey.shade100, // Lighter version for onSecondaryContainer
        onSecondary: Colors.black87, // Darker for onSecondary
        secondaryFixedDim:
            Colors.grey.shade300, // Lighter grey for fixed dim secondary
        primaryContainer:
            Colors.indigoAccent.shade700, // Darker primary container
        onPrimaryContainer:
            Colors.indigo.shade100, // Lighter onPrimaryContainer
        primary: Colors.indigo.shade300, // Lighter primary color
        onPrimary: Colors.black, // Darker for onPrimary
        surface: Colors.black87, // Darker surface
        surfaceDim: Colors.grey.shade700, // Darker dim surface
        surfaceTint: Colors.indigo.shade100,
        surfaceBright:
            Colors.grey.shade600, // Slightly lighter for bright surfaces
        surfaceContainer: Colors.grey.shade800, // Rich dark for container
        surfaceContainerHigh:
            Colors.grey.shade700, // Lighter for elevated containers
        surfaceContainerHighest:
            Colors.grey.shade600, // Highest elevated container
        surfaceContainerLow: Colors.black87, // Dark but distinguishable
        surfaceContainerLowest:
            Colors.black, // Deepest black for lowest container
        onSurface: Colors.white, // Light text on dark surface
        onSurfaceVariant: Colors.grey.shade300, // Lighter variant for surface
        tertiaryContainer: Colors.pink.shade900, // Darker tertiary container
        onTertiaryContainer:
            Colors.pink.shade100, // Lighter onTertiaryContainer
        tertiary: Colors.pink.shade300, // Lighter tertiary
        onTertiary: Colors.black, // Darker text on tertiary
        tertiaryFixed: Colors.pink.shade800, // Darker pink for higher contrast
        tertiaryFixedDim:
            Colors.pink.shade700, // Slightly lighter but still high contrast
        onTertiaryFixed:
            Colors.white, // Pure white for strong contrast on fixed tertiary
        onTertiaryFixedVariant:
            Colors.pink.shade200, // Light pink for contrast without being harsh
        error: Colors.red.shade100, // Lighter error
        onError: Colors.black, // Darker text on error
        errorContainer: Colors.red.shade900, // Darker error container
        onErrorContainer: Colors.pink.shade100, // Lighter onErrorContainer
      );

  @override
  DefaultChoiceChipColors get defaultChoiceChipColors =>
      DefaultChoiceChipColors(
        backgroundColor: colorScheme.secondaryContainer,
        selectedBackgroundColor: colorScheme.secondary,
        labelColor: colorScheme.onSecondaryContainer,
        selectedLabelColor: colorScheme.onSecondary,
        avatarColor: colorScheme.secondaryFixedDim,
        selectedAvatarColor: colorScheme.secondaryContainer,
        checkmarkColor: colorScheme.onTertiary,
      );

  @override
  ThemeData get materialThemeData => ThemeData(
        colorScheme: colorScheme,
        dividerTheme: DividerThemeData(
          space: 0,
          color: colorScheme.outlineVariant,
        ),
        useMaterial3: true,
      );
}
