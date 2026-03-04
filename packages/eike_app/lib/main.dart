import 'package:feat_database_provider/presentation/eike_database_provider.dart';
import 'package:feat_home/presentation/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'theme/util.dart';
import 'theme/theme.dart';

import 'screens/contact_screen.dart';

import 'db/app_database.dart';
import 'security/app_lock_storage.dart';
import 'security/app_lock_gate.dart';
import 'security/first_run_reset.dart';

Future<void> main() async {
  LicenseRegistry.addLicense(() async* {
    final text = await rootBundle.loadString('assets/fonts/Inter-license.txt');
    yield LicenseEntryWithLineBreaks(['Inter'], text);
  });

  WidgetsFlutterBinding.ensureInitialized();

  // await setupSqlCipher();

  // First Run Reset
  await FirstRunReset.run();

  // Secure Storage + Key Manager
  final storage = const FlutterSecureStorage();
  // final keyManager = DbKeyManager(storage);

  // Drift DB (öffnet verschlüsselt; LazyDatabase kümmert sich um async open)
  // final db = AppDatabase(keyManager);

  final lockStorage = AppLockStorage(storage);

  runApp(
    RepositoryProvider.value(
      value: storage,
      child: MyApp(lockStorage: lockStorage),
    ),
  );
}

// GoRouter Config
// final GoRouter _router = GoRouter(
//   initialLocation: '/',
//   routes: <RouteBase>[
//     StatefulShellRoute.indexedStack(
//       builder: (context, state, navigationShell) {
//         return ScaffoldWithNavBar(navigationShell: navigationShell);
//       },
//       branches: [
//         // Home Branch
//         StatefulShellBranch(
//           routes: [
//             GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
//           ],
//         ),
//         // Kontakt Branch
//         StatefulShellBranch(
//           routes: [
//             GoRoute(
//               path: '/contact',
//               builder: (context, state) => const ContactScreen(),
//             ),
//           ],
//         ),
//         // Einstellungen Branch
//         // StatefulShellBranch(
//         //   routes: [
//         //     GoRoute(
//         //       path: '/settings',
//         //       builder: (context, state) => const SettingsScreen(),
//         //     ),
//         //   ],
//         // ),
//       ],
//     ),
//   ],
// );

class MyApp extends StatelessWidget {
  static final _navigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'navigator_key',
  );

  const MyApp({super.key, required this.lockStorage});
  final AppLockStorage lockStorage;

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context, "Inter", "Inter");
    final MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'EIKE',
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      home: EikeDatabaseProvider(
        child: AppLockGate(
          storage: lockStorage,
          child: Navigator(
            key: _navigatorKey,
            onGenerateRoute: (settings) {
              if (settings.name == '/') {
                return MaterialPageRoute(
                  settings: settings,
                  builder: (context) {
                    return const HomeScreen();
                  },
                );
              }

              return null;
            },
          ),
        ),
      ),
    );
  }
}

// Scaffold with BottomNavigationBar
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: /* TODO: Decide if ripple effect should stay */ /* Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: */ BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
        items: [
          BottomNavigationBarItem(
            icon: const _NavIcon(icon: Icons.favorite_outline),
            activeIcon: _ActiveNavIcon(icon: Icons.favorite_outline),
            backgroundColor: Theme.of(context).colorScheme.primary,
            label: 'Meine 7 Sachen',
          ),
          BottomNavigationBarItem(
            icon: const _NavIcon(icon: Icons.phone),
            activeIcon: _ActiveNavIcon(icon: Icons.phone),
            backgroundColor: Theme.of(context).colorScheme.primary,
            label: 'Kontakt',
          ),
          BottomNavigationBarItem(
            icon: const _NavIcon(icon: Icons.settings),
            activeIcon: _ActiveNavIcon(icon: Icons.settings),
            backgroundColor: Theme.of(context).colorScheme.primary,
            label: 'Einstellungen',
          ),
        ],
      ),
      /* ), */
    );
  }
}

class _ActiveNavIcon extends StatelessWidget {
  const _ActiveNavIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 36,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: colorScheme.primary.withValues(alpha: 0.14),
          ),
          child: Icon(icon, color: colorScheme.primary),
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 36, child: Center(child: Icon(icon)));
  }
}
