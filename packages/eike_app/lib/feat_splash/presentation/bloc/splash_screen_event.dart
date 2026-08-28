part of 'splash_screen_bloc.dart';

@freezed
sealed class SplashScreenEvent with _$SplashScreenEvent {
  const factory SplashScreenEvent.onSetup() = _OnSetup;
  const factory SplashScreenEvent.onTransitionStarted() = _OnTransitionStarted;
  const factory SplashScreenEvent.onTransitionCompleted() =
      _OnTransitionCompleted;
}
