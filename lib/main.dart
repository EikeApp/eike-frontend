import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'widgets/custom_bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

// GoRouter Config
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        // Home Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        // WEITERE SEITEN HIER HINZUFÜGEN:
        // Einstellungen Branch (auskommentiert - entferne /* */ um zu aktivieren)
        /* StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const PlaceholderScreen(title: 'Einstellungen'),
            ),
          ],
        ), */
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EIKE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

// Scaffold with BottomNavigationBar
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      // NOTE: Using CustomBottomNavBar because it works with only 1 item.
      // Once a second item is added, this can be replaced with the standard Flutter BottomNavigationBar
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        items: const [
          CustomNavBarItem(
            icon: Icons.favorite,
            label: 'Meine 7 Sachen',
          ),
        ],
      ),
    );
  }
}
