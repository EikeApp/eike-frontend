part of 'splash_screen_bloc.dart';

@freezed
sealed class SplashScreenState with _$SplashScreenState {
  const factory splash() = _Splash;
  const factory transitioning() = _Transitioning;
  const factory ready() = _Ready;
}
