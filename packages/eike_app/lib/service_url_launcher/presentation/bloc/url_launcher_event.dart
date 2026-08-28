part of 'url_launcher_bloc.dart';

@freezed
sealed class UrlLauncherEvent with _$UrlLauncherEvent {
  const factory UrlLauncherEvent.onSetup() = _OnSetup;
  const factory UrlLauncherEvent.onLaunchUrl(Uri url) = _OnLaunchUrl;
}
