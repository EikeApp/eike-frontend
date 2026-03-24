part of 'settings_bloc.dart';

@freezed
sealed class SettingsState with _$SettingsState {
  const factory SettingsState({
    required bool isAppLockEnabled,
    required TextEditingController? teamNameController,
    required TextEditingController? phoneController,
    required TextEditingController? emailController,
  }) = _SettingsState;

  factory SettingsState.initial() {
    return const SettingsState(
      isAppLockEnabled: false,
      teamNameController: null,
      phoneController: null,
      emailController: null,
    );
  }
}
