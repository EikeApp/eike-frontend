import 'package:bloc_test/bloc_test.dart';
import 'package:eike_app/feat_notification/domain/models/eike_notification.dart';
import 'package:eike_app/feat_notification/domain/repositories/notification_repository.dart';
import 'package:eike_app/feat_settings/domain/repositories/settings_repository.dart';
import 'package:eike_app/feat_settings/presentation/bloc/settings_bloc.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:eike_app/service_settings/data/repositories/eike_settings_repository_impl.dart';
import 'package:eike_app/service_settings/domain/repositories/eike_settings_repository.dart';
import 'package:test/test.dart';

class _FakeSettingsRepository implements SettingsRepository {
  var cleanupCallCount = 0;

  @override
  Future<void> cleanupLocalStorage() async {
    cleanupCallCount++;
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
  group(SettingsBloc, () {
    late _FakeSettingsRepository settingsRepository;
    late EikeSettingsRepository eikeSettingsRepository;
    late _FakeNotificationRepository notificationRepo;

    setUp(() {
      SharedPreferences.setMockInitialValues({});

      settingsRepository = _FakeSettingsRepository();
      eikeSettingsRepository = EikeSettingsRepositoryImpl(
        RxSharedPreferences.getInstance(),
      );
      notificationRepo = _FakeNotificationRepository();
    });

    SettingsBloc buildBloc() =>
        SettingsBloc(settingsRepository, eikeSettingsRepository, notificationRepo);

    blocTest<SettingsBloc, SettingsState>(
      'should reflect the persisted app lock setting on setup',
      setUp: () => eikeSettingsRepository.setAppLockEnabled(true),
      build: buildBloc,
      act: (bloc) => bloc.add(const SettingsEvent.onSetup()),
      expect: () => [const SettingsState(isAppLockEnabled: true)],
    );

    // Toggling doesn't emit a new SettingsState directly — the switch
    // only reflects the change reactively, through the subscription
    // `onSetup` establishes (already covered end-to-end by the "should
    // toggle app lock through the switch" widget test). At the bloc
    // level, what matters in isolation is that the write actually reaches
    // the repository.
    blocTest<SettingsBloc, SettingsState>(
      'should persist the app lock setting when toggled',
      build: buildBloc,
      act: (bloc) =>
          bloc.add(const SettingsEvent.onSetIsAppLockEnabled(true)),
      expect: () => [],
      verify: (_) async {
        expect(
          await eikeSettingsRepository.observeIsAppLockEnabled().first,
          isTrue,
        );
      },
    );

    blocTest<SettingsBloc, SettingsState>(
      'should delegate to the repository on cleanupLocalStorage',
      build: buildBloc,
      act: (bloc) => bloc.add(const SettingsEvent.onCleanupLocalStorage()),
      expect: () => [],
      verify: (_) => expect(settingsRepository.cleanupCallCount, 1),
    );
  });
}
