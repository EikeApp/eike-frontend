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
    late AppProtectionBloc bloc;

    setUp(() {
      SharedPreferences.setMockInitialValues({});

      authRepo = _FakeAppProtectionRepository();
      settingsRepo = EikeSettingsRepositoryImpl(
        RxSharedPreferences.getInstance(),
      );
      notificationRepo = _FakeNotificationRepository();
      bloc = AppProtectionBloc(authRepo, settingsRepo, notificationRepo);
    });

    tearDown(() {
      return bloc.close();
    });

    test(
      'should unlock without authenticating when app lock is disabled',
      () async {
        await settingsRepo.setAppLockEnabled(false);

        bloc.add(const AppProtectionEvent.onSetup());
        await bloc.stream.firstWhere(
          (state) => state == const AppProtectionState.unlocked(),
        );

        expect(authRepo.callCount, 0);
      },
    );

    test(
      'should unlock after a successful authentication when app lock is enabled',
      () async {
        await settingsRepo.setAppLockEnabled(true);
        authRepo.authenticationResult = true;

        bloc.add(const AppProtectionEvent.onSetup());
        await bloc.stream.firstWhere(
          (state) => state == const AppProtectionState.unlocked(),
        );

        expect(authRepo.callCount, 1);
      },
    );

    test(
      'should surface a failed authentication as a locked error state',
      () async {
        await settingsRepo.setAppLockEnabled(true);
        authRepo.authenticationResult = false;

        bloc.add(const AppProtectionEvent.onSetup());
        final lockedState = await bloc.stream.firstWhere(
          (state) =>
              state.mapOrNull(locked: (locked) => locked.errorText != null) ??
              false,
        );

        expect(
          lockedState,
          const AppProtectionState.locked(
            isAuthenticating: false,
            errorText: 'Authentifizierung ist fehlgeschlagen',
          ),
        );
      },
    );

    test(
      'should lock again once the app is paused while app lock is enabled',
      () async {
        await settingsRepo.setAppLockEnabled(true);
        authRepo.authenticationResult = true;
        bloc.add(const AppProtectionEvent.onSetup());
        await bloc.stream.firstWhere(
          (state) => state == const AppProtectionState.unlocked(),
        );

        bloc.add(const AppProtectionEvent.onAppPaused());
        final lockedState = await bloc.stream.firstWhere(
          (state) => state != const AppProtectionState.unlocked(),
        );

        expect(
          lockedState,
          const AppProtectionState.locked(
            isAuthenticating: false,
            errorText: null,
          ),
        );
      },
    );

    test(
      'should stay unlocked once the app is paused while app lock is disabled',
      () async {
        await settingsRepo.setAppLockEnabled(false);
        bloc.add(const AppProtectionEvent.onSetup());
        await bloc.stream.firstWhere(
          (state) => state == const AppProtectionState.unlocked(),
        );

        bloc.add(const AppProtectionEvent.onAppPaused());
        await Future<void>.delayed(Duration.zero);

        expect(bloc.state, const AppProtectionState.unlocked());
      },
    );
  });
}
