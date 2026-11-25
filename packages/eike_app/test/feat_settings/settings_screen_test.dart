import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/data_entities/tables/team_contacts_table.dart';
import 'package:eike_app/feat_notification/domain/models/eike_notification.dart';
import 'package:eike_app/feat_notification/domain/repositories/notification_repository.dart';
import 'package:eike_app/feat_settings/presentation/settings_screen.dart';
import 'package:eike_app/service_app_info/domain/models/app_info.dart';
import 'package:eike_app/service_app_info/domain/repositories/app_info_repository.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeNotificationRepository implements NotificationRepository {
  final emittedNotifications = <EikeNotification>[];

  @override
  Future<void> closeStream() async {}

  @override
  void emitNotification(EikeNotification notification) {
    emittedNotifications.add(notification);
  }

  @override
  Stream<EikeNotification> observeNotification() => const Stream.empty();
}

class const _FakeAppInfoRepository() implements AppInfoRepository {
  @override
  Future<AppInfo> getAppInfo() async {
    return const AppInfo(version: '1.2.3', buildNumber: '42');
  }
}

void main() {
  group(SettingsScreen, () {
    late EikeDatabase database;

    setUp(() {
      database = EikeDatabase(NativeDatabase.memory());
    });

    tearDown(() => database.close());

    Future<void> pumpSettingsScreen(WidgetTester tester) {
      return tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<EikeDatabase>.value(value: database),
            RepositoryProvider<NotificationRepository>(
              create: (_) => _FakeNotificationRepository(),
            ),
            RepositoryProvider<AppInfoRepository>(
              create: (_) => const _FakeAppInfoRepository(),
            ),
          ],
          child: const MaterialApp(home: SettingsScreen()),
        ),
      );
    }

    // See contact_screen_test.dart: drift's watch query schedules a
    // cleanup Timer when the bloc closes, which needs a pump to complete
    // before the test framework's teardown checks for pending timers.
    Future<void> disposeSettingsScreen(WidgetTester tester) async {
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    }

    testWidgets(
      'should not delete data when the confirmation dialog is cancelled',
      (tester) async {
        await database
            .into(database.teamContactTable)
            .insert(
              TeamContactTableCompanion.insert(
                teamName: const TeamContactTeamName('Blauer Engel'),
                phone: const TeamContactPhone(''),
                email: const TeamContactEmail(''),
              ),
            );

        await pumpSettingsScreen(tester);
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.delete_rounded));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Abbrechen'));
        await tester.pumpAndSettle();

        final remaining = await database.teamContactTable.select().get();
        expect(remaining, hasLength(1));

        await disposeSettingsScreen(tester);
      },
    );

    testWidgets(
      'should delete all local data once the confirmation dialog is confirmed',
      (tester) async {
        await database
            .into(database.teamContactTable)
            .insert(
              TeamContactTableCompanion.insert(
                teamName: const TeamContactTeamName('Blauer Engel'),
                phone: const TeamContactPhone(''),
                email: const TeamContactEmail(''),
              ),
            );

        await pumpSettingsScreen(tester);
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.delete_rounded));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Löschen'));
        await tester.pumpAndSettle();

        final remaining = await database.teamContactTable.select().get();
        expect(remaining, isEmpty);

        await disposeSettingsScreen(tester);
      },
    );

    testWidgets(
      'should show the app version and copy it to the clipboard on tap',
      (tester) async {
        final copiedData = <ClipboardData>[];
        tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          (methodCall) async {
            if (methodCall.method == 'Clipboard.setData') {
              copiedData.add(
                ClipboardData(text: methodCall.arguments['text']),
              );
            }
            return null;
          },
        );
        addTearDown(() {
          tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
            SystemChannels.platform,
            null,
          );
        });

        await pumpSettingsScreen(tester);
        await tester.pumpAndSettle();

        // The version footer sits below the legal section, off-screen at
        // the default test surface size.
        await tester.scrollUntilVisible(
          find.text('Version 1.2.3 (42)'),
          500.0,
          scrollable: find.byType(Scrollable),
        );

        expect(find.text('Version 1.2.3 (42)'), findsOneWidget);

        await tester.tap(find.text('Version 1.2.3 (42)'));
        await tester.pumpAndSettle();

        expect(copiedData.single.text, '1.2.3 (42)');
        expect(find.text('Version kopiert'), findsOneWidget);

        await disposeSettingsScreen(tester);
      },
    );
  });
}
