import 'dart:async';

import 'package:data_entities/tables/team_contacts_table.dart';
import 'package:feat_settings/domain/repositories/settings_repository.dart';
import 'package:use_in_case/use_in_case.dart';

typedef UpsertTeamContactInput = ({
  TeamContactTeamName teamName,
  TeamContactPhone phone,
  TeamContactEmail email,
});

class UpsertTeamContactInteractor
    implements ParameterizedInteractor<UpsertTeamContactInput> {
  final SettingsRepository repository;
  const UpsertTeamContactInteractor(this.repository);

  @override
  FutureOr<void> getOrThrow(UpsertTeamContactInput input) {
    return repository.upsert(input.teamName, input.phone, input.email);
  }
}
