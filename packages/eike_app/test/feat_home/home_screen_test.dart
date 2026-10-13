import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/feat_tip_detail/presentation/tip_detail_screen.dart';
import 'package:eike_app/feat_navigation/app_router.dart';
import 'package:eike_app/feat_notification/domain/models/eike_notification.dart';
import 'package:eike_app/feat_notification/domain/repositories/notification_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeNotificationRepository implements NotificationRepository {
  @override
  Future<void> closeStream() async {}

  @override
  void emitNotification(EikeNotification notification) {}

  @override
  Stream<EikeNotification> observeNotification() => const Stream.empty();
}

void main() {
  group('HomeScreen', () {
    const firstTipTitle = 'Bewege Dich mehr als sonst!';
    const firstTipQuestion = 'Wie wirst Du Dich mehr bewegen?';

    late EikeDatabase database;

    setUp(() {
      database = EikeDatabase(NativeDatabase.memory());
      eikeRouter.go('/home');
      // The bundle caches futures bound to the zone of the previous test,
      // which would never complete in this one.
      rootBundle.clear();
    });

    tearDown(() => database.close());

    // The tips are read from the asset bundle and the database, which both
    // need real async work to complete.
    Future<void> settle(WidgetTester tester) async {
      for (var i = 0; i < 20; ++i) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 50)),
        );
        await tester.pump();
      }
      await tester.pumpAndSettle();
    }

    Future<void> pumpApp(WidgetTester tester) async {
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<EikeDatabase>.value(value: database),
            RepositoryProvider<NotificationRepository>(
              create: (_) => _FakeNotificationRepository(),
            ),
          ],
          child: MaterialApp.router(routerConfig: eikeRouter),
        ),
      );

      await settle(tester);
    }

    // See contact_screen_test.dart: drift's watch query cleanup needs to be
    // pumped while the test is still running.
    Future<void> disposeApp(WidgetTester tester) async {
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    }

    testWidgets('should list the tips without their questions', (tester) async {
      await pumpApp(tester);

      expect(find.text('Meine 7 Sachen'), findsOneWidget);
      expect(find.text(firstTipTitle), findsOneWidget);
      expect(find.text(firstTipQuestion), findsNothing);
      expect(find.byType(TextFormField), findsNothing);

      await disposeApp(tester);
    });

    testWidgets('should open a tip and store the user note', (
      tester,
    ) async {
      await pumpApp(tester);

      await tester.tap(find.text(firstTipTitle));
      await tester.pumpAndSettle();

      expect(find.byType(TipDetailScreen), findsOneWidget);
      expect(find.text('Tipp 1'), findsOneWidget);
      expect(find.text(firstTipQuestion), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), 'Joggen');
      await settle(tester);

      final tips = await tester.runAsync(
        () => database.tipTable.select().get(),
      );
      expect(tips!.firstWhere((tip) => tip.id == 0).userNote, equals('Joggen'));

      await tester.tap(find.byType(CloseButton));
      await tester.pumpAndSettle();

      expect(find.byType(TipDetailScreen), findsNothing);
      expect(find.text(firstTipTitle), findsOneWidget);

      await disposeApp(tester);
    });
  });
}
