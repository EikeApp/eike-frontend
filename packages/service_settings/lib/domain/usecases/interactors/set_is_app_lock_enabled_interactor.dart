import 'dart:async';

import 'package:service_settings/domain/repositories/eike_settings_repository.dart';
import 'package:use_in_case/use_in_case.dart';

class SetIsAppLockEnabledInteractor implements ParameterizedInteractor<bool> {
  final EikeSettingsRepository repository;
  const SetIsAppLockEnabledInteractor(this.repository);

  @override
  FutureOr<void> getOrThrow(bool input) {
    return repository.setAppLockEnabled(input);
  }
}
