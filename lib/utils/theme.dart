import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4281753245),
      surfaceTint: Color(4281753245),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4286753004),
      onPrimaryContainer: Color(4278197312),
      secondary: Color(4283522937),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292470015),
      onSecondaryContainer: Color(4282141026),
      tertiary: Color(4286663303),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4291858900),
      onTertiaryContainer: Color(4281729343),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294572543),
      onSurface: Color(4279901216),
      onSurfaceVariant: Color(4282599248),
      outline: Color(4285757313),
      outlineVariant: Color(4291020498),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281282613),
      inversePrimary: Color(4289382399),
      primaryFixed: Color(4292273151),
      onPrimaryFixed: Color(4278197054),
      primaryFixedDim: Color(4289382399),
      onPrimaryFixedVariant: Color(4279846531),
      secondaryFixed: Color(4292273151),
      onSecondaryFixed: Color(4279049266),
      secondaryFixedDim: Color(4290365413),
      onSecondaryFixedVariant: Color(4282009440),
      tertiaryFixed: Color(4294956798),
      onTertiaryFixed: Color(4281663806),
      tertiaryFixedDim: Color(4294095093),
      onTertiaryFixedVariant: Color(4284953197),
      surfaceDim: Color(4292532703),
      surfaceBright: Color(4294572543),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294177785),
      surfaceContainer: Color(4293848563),
      surfaceContainerHigh: Color(4293453805),
      surfaceContainerHighest: Color(4293059304),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4279386751),
      surfaceTint: Color(4281753245),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4283332021),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281746268),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4284970384),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4284624489),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4288241823),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294572543),
      onSurface: Color(4279901216),
      onSurfaceVariant: Color(4282336076),
      outline: Color(4284178281),
      outlineVariant: Color(4286020485),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281282613),
      inversePrimary: Color(4289382399),
      primaryFixed: Color(4283332021),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4281556122),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4284970384),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283391094),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4288241823),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4286465924),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292532703),
      surfaceBright: Color(4294572543),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294177785),
      surfaceContainer: Color(4293848563),
      surfaceContainerHigh: Color(4293453805),
      surfaceContainerHighest: Color(4293059304),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278198602),
      surfaceTint: Color(4281753245),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4279386751),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4279509561),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4281746268),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4282189894),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4284624489),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294572543),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280296492),
      outline: Color(4282336076),
      outlineVariant: Color(4282336076),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281282613),
      inversePrimary: Color(4293258495),
      primaryFixed: Color(4279386751),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278201438),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4281746268),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280233285),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4284624489),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4282979921),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292532703),
      surfaceBright: Color(4294572543),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294177785),
      surfaceContainer: Color(4293848563),
      surfaceContainerHigh: Color(4293453805),
      surfaceContainerHighest: Color(4293059304),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4289382399),
      surfaceTint: Color(4289382399),
      onPrimary: Color(4278202212),
      primaryContainer: Color(4285437142),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290365413),
      onSecondary: Color(4280496456),
      secondaryContainer: Color(4281483096),
      onSecondaryContainer: Color(4291220723),
      tertiary: Color(4294095093),
      onTertiary: Color(4283243093),
      tertiaryContainer: Color(4290543552),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279374615),
      onSurface: Color(4293059304),
      onSurfaceVariant: Color(4291020498),
      outline: Color(4287467675),
      outlineVariant: Color(4282599248),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293059304),
      inversePrimary: Color(4281753245),
      primaryFixed: Color(4292273151),
      onPrimaryFixed: Color(4278197054),
      primaryFixedDim: Color(4289382399),
      onPrimaryFixedVariant: Color(4279846531),
      secondaryFixed: Color(4292273151),
      onSecondaryFixed: Color(4279049266),
      secondaryFixedDim: Color(4290365413),
      onSecondaryFixedVariant: Color(4282009440),
      tertiaryFixed: Color(4294956798),
      onTertiaryFixed: Color(4281663806),
      tertiaryFixedDim: Color(4294095093),
      onTertiaryFixedVariant: Color(4284953197),
      surfaceDim: Color(4279374615),
      surfaceBright: Color(4281874750),
      surfaceContainerLowest: Color(4278980114),
      surfaceContainerLow: Color(4279901216),
      surfaceContainer: Color(4280164388),
      surfaceContainerHigh: Color(4280822318),
      surfaceContainerHighest: Color(4281546041),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4289842175),
      surfaceTint: Color(4289382399),
      onPrimary: Color(4278195764),
      primaryContainer: Color(4285437142),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290628585),
      onSecondary: Color(4278654509),
      secondaryContainer: Color(4286812589),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294423802),
      onTertiary: Color(4281139253),
      tertiaryContainer: Color(4290543552),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279374615),
      onSurface: Color(4294703871),
      onSurfaceVariant: Color(4291283670),
      outline: Color(4288652206),
      outlineVariant: Color(4286546829),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293059304),
      inversePrimary: Color(4279912325),
      primaryFixed: Color(4292273151),
      onPrimaryFixed: Color(4278194475),
      primaryFixedDim: Color(4289382399),
      onPrimaryFixedVariant: Color(4278203759),
      secondaryFixed: Color(4292273151),
      onSecondaryFixed: Color(4278391079),
      secondaryFixedDim: Color(4290365413),
      onSecondaryFixedVariant: Color(4280890959),
      tertiaryFixed: Color(4294956798),
      onTertiaryFixed: Color(4280614956),
      tertiaryFixedDim: Color(4294095093),
      onTertiaryFixedVariant: Color(4283703387),
      surfaceDim: Color(4279374615),
      surfaceBright: Color(4281874750),
      surfaceContainerLowest: Color(4278980114),
      surfaceContainerLow: Color(4279901216),
      surfaceContainer: Color(4280164388),
      surfaceContainerHigh: Color(4280822318),
      surfaceContainerHighest: Color(4281546041),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294703871),
      surfaceTint: Color(4289382399),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4289842175),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294703871),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4290628585),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294965754),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4294423802),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279374615),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294703871),
      outline: Color(4291283670),
      outlineVariant: Color(4291283670),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293059304),
      inversePrimary: Color(4278200665),
      primaryFixed: Color(4292732927),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4289842175),
      onPrimaryFixedVariant: Color(4278195764),
      secondaryFixed: Color(4292732927),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4290628585),
      onSecondaryFixedVariant: Color(4278654509),
      tertiaryFixed: Color(4294958333),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4294423802),
      onTertiaryFixedVariant: Color(4281139253),
      surfaceDim: Color(4279374615),
      surfaceBright: Color(4281874750),
      surfaceContainerLowest: Color(4278980114),
      surfaceContainerLow: Color(4279901216),
      surfaceContainer: Color(4280164388),
      surfaceContainerHigh: Color(4280822318),
      surfaceContainerHighest: Color(4281546041),
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
