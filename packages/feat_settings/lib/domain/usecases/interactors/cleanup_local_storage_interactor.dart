import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:feat_settings/domain/repositories/settings_repository.dart';
import 'package:use_in_case/use_in_case.dart';

class CleanupLocalStorageInteractor implements Interactor {
  final SettingsRepository repository;
  const CleanupLocalStorageInteractor(this.repository);

  @override
  FutureOr<void> getOrThrow(Unit input) {
    return repository.cleanupLocalStorage();
  }
}
