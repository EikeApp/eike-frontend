import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:eike_app/feat_home/domain/repositories/home_repository.dart';
import 'package:use_in_case/use_in_case.dart';

class SyncTipsInteractor implements Interactor {
  final HomeRepository repository;
  const SyncTipsInteractor(this.repository);

  @override
  FutureOr<void> getOrThrow(Unit input) {
    return repository.syncTips();
  }
}
