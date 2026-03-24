abstract interface class EikeSettingsRepository {
  Future<void> setAppLockEnabled(bool isEnabled);
  Stream<bool> observeIsAppLockEnabled();

  Future<void> resetAllSettings();
}
