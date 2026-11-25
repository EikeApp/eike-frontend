import 'package:material_ui/material_ui.dart';

class const EikeAppBar({
  required final String title,
  final Widget? leading,
  super.key,
}) extends StatelessWidget implements PreferredSizeWidget {
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
          fontWeight: .w700,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1, color: theme.colorScheme.outlineVariant),
      ),
    );
  }
}
