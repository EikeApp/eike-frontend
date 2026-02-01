import 'package:flutter/material.dart';

TextTheme createTextTheme(
  BuildContext context,
  String bodyFontString,
  String displayFontString,
) {
  final base = Theme.of(context).textTheme;
  return base.apply(
    fontFamily: bodyFontString,
    displayColor: base.bodyLarge?.color,
    bodyColor: base.bodyLarge?.color,
  );
}
