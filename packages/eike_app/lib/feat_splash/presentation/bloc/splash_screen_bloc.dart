import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_screen_bloc.freezed.dart';
part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc() extends Bloc<SplashScreenEvent, SplashScreenState> {
  static const splashDuration = Duration(milliseconds: 2500);
  static const transitionDuration = Duration(milliseconds: 200);

  Timer? _splashTimer;
  Timer? _transitionTimer;

  this : super(const .splash()) {
    on<_OnSetup>(_onSetup);
    on<_OnTransitionStarted>(_onTransitionStarted);
    on<_OnTransitionCompleted>(_onTransitionCompleted);
  }

  FutureOr<void> _onSetup(_OnSetup event, Emitter<SplashScreenState> emit) {
    _splashTimer = Timer(
      splashDuration,
      () => add(const .onTransitionStarted()),
    );
  }

  FutureOr<void> _onTransitionStarted(
    _OnTransitionStarted event,
    Emitter<SplashScreenState> emit,
  ) {
    emit(const .transitioning());
    _transitionTimer = Timer(
      transitionDuration,
      () => add(const .onTransitionCompleted()),
    );
  }

  FutureOr<void> _onTransitionCompleted(
    _OnTransitionCompleted event,
    Emitter<SplashScreenState> emit,
  ) {
    emit(const .ready());
  }

  @override
  Future<void> close() {
    _splashTimer?.cancel();
    _transitionTimer?.cancel();
    return super.close();
  }
}
