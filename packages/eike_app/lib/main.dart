import 'package:eike_app/feat_app_protection/presentation/app_protection_screen.dart';
import 'package:eike_app/feat_database_provider/presentation/eike_database_provider.dart';
import 'package:eike_app/feat_navigation/app_router.dart';
import 'package:eike_app/feat_notification/presentation/widgets/notification_dialog_provider.dart';
import 'package:eike_app/feat_splash/presentation/animated_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:eike_app/service_app_info/data/repositories/app_info_repository_impl.dart';
import 'package:eike_app/service_app_info/domain/repositories/app_info_repository.dart';
import 'package:eike_app/service_auth/data/repositories/local_auth_repository_impl.dart';
import 'package:eike_app/service_auth/domain/repositories/local_auth_repository.dart';
import 'package:eike_app/service_design/theming/eike_theme.dart';
import 'package:eike_app/service_logging/eike_logger.dart';
import 'package:eike_app/service_settings/data/repositories/eike_settings_repository_impl.dart';
import 'package:eike_app/service_settings/domain/repositories/eike_settings_repository.dart';
import 'package:eike_app/service_url_launcher/presentation/url_launcher_provider.dart';

Future<void> main() async {
  LicenseRegistry.addLicense(() async* {
    final robotoLicense = await rootBundle.loadString(
      'assets/fonts/Roboto/OFL.txt',
    );
    yield LicenseEntryWithLineBreaks(['Roboto'], robotoLicense);
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
        RepositoryProvider<AppInfoRepository>.value(
          value: AppInfoRepositoryImpl(),
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
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Eike',
      theme: EikeTheme.lightTheme(context),
      darkTheme: EikeTheme.darkTheme(context),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: eikeRouter,
      supportedLocales: const <Locale>[Locale('de')],
      locale: Locale('de'),
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return AnimatedSplashScreen(
          app: NotificationDialogProvider(
            child: AppProtectionScreen(
              builder: (context) {
                return EikeDatabaseProvider(
                  child: UrlLauncherProvider(
                    child: child!,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
