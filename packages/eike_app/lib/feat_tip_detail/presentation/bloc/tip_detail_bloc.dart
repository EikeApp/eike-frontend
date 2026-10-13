import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/data_entities/tables/tip_table.dart';
import 'package:eike_app/feat_notification/domain/repositories/notification_repository.dart';
import 'package:eike_app/feat_tip_detail/domain/repositories/tip_detail_repository.dart';
import 'package:eike_app/feat_tip_detail/domain/usecases/interactors/update_user_note_interactor.dart';
import 'package:eike_app/feat_tip_detail/domain/usecases/observers/tip_observer.dart';
import 'package:eike_app/service_bloc/contracts/eike_bloc.dart';
import 'package:eike_app/service_logging/logging_interactor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:use_in_case/use_in_case.dart';

part 'tip_detail_bloc.freezed.dart';
part 'tip_detail_event.dart';
part 'tip_detail_state.dart';

class TipDetailBloc extends EikeBloc<TipDetailEvent, TipDetailState> {
  final TipId tipId;
  final TipObserver tipObserver;
  final UpdateUserNoteInteractor updateUserNote;

  TipDetailBloc(
    this.tipId,
    TipDetailRepository repository,
    NotificationRepository notificationRepository,
  ) : tipObserver = TipObserver(repository),
      updateUserNote = UpdateUserNoteInteractor(repository),
      super(TipDetailState.initial(), notificationRepository) {
    on<_OnSetup>(_onSetup);
    on<_OnUserNoteChanged>(_onUserNoteChanged, transformer: sequential());
  }

  FutureOr<void> _onSetup(_OnSetup event, Emitter<TipDetailState> emit) {
    return emit.forEach(
      tipObserver.observe(tipId),
      onData: (tip) {
        return state.copyWith(tip: tip, isLoading: false);
      },
    );
  }

  FutureOr<void> _onUserNoteChanged(
    _OnUserNoteChanged event,
    Emitter<TipDetailState> emit,
  ) {
    return updateUserNote.logger().intercept(submitError).run((
      tipId: tipId,
      userNote: event.userNote,
    ));
  }
}
