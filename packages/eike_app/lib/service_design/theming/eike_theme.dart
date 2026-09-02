import 'package:flutter/material.dart';
import 'package:eike_app/service_design/theming/generated/eike_color_scheme.dart.dart';

abstract final class EikeTheme {
  static const fontFamily = 'Roboto';
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
    return _themeFrom(MaterialTheme.lightScheme());
  }

  static ThemeData darkTheme(BuildContext context) {
    return _themeFrom(MaterialTheme.darkScheme());
  }

  static ThemeData _themeFrom(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: colorScheme,
      fontFamily: fontFamily,
    ).applyDefaults();
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
      // "Marken-Chip": reuses secondaryContainer, the same color as the
      // numbered badge on the home screen's tip cards, so a snackbar reads
      // as part of the app rather than a generic system notification.
      snackBarTheme: snackBarTheme.copyWith(
        backgroundColor: colorScheme.secondaryContainer,
        contentTextStyle: TextStyle(
          fontFamily: EikeTheme.fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSecondaryContainer,
        ),
        actionTextColor: colorScheme.onSecondaryContainer,
        behavior: SnackBarBehavior.floating,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(EikeTheme.cornerRadius),
        ),
      ),
    );
  }
}
