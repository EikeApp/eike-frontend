import 'package:feat_app_protection/presentation/app_protection_screen.dart';
import 'package:feat_contact/presentation/contact_screen.dart';
import 'package:feat_database_provider/presentation/eike_database_provider.dart';
import 'package:feat_home/presentation/home_screen.dart';
import 'package:feat_imprint/presentation/imprint_screen.dart';
import 'package:feat_licenses/presentation/licenses_screen.dart';
import 'package:feat_navigation/eike_routes.dart';
import 'package:feat_notification/presentation/widgets/notification_dialog_provider.dart';
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
          return NotificationDialogProvider(
            child: const EikeDatabaseProvider(
              child: UrlLauncherProvider(
                child: MainScreen(),
              ),
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
          EikeRoute.licenses => MaterialPageRoute(
            settings: settings,
            builder: (context) => const LicensesScreen(),
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
        body: FadingAnimatedStack(
          index: _currentIndex,
          child: IndexedStack(
            index: _currentIndex,
            children: [
              _buildTabNavigator(0, EikeRoute.home),
              _buildTabNavigator(1, EikeRoute.contact),
              _buildTabNavigator(2, EikeRoute.settings),
            ],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: Padding(
          padding: EikeTheme.pagePadding,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: _BottomBar(
              currentIndex: _currentIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

class FadingAnimatedStack extends StatefulWidget {
  const FadingAnimatedStack({
    super.key,
    required this.index,
    required this.child,
  });

  final int index;
  final Widget child;

  @override
  State<FadingAnimatedStack> createState() => _FadingAnimatedStackState();
}

class _FadingAnimatedStackState extends State<FadingAnimatedStack>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late final _animation = Tween(begin: 1.0, end: 0.0).animate(
    CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
  );

  late int index = widget.index;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FadingAnimatedStack oldWidget) {
    if (oldWidget.index != widget.index) {
      _runAnimation();
    }

    super.didUpdateWidget(oldWidget);
  }

  Future<void> _runAnimation() async {
    _controller.value = 1.0;
    setState(() {
      index = widget.index;
    });
    _controller.animateTo(0.0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final int currentIndex;
  final void Function(int) onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colors.surfaceContainerLowest,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: EikeTheme.horizontalCardPadding,
        ),
        child: SizedBox(
          height: kToolbarHeight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: EikeTheme.horizontalComponentSpacingMedium,
            children: [
              Flexible(
                flex: currentIndex == 0 ? 2 : 1,
                child: _BottomBarButton(
                  label: '7 Sachen',
                  icon: Icons.favorite_outline,
                  selectedIcon: Icons.favorite,
                  isSelected: currentIndex == 0,
                  onClick: () => onDestinationSelected(0),
                ),
              ),
              Flexible(
                flex: currentIndex == 1 ? 2 : 1,
                child: _BottomBarButton(
                  label: 'Kontakt',
                  icon: Icons.phone_outlined,
                  selectedIcon: Icons.phone,
                  isSelected: currentIndex == 1,
                  onClick: () => onDestinationSelected(1),
                ),
              ),
              Flexible(
                flex: currentIndex == 2 ? 2 : 1,
                child: _BottomBarButton(
                  label: 'Einstellungen',
                  icon: Icons.settings_outlined,
                  selectedIcon: Icons.settings,
                  isSelected: currentIndex == 2,
                  onClick: () => onDestinationSelected(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomBarButton extends StatelessWidget {
  const _BottomBarButton({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.isSelected,
    required this.onClick,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isSelected ? 120 : 50,
        height: kToolbarHeight / 1.6,
        decoration: BoxDecoration(
          color: isSelected ? context.colors.primaryContainer : null,
          borderRadius: BorderRadius.circular(EikeTheme.cornerRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: EikeTheme.horizontalComponentSpacingSmall,
          children: [
            Flexible(
              child: Icon(
                isSelected ? selectedIcon : icon,
                color: context.colors.onPrimaryContainer,
              ),
            ),
            isSelected
                ? Flexible(
                    child: FittedBox(
                      child: Text(
                        label,
                        style: TextStyle(
                          color: context.colors.onPrimaryContainer,
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
