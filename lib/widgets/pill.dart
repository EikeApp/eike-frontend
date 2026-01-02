import 'package:flutter/material.dart';

class Pill extends StatelessWidget {
  const Pill({
    required this.icon,
    required this.label,
    this.alert = false,
    this.disabled = false,
    this.fullWidth = false,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
    super.key,
  });

  final IconData icon;
  final String label;
  final bool alert;
  final bool disabled;
  final bool fullWidth;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Determine base colors
    final Color baseBg;
    final Color baseFg;
    final Color baseBorder;

    if (alert) {
      baseBg = theme.colorScheme.errorContainer;
      baseFg = theme.colorScheme.onErrorContainer;
      baseBorder = theme.colorScheme.errorContainer;
    } else if (disabled) {
      baseBg = Colors.transparent;
      baseFg = theme.colorScheme.onSurfaceVariant;
      baseBorder = theme.colorScheme.outlineVariant;
    } else {
      baseBg = Colors.transparent;
      baseFg = theme.colorScheme.primary;
      baseBorder = theme.colorScheme.outlineVariant;
    }

    final Color bg = backgroundColor ?? baseBg;
    final Color fg = foregroundColor ?? baseFg;
    final Color br = backgroundColor != null ? backgroundColor! : baseBorder;
    final TextStyle? labelStyle = (textStyle ?? theme.textTheme.bodyMedium)
        ?.copyWith(
          fontWeight: textStyle?.fontWeight ?? FontWeight.w600,
          color: textStyle?.color ?? fg,
        );

    final button = FilledButton.icon(
      onPressed: disabled ? null : (onPressed ?? () {}),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        side: BorderSide(color: br),
        backgroundColor: bg,
        disabledBackgroundColor: bg,
        foregroundColor: fg,
        disabledForegroundColor: fg,
      ),
      icon: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Icon(icon, size: 24),
      ),
      label: Text(label, style: labelStyle),
    );

    if (fullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}
