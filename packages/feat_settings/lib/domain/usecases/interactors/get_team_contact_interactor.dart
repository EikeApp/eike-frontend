import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:data_database/eike_database.dart';
import 'package:feat_settings/domain/repositories/settings_repository.dart';
import 'package:use_in_case/use_in_case.dart';

class GetTeamContactInteractor implements ResultInteractor<TeamContactEntity?> {
  final SettingsRepository repository;
  const GetTeamContactInteractor(this.repository);

  @override
  FutureOr<TeamContactEntity?> getOrThrow(Unit input) {
    return repository.getTeamContact();
  }
}
