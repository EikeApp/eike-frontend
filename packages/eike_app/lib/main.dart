import 'package:feat_app_protection/presentation/app_protection_screen.dart';
import 'package:feat_contact/presentation/contact_screen.dart';
import 'package:feat_database_provider/presentation/eike_database_provider.dart';
import 'package:feat_home/presentation/home_screen.dart';
import 'package:feat_imprint/presentation/imprint_screen.dart';
import 'package:feat_navigation/eike_routes.dart';
import 'package:feat_settings/presentation/settings_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:service_auth/data/repositories/local_auth_repository_impl.dart';
import 'package:service_auth/domain/repositories/local_auth_repository.dart';
import 'package:service_design/theming/eike_theme.dart';
import 'package:service_logging/eike_logger.dart';
import 'package:service_settings/data/repositories/eike_settings_repository_impl.dart';
import 'package:service_settings/domain/repositories/eike_settings_repository.dart';
import 'package:service_url_launcher/presentation/url_launcher_provider.dart';
import 'package:feat_privacy_policy/presentation/privacy_policy_screen.dart';

Future<void> main() async {
  LicenseRegistry.addLicense(() async* {
    final text = await rootBundle.loadString('assets/fonts/Inter-license.txt');
    yield LicenseEntryWithLineBreaks(['Inter'], text);
  });

  WidgetsFlutterBinding.ensureInitialized();

  final secureStorage = FlutterSecureStorage();
  final rxStorage = RxSharedPreferences.getInstance();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: secureStorage),
        RepositoryProvider.value(value: rxStorage),
        RepositoryProvider.value(value: EikeLogger.pretty()),
        RepositoryProvider<LocalAuthRepository>.value(
          value: LocalAuthRepositoryImpl(),
        ),
        RepositoryProvider<EikeSettingsRepository>(
          create: (context) {
            return EikeSettingsRepositoryImpl(RepositoryProvider.of(context));
          },
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eike',
      theme: EikeTheme.lightTheme(context),
      darkTheme: EikeTheme.darkTheme(context),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: AppProtectionScreen(
        builder: (context) {
          return const EikeDatabaseProvider(
            child: UrlLauncherProvider(
              child: MainScreen(),
            ),
          );
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Ein NavigatorKey pro Tab
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  // Zurück-Button korrekt behandeln
  Future<bool> _onWillPop() async {
    final navigator = _navigatorKeys[_currentIndex].currentState!;
    if (navigator.canPop()) {
      navigator.pop();
      return false;
    }

    return true;
  }

  Widget _buildTabNavigator(int index, EikeRoute initialRoute) {
    return Navigator(
      key: _navigatorKeys[index],
      initialRoute: initialRoute.route,
      onGenerateRoute: (settings) {
        final associatedRoute = EikeRoute.values
            .where((route) => route.route == settings.name)
            .firstOrNull;
        if (associatedRoute == null) {
          return null;
        }

        return switch (associatedRoute) {
          EikeRoute.home => MaterialPageRoute(
            settings: settings,
            builder: (context) => const HomeScreen(),
          ),
          EikeRoute.contact => MaterialPageRoute(
            settings: settings,
            builder: (context) => const ContactScreen(),
          ),
          EikeRoute.settings => MaterialPageRoute(
            settings: settings,
            builder: (context) => const SettingsScreen(),
          ),
          EikeRoute.imprint => MaterialPageRoute(
            settings: settings,
            builder: (context) => const ImprintScreen(),
          ),
          EikeRoute.privacyPolicy => MaterialPageRoute(
            settings: settings,
            builder: (context) => const PrivacyPolicyScreen(),
          ),
        };
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (!didPop) await _onWillPop();
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            _buildTabNavigator(0, EikeRoute.home),
            _buildTabNavigator(1, EikeRoute.contact),
            _buildTabNavigator(2, EikeRoute.settings),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          labelBehavior: .onlyShowSelected,
          onDestinationSelected: (index) {
            setState(() => _currentIndex = index);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.favorite_outline),
              selectedIcon: Icon(Icons.favorite),
              label: 'Meine 7 Sachen',
            ),
            NavigationDestination(
              icon: Icon(Icons.phone_outlined),
              selectedIcon: Icon(Icons.phone),
              label: 'Kontakt',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: 'Einstellungen',
            ),
          ],
        ),
      ),
    );
  }
}
