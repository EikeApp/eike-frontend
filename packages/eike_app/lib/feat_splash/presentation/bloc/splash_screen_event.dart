part of 'splash_screen_bloc.dart';

@freezed
sealed class SplashScreenEvent with _$SplashScreenEvent {
  const factory onSetup() = _OnSetup;
  const factory onTransitionStarted() = _OnTransitionStarted;
  const factory onTransitionCompleted() = _OnTransitionCompleted;
}
