import 'dart:async';

import 'package:data_database/eike_database.dart';
import 'package:feat_contact/domain/repositories/contact_repository.dart';
import 'package:feat_contact/domain/usecases/observers/team_contact_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_bloc.freezed.dart';
part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final TeamContactObserver teamContactObserver;

  ContactBloc(ContactRepository repository)
    : teamContactObserver = TeamContactObserver(repository),
      super(ContactState.initial()) {
    on<_OnSetup>(_onSetup);
  }

  FutureOr<void> _onSetup(_OnSetup event, Emitter<ContactState> emit) {
    return emit.forEach(
      teamContactObserver.observe(),
      onData: (teamContact) {
        return state.copyWith(teamContact: teamContact);
      },
    );
  }
}
