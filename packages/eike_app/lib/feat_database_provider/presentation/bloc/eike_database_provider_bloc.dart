import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/feat_notification/domain/repositories/notification_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:eike_app/service_bloc/contracts/eike_bloc.dart';
import 'package:eike_app/service_logging/logging_interactor.dart';
import 'package:use_in_case/use_in_case.dart';

import '../../domain/repositories/eike_database_provider_repository.dart';
import '../../domain/usecases/interactors/get_eike_database_interactor.dart';

part 'eike_database_provider_bloc.freezed.dart';
part 'eike_database_provider_event.dart';
part 'eike_database_provider_state.dart';

class EikeDatabaseProviderBloc
    extends EikeBloc<EikeDatabaseProviderEvent, EikeDatabaseProviderState> {
  final GetEikeDatabaseInteractor getEikeDatabase;

  EikeDatabaseProviderBloc(
    EikeDatabaseProviderRepository repository,
    NotificationRepository notificationRepository,
  ) : getEikeDatabase = GetEikeDatabaseInteractor(repository),
      super(
        EikeDatabaseProviderState.initial(),
        notificationRepository,
      ) {
    on<_OnSetup>(_onSetup);
  }

  @override
  Future<void> close() async {
    await state.database?.close();
    return super.close();
  }

  FutureOr<void> _onSetup(
    _OnSetup event,
    Emitter<EikeDatabaseProviderState> emit,
  ) {
    return getEikeDatabase
        .logger()
        .after((instance) => emit(state.copyWith(database: instance)))
        .busyStateChange((isBusy) => emit(state.copyWith(isLoading: isBusy)))
        .intercept((_) => emit(state.copyWith(hasError: true)))
        .before((_) => emit(state.copyWith(hasError: false)))
        .run(unit);
  }
}
