import 'package:flutter/material.dart';

// Custom BottomNavigationBar that works with only 1 item
// NOTE: Once a second item is added, this can be replaced with
// the standard Flutter BottomNavigationBar
class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    required this.currentIndex,
    required this.onTap,
    required this.items,
    super.key,
  });

  final int currentIndex;
  final Function(int) onTap;
  final List<CustomNavBarItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
        color: Colors.black.withAlpha(26),
        blurRadius: 8,
        offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              items.length,
              (index) => _NavBarButton(
                item: items[index],
                isSelected: index == currentIndex,
                onTap: () => onTap(index),
                colorScheme: colorScheme,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarButton extends StatelessWidget {
  const _NavBarButton({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.colorScheme,
  });

  final CustomNavBarItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomNavBarItem {
  const CustomNavBarItem({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}
