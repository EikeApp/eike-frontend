part of 'settings_bloc.dart';

@freezed
sealed class SettingsEvent with _$SettingsEvent {
  const factory onSetup() = _OnSetup;
  const factory onUpsertTeamContact() = _OnUpsertTeamContact;
  const factory onCleanupLocalStorage() = _OnCleanupLocalStorage;
}
