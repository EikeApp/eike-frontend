import 'package:eike_app/feat_database_provider/presentation/eike_database_provider.dart';
import 'package:eike_app/feat_navigation/app_router.dart';
import 'package:eike_app/feat_notification/presentation/widgets/notification_dialog_provider.dart';
import 'package:eike_app/feat_splash/presentation/animated_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:eike_app/service_app_info/data/repositories/app_info_repository_impl.dart';
import 'package:eike_app/service_app_info/domain/repositories/app_info_repository.dart';
import 'package:eike_app/service_design/theming/eike_theme.dart';
import 'package:eike_app/service_logging/eike_logger.dart';
import 'package:eike_app/service_url_launcher/presentation/url_launcher_provider.dart';
import 'package:cupertino_ui/cupertino_ui.dart'
    show GlobalCupertinoLocalizations;
import 'package:material_ui/material_ui.dart';

Future<void> main() async {
  LicenseRegistry.addLicense(() async* {
    final robotoLicense = await rootBundle.loadString(
      'assets/fonts/Roboto/OFL.txt',
    );
    yield LicenseEntryWithLineBreaks(['Roboto'], robotoLicense);
  });

  WidgetsFlutterBinding.ensureInitialized();

  const secureStorage = FlutterSecureStorage();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: secureStorage),
        RepositoryProvider.value(value: EikeLogger.pretty()),
        RepositoryProvider<AppInfoRepository>.value(
          value: AppInfoRepositoryImpl(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class const MyApp({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Eike',
      theme: EikeTheme.lightTheme(context),
      darkTheme: EikeTheme.darkTheme(context),
      themeMode: .system,
      debugShowCheckedModeBanner: false,
      routerConfig: eikeRouter,
      supportedLocales: const <Locale>[Locale('de')],
      locale: const Locale('de'),
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return AnimatedSplashScreen(
          app: NotificationDialogProvider(
            child: EikeDatabaseProvider(
              child: UrlLauncherProvider(
                child: child!,
              ),
            ),
          ),
        );
      },
    );
  }
}
