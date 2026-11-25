import 'dart:io';

import 'package:eike_app/feat_licenses/presentation/license_text_screen.dart';
import 'package:eike_app/feat_licenses/presentation/licenses_screen.dart';
import 'package:eike_app/feat_notification/domain/models/eike_notification.dart';
import 'package:eike_app/feat_notification/domain/repositories/notification_repository.dart';
import 'package:eike_app/service_design/components/eike_titled_card.dart';
import 'package:eike_app/service_design/theming/eike_theme.dart';
import 'package:eike_app/service_url_launcher/domain/repositories/url_launcher_repository.dart';
import 'package:eike_app/service_url_launcher/presentation/bloc/url_launcher_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeUrlLauncherRepository implements UrlLauncherRepository {
  final launched = <Uri>[];

  @override
  Future<bool> launch(Uri uri) async {
    launched.add(uri);
    return true;
  }
}

class _FakeNotificationRepository implements NotificationRepository {
  @override
  Future<void> closeStream() async {}

  @override
  void emitNotification(EikeNotification notification) {}

  @override
  Stream<EikeNotification> observeNotification() => const Stream.empty();
}

class _FailingAssetBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async =>
      throw FlutterError('Missing asset');
}

void main() {
  Future<void> pumpLicensesScreen(
    WidgetTester tester, {
    _FakeUrlLauncherRepository? urlRepository,
    Brightness brightness = Brightness.light,
    double textScale = 1,
    AssetBundle? bundle,
  }) {
    return tester.pumpWidget(
      BlocProvider(
        create: (_) => UrlLauncherBloc(
          urlRepository ?? _FakeUrlLauncherRepository(),
          _FakeNotificationRepository(),
        ),
        child: Builder(
          builder: (context) => MaterialApp(
            locale: const Locale('de'),
            supportedLocales: const [Locale('de')],
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            themeMode: brightness == Brightness.dark
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: EikeTheme.lightTheme(context),
            darkTheme: EikeTheme.darkTheme(context),
            builder: (context, child) {
              return DefaultAssetBundle(
                bundle: bundle ?? rootBundle,
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: TextScaler.linear(textScale),
                  ),
                  child: child!,
                ),
              );
            },
            home: const LicensesScreen(),
          ),
        ),
      ),
    );
  }

  Finder cardText(String section, String label) => find.descendant(
    of: find.widgetWithText(EikeTitledCard, section),
    matching: find.text(label),
  );

  Future<void> reveal(
    WidgetTester tester,
    String label, {
    String? section,
  }) async {
    final target = section == null
        ? find.text(label)
        : cardText(section, label);
    await tester.scrollUntilVisible(
      target,
      250,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(target);
    await tester.pumpAndSettle();
  }

  testWidgets(
    'shows concise license labels and the same rights holder in both cards',
    (
      tester,
    ) async {
      await pumpLicensesScreen(tester);

      expect(find.text('Quellcode'), findsOneWidget);
      expect(cardText('Quellcode', 'Lizenz: EUPL 1.2'), findsOneWidget);
      expect(
        cardText(
          'Quellcode',
          'Open-Source-Lizenz für die Europäische Union, Version 1.2',
        ),
        findsOneWidget,
      );
      const rightsHolder =
          'Rechteinhaber: Deutscher Fachverband für '
          'Psychosoziale Notfallversorgung (DF-PSNV) e. V.';
      expect(cardText('Quellcode', rightsHolder), findsOneWidget);
      await reveal(tester, 'Inhalte');
      expect(cardText('Inhalte', 'Lizenz: CC BY-NC-ND 4.0'), findsOneWidget);
      expect(
        cardText(
          'Inhalte',
          'Creative Commons Namensnennung – Nicht kommerziell – Keine Bearbeitungen '
              '4.0 International',
        ),
        findsOneWidget,
      );
      expect(cardText('Inhalte', rightsHolder), findsOneWidget);
      expect(find.text('eike-content © 2025 by DF-PSNV'), findsNothing);
      await reveal(tester, 'Open-Source-Bibliotheken');
      expect(
        find.text(
          'Diese App verwendet weitere Open-Source-Bibliotheken und Schriftarten.',
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets('uses identical buttons and retains both GitHub destinations', (
    tester,
  ) async {
    final repository = _FakeUrlLauncherRepository();
    await pumpLicensesScreen(tester, urlRepository: repository);
    const links = {
      'Quellcode': 'https://github.com/EikeApp/eike-frontend',
      'Inhalte': 'https://github.com/EikeApp/eike-content',
    };

    for (final link in links.entries) {
      await reveal(tester, 'Auf GitHub ansehen', section: link.key);
      expect(
        cardText(link.key, 'Vollständigen Lizenztext anzeigen'),
        findsOneWidget,
      );
      await tester.tap(cardText(link.key, 'Auf GitHub ansehen'));
      await tester.pumpAndSettle();
      expect(repository.launched.last, Uri.parse(link.value));
    }
    expect(repository.launched, links.values.map(Uri.parse).toList());
  });

  const documents = {
    'Quellcode': ('EUPL 1.2', 'assets/licenses/EUPL-1.2.de.html'),
    'Inhalte': ('CC BY-NC-ND 4.0', 'assets/licenses/CC-BY-NC-ND-4.0.de.html'),
  };
  for (final document in documents.entries) {
    testWidgets(
      'loads the complete local ${document.key} license and navigates back',
      (
        tester,
      ) async {
        final repository = _FakeUrlLauncherRepository();
        final (title, assetPath) = document.value;
        // Exercise the actual bundled asset, including its pubspec declaration.
        final bundled = await tester.runAsync(() => rootBundle.load(assetPath));
        final original = File(assetPath).readAsBytesSync();
        expect(
          bundled!.buffer.asUint8List(
            bundled.offsetInBytes,
            bundled.lengthInBytes,
          ),
          orderedEquals(original),
        );
        final license = await tester.runAsync(
          () => rootBundle.loadString(assetPath),
        );
        await pumpLicensesScreen(tester, urlRepository: repository);
        await reveal(
          tester,
          'Vollständigen Lizenztext anzeigen',
          section: document.key,
        );
        await tester.tap(
          cardText(document.key, 'Vollständigen Lizenztext anzeigen'),
        );
        await tester.runAsync(() async {
          await tester.pumpAndSettle();
        });
        await tester.pumpAndSettle();

        expect(find.byType(LicenseTextScreen), findsOneWidget);
        expect(find.text(title), findsOneWidget);
        expect(tester.widget<Html>(find.byType(Html)).data, license);
        expect(find.byType(SelectionArea), findsOneWidget);
        if (document.key == 'Quellcode') {
          expect(
            find.text(
              'OPEN-SOURCE-LIZENZ FÜR DIE EUROPÄISCHE UNION v. 1.2',
              findRichText: true,
            ),
            findsOneWidget,
          );
          expect(
            find.text(
              'EUPL © Europäische Union 2007, 2016',
              findRichText: true,
            ),
            findsOneWidget,
          );
          for (var section = 1; section <= 15; section++) {
            expect(
              find.textContaining(RegExp('^$section\\. '), findRichText: true),
              findsOneWidget,
            );
          }
          expect(find.text('Anlage', findRichText: true), findsOneWidget);
          expect(
            license,
            contains(
              'Alle sonstigen Änderungen oder Ergänzungen '
              'dieses Anhangs bedürfen der Ausarbeitung einer neuen Version der EUPL.',
            ),
          );
          expect(license, isNot(contains('<nav')));
          expect(license, isNot(contains('<script')));
          expect(license, isNot(contains('This website is not sponsored')));
        } else {
          expect(find.text('eike-content © 2025 by DF-PSNV'), findsOneWidget);
          for (var section = 1; section <= 8; section++) {
            expect(
              find.textContaining('Abschnitt $section –', findRichText: true),
              findsWidgets,
            );
          }
          expect(license, contains('id="legal-code-body"'));
          expect(license, contains('Abschnitt 5 – Gewährleistungsausschluss'));
          expect(license, contains('id="s8d"'));
        }
        expect(repository.launched, isEmpty);

        final scrollable = tester.state<ScrollableState>(
          find
              .descendant(
                of: find.byType(SingleChildScrollView),
                matching: find.byType(Scrollable),
              )
              .first,
        );
        expect(scrollable.position.maxScrollExtent, greaterThan(0));
        scrollable.position.jumpTo(scrollable.position.maxScrollExtent);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);

        await tester.tap(find.byType(BackButton));
        await tester.pumpAndSettle();
        expect(find.byType(LicenseTextScreen), findsNothing);
        expect(find.byType(LicensesScreen), findsOneWidget);
      },
    );
  }

  testWidgets(
    'opens Flutter licenses with registered Roboto and navigates back',
    (
      tester,
    ) async {
      // Register the same local font license as main.dart, without booting the DB.
      final roboto = await tester.runAsync(
        () => rootBundle.loadString('assets/fonts/Roboto/OFL.txt'),
      );
      LicenseRegistry.addLicense(() async* {
        yield LicenseEntryWithLineBreaks(['Roboto'], roboto!);
      });
      addTearDown(LicenseRegistry.reset);
      await pumpLicensesScreen(tester);
      await reveal(tester, 'Drittanbieter-Lizenzen anzeigen');
      await tester.tap(find.text('Drittanbieter-Lizenzen anzeigen'));
      await tester.pumpAndSettle();

      expect(find.byType(LicensePage), findsOneWidget);
      await tester.tap(find.text('Roboto'));
      await tester.pumpAndSettle();
      expect(find.textContaining('SIL OPEN FONT LICENSE'), findsWidgets);

      await tester.tap(find.byType(BackButton).last);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.byType(LicensePage), findsNothing);
      expect(find.byType(LicensesScreen), findsOneWidget);
    },
  );

  testWidgets('shows a readable error if the local license cannot be loaded', (
    tester,
  ) async {
    await pumpLicensesScreen(tester, bundle: _FailingAssetBundle());
    await reveal(
      tester,
      'Vollständigen Lizenztext anzeigen',
      section: 'Quellcode',
    );
    await tester.tap(
      cardText('Quellcode', 'Vollständigen Lizenztext anzeigen'),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Der Lizenztext konnte nicht geladen werden.'),
      findsOneWidget,
    );
    expect(find.byType(CircularProgressIndicator), findsNothing);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.byType(LicensesScreen), findsOneWidget);
  });

  for (final brightness in Brightness.values) {
    testWidgets('supports large text and accessible buttons in $brightness', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final semantics = tester.ensureSemantics();
      try {
        await pumpLicensesScreen(tester, brightness: brightness, textScale: 3);

        for (final section in documents.keys) {
          for (final label in [
            'Auf GitHub ansehen',
            'Vollständigen Lizenztext anzeigen',
          ]) {
            await reveal(tester, label, section: section);
            expect(tester.takeException(), isNull);
            final button = find.ancestor(
              of: cardText(section, label),
              matching: find.byType(TextButton),
            );
            expect(tester.getSize(button).height, greaterThanOrEqualTo(48));
            await expectLater(
              tester,
              meetsGuideline(labeledTapTargetGuideline),
            );
          }
          await tester.tap(
            cardText(section, 'Vollständigen Lizenztext anzeigen'),
          );
          await tester.runAsync(() async {
            await tester.pumpAndSettle();
          });
          await tester.pumpAndSettle();
          expect(find.byType(Html), findsOneWidget);
          expect(tester.takeException(), isNull);
          await tester.tap(find.byType(BackButton));
          await tester.pumpAndSettle();
        }
      } finally {
        semantics.dispose();
      }
    });
  }
}
