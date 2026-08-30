import 'package:bloc_test/bloc_test.dart';
import 'package:eike_app/feat_app_protection/domain/repositories/app_protection_repository.dart';
import 'package:eike_app/feat_app_protection/presentation/bloc/app_protection_bloc.dart';
import 'package:eike_app/feat_notification/domain/models/eike_notification.dart';
import 'package:eike_app/feat_notification/domain/repositories/notification_repository.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:eike_app/service_settings/data/repositories/eike_settings_repository_impl.dart';
import 'package:eike_app/service_settings/domain/repositories/eike_settings_repository.dart';
import 'package:test/test.dart';

class _FakeAppProtectionRepository implements AppProtectionRepository {
  var authenticationResult = true;
  var callCount = 0;

  @override
  Future<bool> authenticate() async {
    callCount++;
    return authenticationResult;
  }
}

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
  group(AppProtectionBloc, () {
    late _FakeAppProtectionRepository authRepo;
    late EikeSettingsRepository settingsRepo;
    late _FakeNotificationRepository notificationRepo;

    setUp(() {
      SharedPreferences.setMockInitialValues({});

      authRepo = _FakeAppProtectionRepository();
      settingsRepo = EikeSettingsRepositoryImpl(
        RxSharedPreferences.getInstance(),
      );
      notificationRepo = _FakeNotificationRepository();
    });

    const lockedIdle = AppProtectionState.locked(
      isAuthenticating: false,
      errorText: null,
    );
    const lockedBusy = AppProtectionState.locked(
      isAuthenticating: true,
      errorText: null,
    );

    AppProtectionBloc buildBloc() =>
        AppProtectionBloc(authRepo, settingsRepo, notificationRepo);

    blocTest<AppProtectionBloc, AppProtectionState>(
      'should unlock without authenticating when app lock is disabled',
      setUp: () => settingsRepo.setAppLockEnabled(false),
      build: buildBloc,
      act: (bloc) => bloc.add(const AppProtectionEvent.onSetup()),
      expect: () => [const AppProtectionState.unlocked()],
      verify: (_) => expect(authRepo.callCount, 0),
    );

    blocTest<AppProtectionBloc, AppProtectionState>(
      'should unlock after a successful authentication when app lock is enabled',
      setUp: () async {
        await settingsRepo.setAppLockEnabled(true);
        authRepo.authenticationResult = true;
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const AppProtectionEvent.onSetup()),
      expect: () => [
        lockedIdle,
        lockedBusy,
        lockedIdle,
        const AppProtectionState.unlocked(),
      ],
      verify: (_) => expect(authRepo.callCount, 1),
    );

    blocTest<AppProtectionBloc, AppProtectionState>(
      'should surface a failed authentication as a locked error state',
      setUp: () async {
        await settingsRepo.setAppLockEnabled(true);
        authRepo.authenticationResult = false;
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const AppProtectionEvent.onSetup()),
      expect: () => [
        lockedIdle,
        lockedBusy,
        lockedIdle,
        const AppProtectionState.locked(
          isAuthenticating: false,
          errorText: 'Authentifizierung ist fehlgeschlagen',
        ),
      ],
    );

    blocTest<AppProtectionBloc, AppProtectionState>(
      'should lock again once the app is paused while app lock is enabled',
      setUp: () async {
        await settingsRepo.setAppLockEnabled(true);
        authRepo.authenticationResult = true;
      },
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const AppProtectionEvent.onSetup());
        await bloc.stream.firstWhere(
          (state) => state == const AppProtectionState.unlocked(),
        );
        bloc.add(const AppProtectionEvent.onAppPaused());
      },
      expect: () => [
        lockedIdle,
        lockedBusy,
        lockedIdle,
        const AppProtectionState.unlocked(),
        lockedIdle,
      ],
    );

    blocTest<AppProtectionBloc, AppProtectionState>(
      'should stay unlocked once the app is paused while app lock is disabled',
      setUp: () => settingsRepo.setAppLockEnabled(false),
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const AppProtectionEvent.onSetup());
        await bloc.stream.firstWhere(
          (state) => state == const AppProtectionState.unlocked(),
        );
        bloc.add(const AppProtectionEvent.onAppPaused());
        await Future<void>.delayed(Duration.zero);
      },
      expect: () => [const AppProtectionState.unlocked()],
    );
  });
}
