import 'dart:async';

import 'package:data_entities/tables/team_contacts_table.dart';
import 'package:feat_contact/domain/repositories/contact_repository.dart';
import 'package:use_in_case/use_in_case.dart';

typedef UpsertTeamContactInteractorInput = ({
  TeamContactTeamName teamName,
  TeamContactPhone phoneNumber,
  TeamContactEmail email,
});

class UpsertTeamContactInteractor
    implements ParameterizedInteractor<UpsertTeamContactInteractorInput> {
  final ContactRepository repository;
  const UpsertTeamContactInteractor(this.repository);

  @override
  FutureOr<void> getOrThrow(UpsertTeamContactInteractorInput input) {
    return repository.upsertTeamContact(
      teamName: input.teamName,
      phoneNumber: input.phoneNumber,
      email: input.email,
    );
  }
}
