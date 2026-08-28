import 'package:local_auth/local_auth.dart';

import '../../domain/repositories/local_auth_repository.dart';

class LocalAuthRepositoryImpl implements LocalAuthRepository {
  LocalAuthRepositoryImpl() : localAuth = LocalAuthentication();

  final LocalAuthentication localAuth;

  @override
  Future<bool> authenticate() async {
    if (!await localAuth.isDeviceSupported()) {
      return true; // Nothing we can do at this point.
    }

    return localAuth.authenticate(
      localizedReason: 'Verifizieren Sie ihre Identität',
      persistAcrossBackgrounding: true,
    );
  }
}
