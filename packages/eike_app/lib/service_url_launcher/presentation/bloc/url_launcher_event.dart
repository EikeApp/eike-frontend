part of 'url_launcher_bloc.dart';

@freezed
sealed class UrlLauncherEvent with _$UrlLauncherEvent {
  const factory onSetup() = _OnSetup;
  const factory onLaunchUrl(Uri url) = _OnLaunchUrl;
}
