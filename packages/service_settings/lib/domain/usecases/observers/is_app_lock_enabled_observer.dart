import 'package:service_settings/domain/repositories/eike_settings_repository.dart';

class IsAppLockEnabledObserver {
  final EikeSettingsRepository repository;
  const IsAppLockEnabledObserver(this.repository);

  Stream<bool> observe() {
    return repository.observeIsAppLockEnabled();
  }
}
