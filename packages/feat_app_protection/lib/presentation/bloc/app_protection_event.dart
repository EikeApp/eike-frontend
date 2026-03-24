part of 'app_protection_bloc.dart';

@freezed
sealed class AppProtectionEvent with _$AppProtectionEvent {
  const factory AppProtectionEvent.onSetup() = _OnSetup;
  const factory AppProtectionEvent.onAppPaused() = _OnAppPaused;
  const factory AppProtectionEvent.onAuthRequested() = _OnAuthRequested;
}
