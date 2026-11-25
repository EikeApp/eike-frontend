import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:eike_app/feat_notification/domain/repositories/notification_repository.dart';
import 'package:eike_app/feat_settings/domain/usecases/interactors/cleanup_local_storage_interactor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:eike_app/feat_settings/domain/repositories/settings_repository.dart';
import 'package:eike_app/service_app_info/domain/models/app_info.dart';
import 'package:eike_app/service_app_info/domain/repositories/app_info_repository.dart';
import 'package:eike_app/service_app_info/domain/usecases/interactors/get_app_info_interactor.dart';
import 'package:eike_app/service_bloc/contracts/eike_bloc.dart';
import 'package:eike_app/service_logging/logging_interactor.dart';
import 'package:use_in_case/use_in_case.dart';

part 'settings_bloc.freezed.dart';
part 'settings_state.dart';
part 'settings_event.dart';

class SettingsBloc(
  SettingsRepository repository,
  NotificationRepository notificationRepository,
  AppInfoRepository appInfoRepository,
) extends EikeBloc<SettingsEvent, SettingsState> {
  final cleanupLocalStorage = CleanupLocalStorageInteractor(repository);
  final getAppInfo = GetAppInfoInteractor(appInfoRepository);

  this : super(.initial(), notificationRepository) {
    on<_OnSetup>(_onSetup);
    on<_OnCleanupLocalStorage>(_onCleanupLocalStorage);
  }

  FutureOr<void> _onSetup(_OnSetup event, Emitter<SettingsState> emit) {
    return getAppInfo
        .logger()
        .intercept(submitError)
        .after((appInfo) => emit(state.copyWith(appInfo: appInfo)))
        .run(unit);
  }

  FutureOr<void> _onCleanupLocalStorage(
    _OnCleanupLocalStorage event,
    Emitter<SettingsState> emit,
  ) {
    return cleanupLocalStorage.logger().intercept(submitError).run(unit);
  }
}
