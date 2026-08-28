import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:eike_app/service_settings/data/repositories/eike_settings_repository_impl.dart';
import 'package:eike_app/service_settings/domain/repositories/eike_settings_repository.dart';
import 'package:test/test.dart';

void main() {
  group(EikeSettingsRepositoryImpl, () {
    late RxSharedPreferences preferences;
    late EikeSettingsRepository repository;

    setUp(() {
      // Make SharedPreferences act as a testing surface
      SharedPreferences.setMockInitialValues({});

      preferences = RxSharedPreferences.getInstance();
      repository = EikeSettingsRepositoryImpl(preferences);
    });

    test('app lock should not be on by default', () async {
      final isAppLockEnabled = await repository.observeIsAppLockEnabled().first;
      expect(isAppLockEnabled, isFalse);
    });

    test('app lock should be togglable', () async {
      // Pump it to true
      await repository.setAppLockEnabled(true);
      var isAppLockEnabled = await repository.observeIsAppLockEnabled().first;
      expect(isAppLockEnabled, isTrue);

      // Reset it back
      await repository.setAppLockEnabled(false);
      isAppLockEnabled = await repository.observeIsAppLockEnabled().first;
      expect(isAppLockEnabled, isFalse);
    });

    test('resetting storage should clear out the preferences', () async {
      await repository.setAppLockEnabled(true);
      var isAppLockEnabled = await repository.observeIsAppLockEnabled().first;
      expect(isAppLockEnabled, isTrue);

      await repository.resetAllSettings();
      final keyStillExists = await preferences.containsKey(
        EikeSettingsRepositoryImpl.appLockEnabledKey,
      );
      expect(keyStillExists, isFalse);

      isAppLockEnabled = await repository.observeIsAppLockEnabled().first;
      expect(isAppLockEnabled, isFalse);
    });
  });
}
