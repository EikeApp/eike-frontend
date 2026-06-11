part of 'settings_bloc.dart';

@freezed
sealed class SettingsState with _$SettingsState {
  const factory SettingsState({
    required bool isAppLockEnabled,
  }) = _SettingsState;

  factory SettingsState.initial() {
    return const SettingsState(
      isAppLockEnabled: false,
    );
  }
}
