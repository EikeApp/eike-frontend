part of 'splash_screen_bloc.dart';

@freezed
sealed class SplashScreenState with _$SplashScreenState {
  const factory SplashScreenState.splash() = _Splash;
  const factory SplashScreenState.transitioning() = _Transitioning;
  const factory SplashScreenState.ready() = _Ready;
}
