import 'package:flutter/material.dart';

class EikeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EikeAppBar({required this.title, this.leading, super.key});

  final String title;
  final Widget? leading;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      leading: leading,
      centerTitle: true,
      backgroundColor: theme.colorScheme.surface,
      scrolledUnderElevation: 0,
      elevation: 0,
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1, color: theme.colorScheme.outlineVariant),
      ),
    );
  }
}
