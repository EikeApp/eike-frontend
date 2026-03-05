import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:data_entities/tables/team_contacts_table.dart';
import 'package:feat_settings/domain/usecases/interactors/get_team_contact_interactor.dart';
import 'package:feat_settings/domain/usecases/interactors/upsert_team_contact_interactor.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:feat_settings/domain/repositories/settings_repository.dart';
import 'package:service_logging/logging_interactor.dart';
import 'package:use_in_case/use_in_case.dart';

part 'settings_bloc.freezed.dart';
part 'settings_state.dart';
part 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetTeamContactInteractor getTeamContact;
  final UpsertTeamContactInteractor upsertTeamContact;

  final TextEditingController teamNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;

  SettingsBloc(SettingsRepository repository)
    : getTeamContact = GetTeamContactInteractor(repository),
      upsertTeamContact = UpsertTeamContactInteractor(repository),
      teamNameController = TextEditingController(),
      phoneController = TextEditingController(),
      emailController = TextEditingController(),
      super(SettingsState.initial()) {
    on<_OnSetup>(_onSetup);
    on<_OnUpsertTeamContact>(_onUpsertTeamContact);
    on<_OnCleanupLocalStorage>(_onCleanupLocalStorage);
  }

  FutureOr<void> _onSetup(_OnSetup event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        teamNameController: teamNameController,
        phoneController: phoneController,
        emailController: emailController,
      ),
    );

    return getTeamContact
        .logger()
        .after((teamContact) {
          teamNameController.text = teamContact?.teamName ?? '';
          phoneController.text = teamContact?.phone ?? '';
          emailController.text = teamContact?.email ?? '';
        })
        .run(unit);
  }

  FutureOr<void> _onUpsertTeamContact(
    _OnUpsertTeamContact event,
    Emitter<SettingsState> emit,
  ) {
    return upsertTeamContact.logger().run((
      teamName: TeamContactTeamName(teamNameController.text),
      phone: TeamContactPhone(phoneController.text),
      email: TeamContactEmail(emailController.text),
    ));
  }

  FutureOr<void> _onCleanupLocalStorage(
    _OnCleanupLocalStorage event,
    Emitter<SettingsState> emit,
  ) {
    return cleanupLocalStorage.logger().run(unit);
  }
}
