import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/data_entities/tables/tip_table.dart';
import 'package:eike_app/feat_home/domain/repositories/home_repository.dart';
import 'package:eike_app/feat_home/domain/usecases/interactors/sync_tips_interactor.dart';
import 'package:eike_app/feat_home/domain/usecases/interactors/update_user_note_interactor.dart';
import 'package:eike_app/feat_home/domain/usecases/observers/tips_observer.dart';
import 'package:eike_app/feat_notification/domain/repositories/notification_repository.dart';
import 'package:eike_app/feat_notification/domain/usecases/interactors/emit_notification_interactor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:eike_app/service_bloc/contracts/eike_bloc.dart';
import 'package:eike_app/service_logging/logging_interactor.dart';
import 'package:use_in_case/use_in_case.dart';

part 'home_bloc.freezed.dart';
part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends EikeBloc<HomeEvent, HomeState> {
  final TipsObserver tipsObserver;
  final SyncTipsInteractor syncTipsInteractor;
  final UpdateUserNoteInteractor updateUserNote;
  final EmitNotificationInteractor emitNotification;

  HomeBloc(
    HomeRepository repository,
    NotificationRepository notificationRepository,
  ) : tipsObserver = TipsObserver(repository),
      syncTipsInteractor = SyncTipsInteractor(repository),
      updateUserNote = UpdateUserNoteInteractor(repository),
      emitNotification = EmitNotificationInteractor(notificationRepository),
      super(HomeState.initial(), notificationRepository) {
    on<_OnSetup>(_onSetup);
    on<_OnUserNoteChanged>(_onUserNoteChanged, transformer: droppable());
  }

  FutureOr<void> _onSetup(_OnSetup event, Emitter<HomeState> emit) async {
    await syncTipsInteractor
        .logger()
        .intercept(submitError)
        .busyStateChange((isBusy) => emit(state.copyWith(isLoading: isBusy)))
        .intercept((_) => emit(state.copyWith(hasError: true)))
        .before((_) => emit(state.copyWith(hasError: false)))
        .run(unit);

    return emit.forEach(
      tipsObserver.observe(),
      onData: (tips) {
        return state.copyWith(tips: tips);
      },
    );
  }

  FutureOr<void> _onUserNoteChanged(
    _OnUserNoteChanged event,
    Emitter<HomeState> emit,
  ) {
    return updateUserNote.logger().intercept(submitError).run((
      tipId: event.tipId,
      userNote: event.userNote,
    ));
  }
}
