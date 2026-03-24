part of 'url_launcher_bloc.dart';

@freezed
sealed class UrlLauncherState with _$UrlLauncherState {
  const factory UrlLauncherState() = _UrlLauncherState;

  factory UrlLauncherState.initial() {
    return const UrlLauncherState();
  }
}
