import 'package:local_auth/local_auth.dart';

import '../../domain/repositories/local_auth_repository.dart';

class LocalAuthRepositoryImpl implements LocalAuthRepository {
  LocalAuthRepositoryImpl() : localAuth = LocalAuthentication();

  final LocalAuthentication localAuth;

  @override
  Future<bool> authenticate() async {
    final deviceSupportsBiometrics = await localAuth.isDeviceSupported();
    if (!deviceSupportsBiometrics) {
      return true;
    }

    return localAuth.authenticate(
      localizedReason: 'Verifizieren Sie ihre Identität',
      persistAcrossBackgrounding: true,
    );
  }
}
