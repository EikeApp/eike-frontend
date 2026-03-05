import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:data_entities/tables/team_contacts_table.dart';
import 'package:feat_settings/domain/usecases/interactors/cleanup_local_storage_interactor.dart';
import 'package:feat_settings/domain/usecases/interactors/get_team_contact_interactor.dart';
import 'package:feat_settings/domain/usecases/interactors/upsert_team_contact_interactor.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:feat_settings/domain/repositories/settings_repository.dart';
import 'package:service_logging/logging_interactor.dart';
import 'package:service_settings/domain/repositories/eike_settings_repository.dart';
import 'package:service_settings/domain/usecases/observers/is_app_lock_enabled_observer.dart';
import 'package:service_settings/domain/usecases/interactors/set_is_app_lock_enabled_interactor.dart';
import 'package:use_in_case/use_in_case.dart';

part 'settings_bloc.freezed.dart';
part 'settings_state.dart';
part 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetTeamContactInteractor getTeamContact;
  final UpsertTeamContactInteractor upsertTeamContact;
  final CleanupLocalStorageInteractor cleanupLocalStorage;
  final IsAppLockEnabledObserver isAppLockEnabledObserver;
  final SetIsAppLockEnabledInteractor setIsAppLockEnabled;

  final TextEditingController teamNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;

  SettingsBloc(
    SettingsRepository repository,
    EikeSettingsRepository eikeSettingsRepository,
  ) : getTeamContact = GetTeamContactInteractor(repository),
      upsertTeamContact = UpsertTeamContactInteractor(repository),
      cleanupLocalStorage = CleanupLocalStorageInteractor(repository),
      isAppLockEnabledObserver = IsAppLockEnabledObserver(
        eikeSettingsRepository,
      ),
      setIsAppLockEnabled = SetIsAppLockEnabledInteractor(
        eikeSettingsRepository,
      ),
      teamNameController = TextEditingController(),
      phoneController = TextEditingController(),
      emailController = TextEditingController(),
      super(SettingsState.initial()) {
    on<_OnSetup>(_onSetup);
    on<_OnUpsertTeamContact>(_onUpsertTeamContact);
    on<_OnCleanupLocalStorage>(_onCleanupLocalStorage);
    on<_OnSetIsAppLockEnabled>(_onSetIsAppLockEnabled);
  }

  FutureOr<void> _onSetup(_OnSetup event, Emitter<SettingsState> emit) async {
    emit(
      state.copyWith(
        teamNameController: teamNameController,
        phoneController: phoneController,
        emailController: emailController,
      ),
    );

    await getTeamContact
        .logger()
        .after((teamContact) {
          teamNameController.text = teamContact?.teamName ?? '';
          phoneController.text = teamContact?.phone ?? '';
          emailController.text = teamContact?.email ?? '';
        })
        .run(unit);

    return emit.forEach(
      isAppLockEnabledObserver.observe(),
      onData: (isEnabled) {
        return state.copyWith(isAppLockEnabled: isEnabled);
      },
    );
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

  FutureOr<void> _onSetIsAppLockEnabled(
    _OnSetIsAppLockEnabled event,
    Emitter<SettingsState> emit,
  ) {
    return setIsAppLockEnabled.logger().run(event.isEnabled);
  }
}
