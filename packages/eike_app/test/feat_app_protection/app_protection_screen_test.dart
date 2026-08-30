import 'dart:async';

import 'package:eike_app/feat_app_protection/presentation/app_protection_screen.dart';
import 'package:eike_app/feat_notification/domain/models/eike_notification.dart';
import 'package:eike_app/feat_notification/domain/repositories/notification_repository.dart';
import 'package:eike_app/service_auth/domain/repositories/local_auth_repository.dart';
import 'package:eike_app/service_settings/domain/repositories/eike_settings_repository.dart';
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

class _FakeEikeSettingsRepository implements EikeSettingsRepository {
  _FakeEikeSettingsRepository({bool initialAppLockEnabled = false})
    : _isAppLockEnabled = initialAppLockEnabled;

  bool _isAppLockEnabled;
  final _updates = StreamController<bool>.broadcast();

  @override
  Future<void> setAppLockEnabled(bool isEnabled) async {
    _isAppLockEnabled = isEnabled;
    _updates.add(isEnabled);
  }

  // Emits the current value first, then any later updates — like a real
  // BehaviorSubject/prefs stream, but as a plain Dart stream. AppProtection
  // reads this via `.first`, which (unlike a rxdart BehaviorSubject) reliably
  // resolves under flutter_test's FakeAsync-based test binding.
  @override
  Stream<bool> observeIsAppLockEnabled() async* {
    yield _isAppLockEnabled;
    yield* _updates.stream;
  }

  @override
  Future<void> resetAllSettings() async {
    _isAppLockEnabled = false;
    _updates.add(false);
  }
}

class _FakeLocalAuthRepository implements LocalAuthRepository {
  var authenticationResult = true;
  var callCount = 0;

  @override
  Future<bool> authenticate() async {
    callCount++;
    return authenticationResult;
  }
}

void main() {
  group(AppProtectionScreen, () {
    late _FakeEikeSettingsRepository eikeSettingsRepository;
    late _FakeLocalAuthRepository localAuthRepository;

    Future<void> pumpAppProtectionScreen(
      WidgetTester tester, {
      required bool isAppLockEnabled,
      bool initialAuthenticationResult = true,
    }) {
      eikeSettingsRepository = _FakeEikeSettingsRepository(
        initialAppLockEnabled: isAppLockEnabled,
      );
      localAuthRepository = _FakeLocalAuthRepository()
        ..authenticationResult = initialAuthenticationResult;

      return tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<EikeSettingsRepository>.value(
              value: eikeSettingsRepository,
            ),
            RepositoryProvider<LocalAuthRepository>.value(
              value: localAuthRepository,
            ),
            RepositoryProvider<NotificationRepository>(
              create: (_) => _FakeNotificationRepository(),
            ),
          ],
          child: MaterialApp(
            home: AppProtectionScreen(
              builder: (context) => const Text('Home Content'),
            ),
          ),
        ),
      );
    }

    Future<void> disposeAppProtectionScreen(WidgetTester tester) async {
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    }

    // The lock screen stays mounted (offscreen + non-interactive) even once
    // unlocked — it's what AnimatedSwitcher slides/fades away, see
    // app_protection_screen.dart. So "is the app actually locked" isn't
    // whether its text is findable (it always is), but whether the
    // IgnorePointer wrapping it still blocks taps.
    bool isLockScreenBlockingInput(WidgetTester tester) {
      // The closest IgnorePointer ancestor is ours; Flutter's own
      // Overlay/ModalRoute machinery adds further ones higher up the tree.
      final ignorePointer = tester.firstWidget<IgnorePointer>(
        find.ancestor(
          of: find.text('Entsperren'),
          matching: find.byType(IgnorePointer),
        ),
      );
      return !ignorePointer.ignoring;
    }

    testWidgets(
      'should show the content directly when app lock is disabled',
      (tester) async {
        await pumpAppProtectionScreen(tester, isAppLockEnabled: false);
        await tester.pumpAndSettle();

        expect(find.text('Home Content'), findsOneWidget);
        expect(isLockScreenBlockingInput(tester), isFalse);
        expect(localAuthRepository.callCount, 0);

        await disposeAppProtectionScreen(tester);
      },
    );

    testWidgets(
      'should block access behind a lock screen until authentication succeeds',
      (tester) async {
        await pumpAppProtectionScreen(
          tester,
          isAppLockEnabled: true,
          initialAuthenticationResult: false,
        );
        await tester.pumpAndSettle();

        // The failed auto-authentication attempt on setup leaves the app
        // locked with a visible error, the "Entsperren" button available
        // to retry.
        expect(isLockScreenBlockingInput(tester), isTrue);
        expect(
          find.text('Authentifizierung ist fehlgeschlagen'),
          findsOneWidget,
        );
        expect(localAuthRepository.callCount, 1);

        localAuthRepository.authenticationResult = true;
        await tester.tap(find.text('Entsperren'));
        await tester.pumpAndSettle();

        expect(localAuthRepository.callCount, 2);
        expect(isLockScreenBlockingInput(tester), isFalse);
        expect(
          find.text('Authentifizierung ist fehlgeschlagen'),
          findsNothing,
        );
        expect(find.text('Home Content'), findsOneWidget);

        await disposeAppProtectionScreen(tester);
      },
    );
  });
}
