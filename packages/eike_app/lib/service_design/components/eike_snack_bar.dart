import 'package:flutter/material.dart';
import 'package:eike_app/service_design/theming/eike_theme.dart';

/// Shows snack bars styled consistently with the app's "Marken-Chip"
/// design — color and shape come from [EikeTheme]'s `snackBarTheme`, this
/// just adds the leading icon and keeps calls to a single line.
abstract final class EikeSnackBar {
  static void show(
    BuildContext context,
    String message, {
    IconData icon = Icons.check_circle_outline_rounded,
  }) {
    final colors = context.colors;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            spacing: EikeTheme.horizontalComponentSpacingSmall,
            children: [
              Icon(icon, size: 18, color: colors.onSecondaryContainer),
              Expanded(child: Text(message)),
            ],
          ),
        ),
      );
  }
}
