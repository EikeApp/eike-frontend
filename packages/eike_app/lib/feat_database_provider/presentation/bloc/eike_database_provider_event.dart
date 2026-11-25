part of 'eike_database_provider_bloc.dart';

@freezed
sealed class EikeDatabaseProviderEvent with _$EikeDatabaseProviderEvent {
  const factory onSetup() = _OnSetup;
}
