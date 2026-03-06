import 'package:local_auth/local_auth.dart';
import 'package:service_settings/domain/repositories/eike_settings_repository.dart';

import '../../domain/repositories/app_protection_repository.dart';

class AppProtectionRepositoryImpl implements AppProtectionRepository {
  static const appProtectionStorageKey = 'app_protection_key';

  const AppProtectionRepositoryImpl(
    this.settingsRepository,
    this.authentication,
  );

  final EikeSettingsRepository settingsRepository;
  final LocalAuthentication authentication;

  @override
  Future<bool> authenticate() async {
    final authenticationRequired = await settingsRepository
        .observeIsAppLockEnabled()
        .first;

    if (!authenticationRequired) {
      return true;
    }

    return authentication.authenticate(
      localizedReason: 'Verifizieren Sie ihre Identität',
      persistAcrossBackgrounding: true,
    );
  }
}
