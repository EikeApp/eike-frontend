import 'package:drift/native.dart';
import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/feat_contact/presentation/contact_screen.dart';
import 'package:eike_app/feat_notification/domain/models/eike_notification.dart';
import 'package:eike_app/feat_notification/domain/repositories/notification_repository.dart';
import 'package:flutter/material.dart';
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

void main() {
  group(ContactScreen, () {
    late EikeDatabase database;

    setUp(() {
      database = EikeDatabase(NativeDatabase.memory());
    });

    tearDown(() => database.close());

    Future<void> pumpContactScreen(WidgetTester tester) {
      return tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<EikeDatabase>.value(value: database),
            RepositoryProvider<NotificationRepository>(
              create: (_) => _FakeNotificationRepository(),
            ),
          ],
          child: const MaterialApp(home: ContactScreen()),
        ),
      );
    }

    // Closing ContactBloc disposes drift's underlying watch query, which
    // schedules a zero-duration Timer for its own cleanup. If we let the
    // test framework tear the widget tree down automatically after the test
    // body returns, nothing is left to pump that timer to completion and
    // the test fails with "A Timer is still pending". Disposing explicitly
    // here — while we can still pump — avoids that.
    Future<void> disposeContactScreen(WidgetTester tester) async {
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    }

    testWidgets(
      'should show placeholder text when no team contact is set',
      (tester) async {
        await pumpContactScreen(tester);
        await tester.pumpAndSettle();

        expect(find.text('Team'), findsOneWidget);
        expect(find.text('Keine Telefonnummer hinterlegt'), findsOneWidget);
        expect(find.text('Keine Email hinterlegt'), findsOneWidget);

        await disposeContactScreen(tester);
      },
    );

    testWidgets(
      'should save team contact data entered in the edit dialog',
      (tester) async {
        await pumpContactScreen(tester);
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.edit));
        await tester.pumpAndSettle();

        final fields = find.byType(TextField);
        await tester.enterText(fields.at(0), 'Blauer Engel');
        await tester.enterText(fields.at(1), '0170123456');
        await tester.enterText(fields.at(2), 'team@example.com');

        await tester.tap(find.text('speichern'));
        await tester.pumpAndSettle();

        expect(find.text('Blauer Engel'), findsOneWidget);
        expect(find.text('0170123456'), findsOneWidget);
        expect(find.text('team@example.com'), findsOneWidget);

        await disposeContactScreen(tester);
      },
    );
  });
}
