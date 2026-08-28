import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:eike_app/data_database/eike_database.dart';
import 'package:use_in_case/use_in_case.dart';

import '../../repositories/eike_database_provider_repository.dart';

class GetEikeDatabaseInteractor implements ResultInteractor<EikeDatabase> {
  final EikeDatabaseProviderRepository repository;
  const GetEikeDatabaseInteractor(this.repository);

  @override
  FutureOr<EikeDatabase> getOrThrow(Unit input) {
    return repository.getDatabaseInstance();
  }
}
