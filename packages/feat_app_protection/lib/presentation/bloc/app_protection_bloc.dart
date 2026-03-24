import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:feat_app_protection/domain/repositories/app_protection_repository.dart';
import 'package:feat_app_protection/domain/usecases/interactors/authenticate_interactor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:service_logging/logging_interactor.dart';
import 'package:service_settings/domain/repositories/eike_settings_repository.dart';
import 'package:service_settings/domain/usecases/interactors/set_is_app_lock_enabled_interactor.dart';
import 'package:service_settings/domain/usecases/observers/is_app_lock_enabled_observer.dart';
import 'package:use_in_case/use_in_case.dart';

part 'app_protection_bloc.freezed.dart';
part 'app_protection_state.dart';
part 'app_protection_event.dart';

class AppProtectionBloc extends Bloc<AppProtectionEvent, AppProtectionState> {
  final AuthenticateInteractor authenticate;
  final SetIsAppLockEnabledInteractor setIsAppLockEnabled;
  final IsAppLockEnabledObserver isAppLockEnabledObserver;

  AppProtectionBloc(
    AppProtectionRepository repository,
    EikeSettingsRepository eikeSettingsRepository,
  ) : authenticate = AuthenticateInteractor(repository),
      setIsAppLockEnabled = SetIsAppLockEnabledInteractor(
        eikeSettingsRepository,
      ),
      isAppLockEnabledObserver = IsAppLockEnabledObserver(
        eikeSettingsRepository,
      ),
      super(AppProtectionState.initial()) {
    on<_OnSetup>(_onSetup);
    on<_OnAppPaused>(_onAppPaused);
    on<_OnAuthRequested>(_onAuthRequested);
  }

  FutureOr<void> _onSetup(_OnSetup event, Emitter<AppProtectionState> emit) {
    return _onAuthRequested(const _OnAuthRequested(), emit);
  }

  FutureOr<void> _onAppPaused(
    _OnAppPaused event,
    Emitter<AppProtectionState> emit,
  ) async {
    final isLockingRequired = await isAppLockEnabledObserver.observe().first;
    if (isLockingRequired) {
      emit(
        const AppProtectionState.locked(
          isAuthenticating: false,
          errorText: null,
        ),
      );
    }
  }

  FutureOr<void> _onAuthRequested(
    _OnAuthRequested event,
    Emitter<AppProtectionState> emit,
  ) {
    return authenticate
        .logger()
        .busyStateChange((isBusy) {
          if (state case _Locked state) {
            emit(state.copyWith(isAuthenticating: isBusy));
          }
        })
        .after((isAuthenticated) {
          if (state case _Locked state) {
            if (isAuthenticated) {
              emit(AppProtectionState.unlocked());
            } else {
              emit(
                state.copyWith(
                  errorText: 'Authentifizierung ist fehlgeschlagen',
                ),
              );
            }
          }
        })
        .intercept((exception) {
          if (state case _Locked state) {
            emit(state.copyWith(errorText: exception.toString()));
          }
        })
        .before(
          (_) {
            emit(
              const AppProtectionState.locked(
                isAuthenticating: false,
                errorText: null,
              ),
            );
          },
        )
        .run(unit);
  }
}
