import 'package:eike_app/service_design/theming/eike_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      extendBody: true,
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: navigationShell.currentIndex,
        onItemSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: EikeTheme.horizontalPagePadding,
          right: EikeTheme.horizontalPagePadding,
          bottom: EikeTheme.verticalPagePadding * 0.5,
        ),
        child: SizedBox(
          height: 60,
          child: Card(
            color: context.colors.surfaceContainerLowest,
            elevation: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: _DestinationItem(
                    title: '7 Sachen',
                    icon: Icons.favorite_outline_rounded,
                    selectedIcon: Icons.favorite,
                    isSelected: selectedIndex == 0,
                    onClick: () => onItemSelected(0),
                  ),
                ),
                Flexible(
                  child: _DestinationItem(
                    title: 'Kontakte',
                    icon: Icons.phone_outlined,
                    selectedIcon: Icons.phone,
                    isSelected: selectedIndex == 1,
                    onClick: () => onItemSelected(1),
                  ),
                ),
                Flexible(
                  child: _DestinationItem(
                    title: 'Einst.',
                    icon: Icons.settings_outlined,
                    selectedIcon: Icons.settings,
                    isSelected: selectedIndex == 2,
                    onClick: () => onItemSelected(2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DestinationItem extends StatelessWidget {
  const _DestinationItem({
    required this.title,
    required this.icon,
    required this.selectedIcon,
    required this.isSelected,
    required this.onClick,
  });

  final String title;
  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: GestureDetector(
          onTap: onClick,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected ? context.colors.secondaryContainer : null,
              borderRadius: BorderRadius.circular(EikeTheme.cornerRadius),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                spacing: EikeTheme.horizontalComponentSpacingSmall * 0.5,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isSelected ? selectedIcon : icon,
                    color: context.colors.primary,
                  ),
                  Flexible(
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 200),
                      child: isSelected
                          ? FittedBox(
                              child: Text(
                                title,
                                style: TextStyle(color: context.colors.primary),
                              ),
                            )
                          : SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
