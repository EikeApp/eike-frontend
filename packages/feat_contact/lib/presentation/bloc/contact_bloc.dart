import 'dart:async';

import 'package:data_database/eike_database.dart';
import 'package:data_entities/tables/team_contacts_table.dart';
import 'package:feat_contact/domain/repositories/contact_repository.dart';
import 'package:feat_contact/domain/usecases/interactors/upsert_team_contact_interactor.dart';
import 'package:feat_contact/domain/usecases/observers/team_contact_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:service_logging/logging_interactor.dart';
import 'package:use_in_case/use_in_case.dart';

part 'contact_bloc.freezed.dart';
part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final TeamContactObserver teamContactObserver;
  final UpsertTeamContactInteractor upsertTeamContact;

  ContactBloc(ContactRepository repository)
    : teamContactObserver = TeamContactObserver(repository),
      upsertTeamContact = UpsertTeamContactInteractor(repository),
      super(ContactState.initial()) {
    on<_OnSetup>(_onSetup);
    on<_OnSetTeamContactData>(_onSetTeamContactData);
  }

  FutureOr<void> _onSetup(_OnSetup event, Emitter<ContactState> emit) {
    return emit.forEach(
      teamContactObserver.observe(),
      onData: (teamContact) {
        return state.copyWith(teamContact: teamContact);
      },
    );
  }

  FutureOr<void> _onSetTeamContactData(
    _OnSetTeamContactData event,
    Emitter<ContactState> emit,
  ) {
    return upsertTeamContact.logger().run((
      teamName: event.teamName,
      phoneNumber: event.phoneNumber,
      email: event.email,
    ));
  }
}
