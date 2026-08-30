import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/data_entities/tables/team_contacts_table.dart';
import 'package:eike_app/feat_notification/domain/models/eike_notification.dart';
import 'package:eike_app/feat_notification/domain/repositories/notification_repository.dart';
import 'package:eike_app/feat_settings/presentation/settings_screen.dart';
import 'package:eike_app/service_settings/domain/repositories/eike_settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';

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

// Real EikeSettingsRepositoryImpl is backed by RxSharedPreferences, a
// global singleton whose internal housekeeping timers don't play well with
// flutter_test's strict "no pending timers" invariant. A small in-memory
// fake sidesteps that entirely and is all the UI logic under test needs.
class _FakeEikeSettingsRepository implements EikeSettingsRepository {
  final _isAppLockEnabled = BehaviorSubject.seeded(false);

  // Reads the current value directly instead of subscribing via the
  // stream — SettingsBloc already holds the one long-lived subscription
  // this fake needs; adding a second one (e.g. via `.first`) just to read
  // the current value in a test triggered a hang on widget disposal.
  bool get isAppLockEnabled => _isAppLockEnabled.value;

  @override
  Future<void> setAppLockEnabled(bool isEnabled) async {
    _isAppLockEnabled.add(isEnabled);
  }

  @override
  Stream<bool> observeIsAppLockEnabled() => _isAppLockEnabled.stream;

  @override
  Future<void> resetAllSettings() async {
    _isAppLockEnabled.add(false);
  }
}

void main() {
  group(SettingsScreen, () {
    late EikeDatabase database;
    late _FakeEikeSettingsRepository eikeSettingsRepository;

    setUp(() {
      database = EikeDatabase(NativeDatabase.memory());
      eikeSettingsRepository = _FakeEikeSettingsRepository();
    });

    tearDown(() => database.close());

    Future<void> pumpSettingsScreen(WidgetTester tester) {
      return tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<EikeDatabase>.value(value: database),
            RepositoryProvider<EikeSettingsRepository>.value(
              value: eikeSettingsRepository,
            ),
            RepositoryProvider<NotificationRepository>(
              create: (_) => _FakeNotificationRepository(),
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
                teamName: TeamContactTeamName('Blauer Engel'),
                phone: TeamContactPhone(''),
                email: TeamContactEmail(''),
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
                teamName: TeamContactTeamName('Blauer Engel'),
                phone: TeamContactPhone(''),
                email: TeamContactEmail(''),
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

    testWidgets('should toggle app lock through the switch', (tester) async {
      await pumpSettingsScreen(tester);
      await tester.pumpAndSettle();

      expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);
      expect(eikeSettingsRepository.isAppLockEnabled, isTrue);

      await disposeSettingsScreen(tester);
    });
  });
}
