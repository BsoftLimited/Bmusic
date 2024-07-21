import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff365e9d),
      surfaceTint: Color(0xff365e9d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff82a8ec),
      onPrimaryContainer: Color(0xff001c40),
      secondary: Color(0xff515f79),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd9e4ff),
      onSecondaryContainer: Color(0xff3c4962),
      tertiary: Color(0xff814a87),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffd091d4),
      onTertiaryContainer: Color(0xff36013f),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff1a1c20),
      onSurfaceVariant: Color(0xff434750),
      outline: Color(0xff737781),
      outlineVariant: Color(0xffc3c6d2),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3035),
      inversePrimary: Color(0xffaac7ff),
      primaryFixed: Color(0xffd6e3ff),
      onPrimaryFixed: Color(0xff001b3e),
      primaryFixedDim: Color(0xffaac7ff),
      onPrimaryFixedVariant: Color(0xff194683),
      secondaryFixed: Color(0xffd6e3ff),
      onSecondaryFixed: Color(0xff0d1c32),
      secondaryFixedDim: Color(0xffb9c7e5),
      onSecondaryFixedVariant: Color(0xff3a4760),
      tertiaryFixed: Color(0xffffd6fe),
      onTertiaryFixed: Color(0xff35013e),
      tertiaryFixedDim: Color(0xfff2b0f5),
      onTertiaryFixedVariant: Color(0xff67326d),
      surfaceDim: Color(0xffdad9df),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3f9),
      surfaceContainer: Color(0xffeeedf3),
      surfaceContainerHigh: Color(0xffe8e7ed),
      surfaceContainerHighest: Color(0xffe2e2e8),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff12427f),
      surfaceTint: Color(0xff365e9d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4e75b5),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff36435c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff677590),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff622e69),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff99609f),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff1a1c20),
      onSurfaceVariant: Color(0xff3f434c),
      outline: Color(0xff5b5f69),
      outlineVariant: Color(0xff777b85),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3035),
      inversePrimary: Color(0xffaac7ff),
      primaryFixed: Color(0xff4e75b5),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff335c9a),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff677590),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4f5c76),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff99609f),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff7e4784),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdad9df),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3f9),
      surfaceContainer: Color(0xffeeedf3),
      surfaceContainerHigh: Color(0xffe8e7ed),
      surfaceContainerHighest: Color(0xffe2e2e8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00214a),
      surfaceTint: Color(0xff365e9d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff12427f),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff142239),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff36435c),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff3d0846),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff622e69),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff20242c),
      outline: Color(0xff3f434c),
      outlineVariant: Color(0xff3f434c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3035),
      inversePrimary: Color(0xffe5ecff),
      primaryFixed: Color(0xff12427f),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff002c5e),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff36435c),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff1f2d45),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff622e69),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff491651),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdad9df),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3f9),
      surfaceContainer: Color(0xffeeedf3),
      surfaceContainerHigh: Color(0xffe8e7ed),
      surfaceContainerHighest: Color(0xffe2e2e8),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffaac7ff),
      surfaceTint: Color(0xffaac7ff),
      onPrimary: Color(0xff002f64),
      primaryContainer: Color(0xff6e94d6),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb9c7e5),
      onSecondary: Color(0xff233148),
      secondaryContainer: Color(0xff323f58),
      onSecondaryContainer: Color(0xffc6d4f3),
      tertiary: Color(0xfff2b0f5),
      onTertiary: Color(0xff4d1a55),
      tertiaryContainer: Color(0xffbc7fc0),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff121317),
      onSurface: Color(0xffe2e2e8),
      onSurfaceVariant: Color(0xffc3c6d2),
      outline: Color(0xff8d909b),
      outlineVariant: Color(0xff434750),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e8),
      inversePrimary: Color(0xff365e9d),
      primaryFixed: Color(0xffd6e3ff),
      onPrimaryFixed: Color(0xff001b3e),
      primaryFixedDim: Color(0xffaac7ff),
      onPrimaryFixedVariant: Color(0xff194683),
      secondaryFixed: Color(0xffd6e3ff),
      onSecondaryFixed: Color(0xff0d1c32),
      secondaryFixedDim: Color(0xffb9c7e5),
      onSecondaryFixedVariant: Color(0xff3a4760),
      tertiaryFixed: Color(0xffffd6fe),
      onTertiaryFixed: Color(0xff35013e),
      tertiaryFixedDim: Color(0xfff2b0f5),
      onTertiaryFixedVariant: Color(0xff67326d),
      surfaceDim: Color(0xff121317),
      surfaceBright: Color(0xff38393e),
      surfaceContainerLowest: Color(0xff0c0e12),
      surfaceContainerLow: Color(0xff1a1c20),
      surfaceContainer: Color(0xff1e2024),
      surfaceContainerHigh: Color(0xff282a2e),
      surfaceContainerHighest: Color(0xff333539),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb1cbff),
      surfaceTint: Color(0xffaac7ff),
      onPrimary: Color(0xff001634),
      primaryContainer: Color(0xff6e94d6),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffbdcbe9),
      onSecondary: Color(0xff07162d),
      secondaryContainer: Color(0xff8391ad),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff7b4fa),
      onTertiary: Color(0xff2d0035),
      tertiaryContainer: Color(0xffbc7fc0),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff121317),
      onSurface: Color(0xfffbfaff),
      onSurfaceVariant: Color(0xffc7cad6),
      outline: Color(0xff9fa3ae),
      outlineVariant: Color(0xff7f838d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e8),
      inversePrimary: Color(0xff1a4785),
      primaryFixed: Color(0xffd6e3ff),
      onPrimaryFixed: Color(0xff00112b),
      primaryFixedDim: Color(0xffaac7ff),
      onPrimaryFixedVariant: Color(0xff00356f),
      secondaryFixed: Color(0xffd6e3ff),
      onSecondaryFixed: Color(0xff031127),
      secondaryFixedDim: Color(0xffb9c7e5),
      onSecondaryFixedVariant: Color(0xff29364f),
      tertiaryFixed: Color(0xffffd6fe),
      onTertiaryFixed: Color(0xff25002c),
      tertiaryFixedDim: Color(0xfff2b0f5),
      onTertiaryFixedVariant: Color(0xff54205b),
      surfaceDim: Color(0xff121317),
      surfaceBright: Color(0xff38393e),
      surfaceContainerLowest: Color(0xff0c0e12),
      surfaceContainerLow: Color(0xff1a1c20),
      surfaceContainer: Color(0xff1e2024),
      surfaceContainerHigh: Color(0xff282a2e),
      surfaceContainerHighest: Color(0xff333539),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffbfaff),
      surfaceTint: Color(0xffaac7ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffb1cbff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffbfaff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffbdcbe9),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffff9fa),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xfff7b4fa),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff121317),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffbfaff),
      outline: Color(0xffc7cad6),
      outlineVariant: Color(0xffc7cad6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e8),
      inversePrimary: Color(0xff002959),
      primaryFixed: Color(0xffdde7ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffb1cbff),
      onPrimaryFixedVariant: Color(0xff001634),
      secondaryFixed: Color(0xffdde7ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffbdcbe9),
      onSecondaryFixedVariant: Color(0xff07162d),
      tertiaryFixed: Color(0xffffdcfd),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xfff7b4fa),
      onTertiaryFixedVariant: Color(0xff2d0035),
      surfaceDim: Color(0xff121317),
      surfaceBright: Color(0xff38393e),
      surfaceContainerLowest: Color(0xff0c0e12),
      surfaceContainerLow: Color(0xff1a1c20),
      surfaceContainer: Color(0xff1e2024),
      surfaceContainerHigh: Color(0xff282a2e),
      surfaceContainerHighest: Color(0xff333539),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
