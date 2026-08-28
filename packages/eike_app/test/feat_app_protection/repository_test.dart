import 'package:eike_app/feat_app_protection/data/repositories/app_protection_repository_impl.dart';
import 'package:eike_app/feat_app_protection/domain/repositories/app_protection_repository.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:eike_app/service_auth/domain/repositories/local_auth_repository.dart';
import 'package:eike_app/service_settings/data/repositories/eike_settings_repository_impl.dart';
import 'package:eike_app/service_settings/domain/repositories/eike_settings_repository.dart';
import 'package:test/test.dart';

class _FakeLocalAuthRepo implements LocalAuthRepository {
  late bool authenticationResult;
  var called = false;

  @override
  Future<bool> authenticate() async {
    called = true;
    return authenticationResult;
  }
}

void main() {
  group(AppProtectionRepository, () {
    late _FakeLocalAuthRepo authRepo;
    late EikeSettingsRepository settingsRepo;
    late AppProtectionRepository repository;

    setUp(() {
      SharedPreferences.setMockInitialValues({});

      authRepo = _FakeLocalAuthRepo();
      settingsRepo = EikeSettingsRepositoryImpl(
        RxSharedPreferences.getInstance(),
      );
      repository = AppProtectionRepositoryImpl(settingsRepo, authRepo);
    });

    test(
      'should require authentication but rejected due to biometric',
      () async {
        await settingsRepo.setAppLockEnabled(true);
        authRepo.authenticationResult = false;

        await expectLater(repository.authenticate(), completion(isFalse));
        expect(authRepo.called, isTrue);
      },
    );

    test(
      'should succeed authentication including biometric',
      () async {
        await settingsRepo.setAppLockEnabled(true);
        authRepo.authenticationResult = true;

        await expectLater(repository.authenticate(), completion(isTrue));
        expect(authRepo.called, isTrue);
      },
    );

    test(
      'should authenticate without call to local auth',
      () async {
        await settingsRepo.setAppLockEnabled(false);
        await expectLater(repository.authenticate(), completion(isTrue));
        expect(authRepo.called, isFalse);
      },
    );
  });
}
