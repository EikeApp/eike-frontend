import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff37618e),
      surfaceTint: Color(0xff37618e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd2e4ff),
      onPrimaryContainer: Color(0xff1b4975),
      secondary: Color(0xff34618e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd0e4ff),
      onSecondaryContainer: Color(0xff174974),
      tertiary: Color(0xff2c638b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffcce5ff),
      onTertiaryContainer: Color(0xff084b72),
      error: Color(0xff8f4a51),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdadb),
      onErrorContainer: Color(0xff72333a),
      surface: Color(0xfff7f9ff),
      onSurface: Color(0xff181c20),
      onSurfaceVariant: Color(0xff42474e),
      outline: Color(0xff73777f),
      outlineVariant: Color(0xffc2c7cf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inversePrimary: Color(0xffa1c9fd),
      primaryFixed: Color(0xffd2e4ff),
      onPrimaryFixed: Color(0xff001c37),
      primaryFixedDim: Color(0xffa1c9fd),
      onPrimaryFixedVariant: Color(0xff1b4975),
      secondaryFixed: Color(0xffd0e4ff),
      onSecondaryFixed: Color(0xff001d35),
      secondaryFixedDim: Color(0xff9fcafc),
      onSecondaryFixedVariant: Color(0xff174974),
      tertiaryFixed: Color(0xffcce5ff),
      onTertiaryFixed: Color(0xff001d31),
      tertiaryFixedDim: Color(0xff99ccfa),
      onTertiaryFixedVariant: Color(0xff084b72),
      surfaceDim: Color(0xffd7dadf),
      surfaceBright: Color(0xfff7f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f4f9),
      surfaceContainer: Color(0xffebeef3),
      surfaceContainerHigh: Color(0xffe6e8ee),
      surfaceContainerHighest: Color(0xffe0e2e8),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003863),
      surfaceTint: Color(0xff37618e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff476f9e),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff003860),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff44709d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00395a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff3d719b),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff5e222a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffa0585f),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff7f9ff),
      onSurface: Color(0xff0e1215),
      onSurfaceVariant: Color(0xff32373d),
      outline: Color(0xff4e535a),
      outlineVariant: Color(0xff696d75),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inversePrimary: Color(0xffa1c9fd),
      primaryFixed: Color(0xff476f9e),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff2c5784),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff44709d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff295783),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff3d719b),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff205981),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc4c7cc),
      surfaceBright: Color(0xfff7f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f4f9),
      surfaceContainer: Color(0xffe6e8ee),
      surfaceContainerHigh: Color(0xffdadde2),
      surfaceContainerHighest: Color(0xffcfd2d7),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002d52),
      surfaceTint: Color(0xff37618e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff1e4b78),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff002e50),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff1a4c77),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff002f4b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff0d4d74),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff511921),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff75353c),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff7f9ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff282d33),
      outlineVariant: Color(0xff454a50),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inversePrimary: Color(0xffa1c9fd),
      primaryFixed: Color(0xff1e4b78),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00345d),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff1a4c77),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff00355a),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff0d4d74),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003655),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb6b9be),
      surfaceBright: Color(0xfff7f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeef1f6),
      surfaceContainer: Color(0xffe0e2e8),
      surfaceContainerHigh: Color(0xffd2d4da),
      surfaceContainerHighest: Color(0xffc4c7cc),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa1c9fd),
      surfaceTint: Color(0xffa1c9fd),
      onPrimary: Color(0xff003259),
      primaryContainer: Color(0xff1b4975),
      onPrimaryContainer: Color(0xffd2e4ff),
      secondary: Color(0xff9fcafc),
      onSecondary: Color(0xff003257),
      secondaryContainer: Color(0xff174974),
      onSecondaryContainer: Color(0xffd0e4ff),
      tertiary: Color(0xff99ccfa),
      onTertiary: Color(0xff003351),
      tertiaryContainer: Color(0xff084b72),
      onTertiaryContainer: Color(0xffcce5ff),
      error: Color(0xffffb2b8),
      onError: Color(0xff561d25),
      errorContainer: Color(0xff72333a),
      onErrorContainer: Color(0xffffdadb),
      surface: Color(0xff101418),
      onSurface: Color(0xffe0e2e8),
      onSurfaceVariant: Color(0xffc2c7cf),
      outline: Color(0xff8c9199),
      outlineVariant: Color(0xff42474e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2e8),
      inversePrimary: Color(0xff37618e),
      primaryFixed: Color(0xffd2e4ff),
      onPrimaryFixed: Color(0xff001c37),
      primaryFixedDim: Color(0xffa1c9fd),
      onPrimaryFixedVariant: Color(0xff1b4975),
      secondaryFixed: Color(0xffd0e4ff),
      onSecondaryFixed: Color(0xff001d35),
      secondaryFixedDim: Color(0xff9fcafc),
      onSecondaryFixedVariant: Color(0xff174974),
      tertiaryFixed: Color(0xffcce5ff),
      onTertiaryFixed: Color(0xff001d31),
      tertiaryFixedDim: Color(0xff99ccfa),
      onTertiaryFixedVariant: Color(0xff084b72),
      surfaceDim: Color(0xff101418),
      surfaceBright: Color(0xff36393e),
      surfaceContainerLowest: Color(0xff0b0f12),
      surfaceContainerLow: Color(0xff181c20),
      surfaceContainer: Color(0xff1c2024),
      surfaceContainerHigh: Color(0xff272a2e),
      surfaceContainerHighest: Color(0xff313539),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc7deff),
      surfaceTint: Color(0xffa1c9fd),
      onPrimary: Color(0xff002747),
      primaryContainer: Color(0xff6b93c4),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffc5dfff),
      onSecondary: Color(0xff002745),
      secondaryContainer: Color(0xff6994c3),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffc1e0ff),
      onTertiary: Color(0xff002841),
      tertiaryContainer: Color(0xff6395c1),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd1d4),
      onError: Color(0xff48121b),
      errorContainer: Color(0xffca7a81),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff101418),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd8dce5),
      outline: Color(0xffaeb2ba),
      outlineVariant: Color(0xff8c9198),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2e8),
      inversePrimary: Color(0xff1d4a76),
      primaryFixed: Color(0xffd2e4ff),
      onPrimaryFixed: Color(0xff001225),
      primaryFixedDim: Color(0xffa1c9fd),
      onPrimaryFixedVariant: Color(0xff003863),
      secondaryFixed: Color(0xffd0e4ff),
      onSecondaryFixed: Color(0xff001224),
      secondaryFixedDim: Color(0xff9fcafc),
      onSecondaryFixedVariant: Color(0xff003860),
      tertiaryFixed: Color(0xffcce5ff),
      onTertiaryFixed: Color(0xff001321),
      tertiaryFixedDim: Color(0xff99ccfa),
      onTertiaryFixedVariant: Color(0xff00395a),
      surfaceDim: Color(0xff101418),
      surfaceBright: Color(0xff414549),
      surfaceContainerLowest: Color(0xff05080b),
      surfaceContainerLow: Color(0xff1a1e22),
      surfaceContainer: Color(0xff24282c),
      surfaceContainerHigh: Color(0xff2f3337),
      surfaceContainerHighest: Color(0xff3a3e42),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe9f0ff),
      surfaceTint: Color(0xffa1c9fd),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff9dc6f9),
      onPrimaryContainer: Color(0xff000c1c),
      secondary: Color(0xffe8f1ff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff9bc6f8),
      onSecondaryContainer: Color(0xff000c1b),
      tertiary: Color(0xffe6f1ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff95c8f6),
      onTertiaryContainer: Color(0xff000c18),
      error: Color(0xffffebec),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffadb3),
      onErrorContainer: Color(0xff210005),
      surface: Color(0xff101418),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffecf0f9),
      outlineVariant: Color(0xffbec3cb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2e8),
      inversePrimary: Color(0xff1d4a76),
      primaryFixed: Color(0xffd2e4ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffa1c9fd),
      onPrimaryFixedVariant: Color(0xff001225),
      secondaryFixed: Color(0xffd0e4ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xff9fcafc),
      onSecondaryFixedVariant: Color(0xff001224),
      tertiaryFixed: Color(0xffcce5ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff99ccfa),
      onTertiaryFixedVariant: Color(0xff001321),
      surfaceDim: Color(0xff101418),
      surfaceBright: Color(0xff4d5055),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1c2024),
      surfaceContainer: Color(0xff2d3135),
      surfaceContainerHigh: Color(0xff383c40),
      surfaceContainerHighest: Color(0xff43474c),
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
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
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
