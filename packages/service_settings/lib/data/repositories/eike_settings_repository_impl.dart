import 'package:meta/meta.dart' show visibleForTesting;
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:service_settings/domain/repositories/eike_settings_repository.dart';

class EikeSettingsRepositoryImpl implements EikeSettingsRepository {
  @visibleForTesting
  static const appLockEnabledKey = 'app_lock_enabled';

  const EikeSettingsRepositoryImpl(this.storage);

  final RxSharedPreferences storage;

  @override
  Stream<bool> observeIsAppLockEnabled() {
    return storage
        .getBoolStream(appLockEnabledKey)
        .map((value) => value ?? false);
  }

  @override
  Future<void> setAppLockEnabled(bool isEnabled) {
    return storage.setBool(appLockEnabledKey, isEnabled);
  }

  @override
  Future<void> resetAllSettings() async {
    await storage.remove(appLockEnabledKey);
  }
}
