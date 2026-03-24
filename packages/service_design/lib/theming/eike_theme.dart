import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_design/theming/generated/eike_color_scheme.dart.dart';

abstract final class EikeTheme {
  static const horizontalPagePadding = 16.0;
  static const verticalPagePadding = 16.0;
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(
    horizontal: horizontalPagePadding,
    vertical: verticalPagePadding,
  );

  static const horizontalCardPadding = 16.0;
  static const verticalCardPadding = 16.0;
  static const cardPadding = EdgeInsets.symmetric(
    horizontal: horizontalCardPadding,
    vertical: verticalCardPadding,
  );

  static const verticalComponentSpacingSmall = 8.0;
  static const verticalComponentSpacingMedium = 16.0;
  static const verticalComponentSpacingLarge = 24.0;

  static const horizontalComponentSpacingSmall = 8.0;
  static const horizontalComponentSpacingMedium = 16.0;
  static const horizontalComponentSpacingLarge = 24.0;

  static const cornerRadius = 16.0;

  static ThemeData lightTheme(BuildContext context) {
    return FlexColorScheme.light(
      // scheme: FlexScheme.blueM3,
      colorScheme: EikeColorScheme.lightScheme(),
      textTheme: GoogleFonts.interTextTheme(),
      appBarStyle: FlexAppBarStyle.surface,
    ).toTheme.applyDefaults();
  }

  static ThemeData darkTheme(BuildContext context) {
    return FlexColorScheme.dark(
      // scheme: FlexScheme.blueM3,
      colorScheme: EikeColorScheme.darkScheme(),
      textTheme: GoogleFonts.interTextTheme(),
      appBarStyle: FlexAppBarStyle.surface,
    ).toTheme.applyDefaults();
  }
}

extension ThemeGetters on BuildContext {
  ColorScheme get colors => ColorScheme.of(this);
  TextTheme get textTheme => TextTheme.of(this);
}

extension on ThemeData {
  ThemeData applyDefaults() {
    return copyWith(
      appBarTheme: appBarTheme.copyWith(centerTitle: true),
      cardTheme: cardTheme.copyWith(
        margin: EdgeInsets.zero, // We don't want cards to inflate empty space
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(EikeTheme.cornerRadius),
          side: BorderSide(
            color: colorScheme.surfaceContainer,
            width: 2.0,
          ),
        ),
      ),
      inputDecorationTheme: inputDecorationTheme.copyWith(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.surfaceContainer,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(
            EikeTheme.cornerRadius,
          ),
        ),
      ),
    );
  }
}
