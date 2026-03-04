import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:data_database/eike_database.dart';
import 'package:feat_home/domain/repositories/home_repository.dart';
import 'package:feat_home/domain/usecases/interactors/sync_tips_interactor.dart';
import 'package:feat_home/domain/usecases/observers/tips_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:service_logging/logging_interactor.dart';
import 'package:use_in_case/use_in_case.dart';

part 'home_bloc.freezed.dart';
part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TipsObserver tipsObserver;
  final SyncTipsInteractor syncTipsInteractor;

  HomeBloc(HomeRepository repository)
    : tipsObserver = TipsObserver(repository),
      syncTipsInteractor = SyncTipsInteractor(repository),
      super(HomeState.initial()) {
    on<_OnSetup>(_onSetup);
  }

  FutureOr<void> _onSetup(_OnSetup event, Emitter<HomeState> emit) async {
    await syncTipsInteractor
        .logger()
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
}
