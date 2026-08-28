import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_screen_bloc.freezed.dart';
part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  static const splashDuration = Duration(milliseconds: 2500);
  static const transitionDuration = Duration(milliseconds: 200);

  Timer? _splashTimer;
  Timer? _transitionTimer;

  SplashScreenBloc() : super(const SplashScreenState.splash()) {
    on<_OnSetup>(_onSetup);
    on<_OnTransitionStarted>(_onTransitionStarted);
    on<_OnTransitionCompleted>(_onTransitionCompleted);
  }

  FutureOr<void> _onSetup(_OnSetup event, Emitter<SplashScreenState> emit) {
    _splashTimer = Timer(
      splashDuration,
      () => add(const SplashScreenEvent.onTransitionStarted()),
    );
  }

  FutureOr<void> _onTransitionStarted(
    _OnTransitionStarted event,
    Emitter<SplashScreenState> emit,
  ) {
    emit(const SplashScreenState.transitioning());
    _transitionTimer = Timer(
      transitionDuration,
      () => add(const SplashScreenEvent.onTransitionCompleted()),
    );
  }

  FutureOr<void> _onTransitionCompleted(
    _OnTransitionCompleted event,
    Emitter<SplashScreenState> emit,
  ) {
    emit(const SplashScreenState.ready());
  }

  @override
  Future<void> close() {
    _splashTimer?.cancel();
    _transitionTimer?.cancel();
    return super.close();
  }
}
