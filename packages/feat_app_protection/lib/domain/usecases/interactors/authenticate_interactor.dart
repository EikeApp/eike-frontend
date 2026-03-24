import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:feat_app_protection/domain/repositories/app_protection_repository.dart';
import 'package:use_in_case/use_in_case.dart';

class AuthenticateInteractor implements ResultInteractor<bool> {
  final AppProtectionRepository repository;
  const AuthenticateInteractor(this.repository);

  @override
  FutureOr<bool> getOrThrow(Unit input) {
    return repository.authenticate();
  }
}
