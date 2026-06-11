import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:feat_settings/domain/usecases/interactors/cleanup_local_storage_interactor.dart';
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
  final CleanupLocalStorageInteractor cleanupLocalStorage;
  final IsAppLockEnabledObserver isAppLockEnabledObserver;
  final SetIsAppLockEnabledInteractor setIsAppLockEnabled;

  SettingsBloc(
    SettingsRepository repository,
    EikeSettingsRepository eikeSettingsRepository,
  ) : cleanupLocalStorage = CleanupLocalStorageInteractor(repository),
      isAppLockEnabledObserver = IsAppLockEnabledObserver(
        eikeSettingsRepository,
      ),
      setIsAppLockEnabled = SetIsAppLockEnabledInteractor(
        eikeSettingsRepository,
      ),
      super(SettingsState.initial()) {
    on<_OnSetup>(_onSetup);
    on<_OnCleanupLocalStorage>(_onCleanupLocalStorage);
    on<_OnSetIsAppLockEnabled>(_onSetIsAppLockEnabled);
  }

  FutureOr<void> _onSetup(_OnSetup event, Emitter<SettingsState> emit) async {
    return emit.forEach(
      isAppLockEnabledObserver.observe(),
      onData: (isAppLockEnabled) {
        return state.copyWith(isAppLockEnabled: isAppLockEnabled);
      },
    );
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
