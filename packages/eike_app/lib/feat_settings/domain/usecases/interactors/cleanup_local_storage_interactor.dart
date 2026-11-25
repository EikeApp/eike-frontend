import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:eike_app/feat_settings/domain/repositories/settings_repository.dart';
import 'package:use_in_case/use_in_case.dart';

class const CleanupLocalStorageInteractor(
  final SettingsRepository repository,
) implements Interactor {
  @override
  FutureOr<void> getOrThrow(Unit input) {
    return repository.cleanupLocalStorage();
  }
}
