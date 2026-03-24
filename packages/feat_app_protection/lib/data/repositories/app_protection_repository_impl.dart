import 'package:service_settings/domain/repositories/eike_settings_repository.dart';
import 'package:service_auth/domain/repositories/local_auth_repository.dart';

import '../../domain/repositories/app_protection_repository.dart';

class AppProtectionRepositoryImpl implements AppProtectionRepository {
  static const appProtectionStorageKey = 'app_protection_key';

  const AppProtectionRepositoryImpl(
    this.settingsRepository,
    this.authentication,
  );

  final EikeSettingsRepository settingsRepository;
  final LocalAuthRepository authentication;

  @override
  Future<bool> authenticate() async {
    final authenticationRequired = await settingsRepository
        .observeIsAppLockEnabled()
        .first;

    if (!authenticationRequired) {
      return true;
    }

    return authentication.authenticate();
  }
}
