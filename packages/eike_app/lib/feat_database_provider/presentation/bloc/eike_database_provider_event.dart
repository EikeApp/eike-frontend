part of 'eike_database_provider_bloc.dart';

@freezed
sealed class EikeDatabaseProviderEvent with _$EikeDatabaseProviderEvent {
  const factory EikeDatabaseProviderEvent.onSetup() = _OnSetup;
}
