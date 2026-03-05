part of 'settings_bloc.dart';

@freezed
sealed class SettingsState with _$SettingsState {
  const factory SettingsState({
    required TextEditingController? teamNameController,
    required TextEditingController? phoneController,
    required TextEditingController? emailController,
  }) = _SettingsState;

  factory SettingsState.initial() {
    return const SettingsState(
      teamNameController: null,
      phoneController: null,
      emailController: null,
    );
  }
}
