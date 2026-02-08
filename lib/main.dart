import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'theme/util.dart';
import 'theme/theme.dart';

import 'screens/contact_screen.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';

import 'db/app_database.dart';
import 'db/db_key_manager.dart';
import 'security/app_lock_storage.dart';
import 'security/app_lock_gate.dart';
import 'security/first_run_reset.dart';
import 'db/sqlcipher_setup.dart';

Future<void> main() async {
  LicenseRegistry.addLicense(() async* {
    final text = await rootBundle.loadString('assets/fonts/Inter-license.txt');
    yield LicenseEntryWithLineBreaks(['Inter'], text);
  });

  WidgetsFlutterBinding.ensureInitialized();

  await setupSqlCipher();

  // First Run Reset
  await FirstRunReset.run();

  // Secure Storage + Key Manager
  final storage = const FlutterSecureStorage();
  final keyManager = DbKeyManager(storage);

  // Drift DB (öffnet verschlüsselt; LazyDatabase kümmert sich um async open)
  final db = AppDatabase(keyManager);

  final lockStorage = AppLockStorage(storage);

  runApp(
    Provider<AppDatabase>.value(
      value: db,
      child: MyApp(lockStorage: lockStorage),
    ),
  );
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
            GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
          ],
        ),
        // Kontakt Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/contact',
              builder: (context, state) => const ContactScreen(),
            ),
          ],
        ),
        // Einstellungen Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.lockStorage});
  final AppLockStorage lockStorage;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    // DB schließen, wenn App beendet wird
    context.read<AppDatabase>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context, "Inter", "Inter");
    final MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp.router(
      title: 'EIKE',
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: _router,
      builder: (context, child) {
        return AppLockGate(
          storage: widget.lockStorage,
          child: child ?? const SizedBox.shrink(),
        );
      },
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
