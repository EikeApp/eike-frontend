import 'package:bloc_test/bloc_test.dart';
import 'package:eike_app/feat_notification/domain/models/eike_notification.dart';
import 'package:eike_app/feat_notification/domain/repositories/notification_repository.dart';
import 'package:eike_app/feat_settings/domain/repositories/settings_repository.dart';
import 'package:eike_app/feat_settings/presentation/bloc/settings_bloc.dart';
import 'package:eike_app/service_app_info/domain/models/app_info.dart';
import 'package:eike_app/service_app_info/domain/repositories/app_info_repository.dart';
import 'package:test/test.dart';

class _FakeSettingsRepository implements SettingsRepository {
  var cleanupCallCount = 0;

  @override
  Future<void> cleanupLocalStorage() async {
    cleanupCallCount++;
  }
}

class _FakeAppInfoRepository implements AppInfoRepository {
  static const appInfo = AppInfo(version: '1.0.0', buildNumber: '1');

  @override
  Future<AppInfo> getAppInfo() async => appInfo;
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
    late _FakeNotificationRepository notificationRepo;

    setUp(() {
      settingsRepository = _FakeSettingsRepository();
      notificationRepo = _FakeNotificationRepository();
    });

    SettingsBloc buildBloc() => SettingsBloc(
      settingsRepository,
      notificationRepo,
      _FakeAppInfoRepository(),
    );

    blocTest<SettingsBloc, SettingsState>(
      'should load the app info on setup',
      build: buildBloc,
      act: (bloc) => bloc.add(const SettingsEvent.onSetup()),
      expect: () => [
        const SettingsState(appInfo: _FakeAppInfoRepository.appInfo),
      ],
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
