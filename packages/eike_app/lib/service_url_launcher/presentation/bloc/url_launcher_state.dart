part of 'url_launcher_bloc.dart';

@freezed
sealed class UrlLauncherState with _$UrlLauncherState {
  const factory() = _UrlLauncherState;

  factory initial() {
    return const UrlLauncherState();
  }
}
