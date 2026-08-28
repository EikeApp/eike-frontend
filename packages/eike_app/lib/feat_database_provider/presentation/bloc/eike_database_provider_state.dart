part of 'eike_database_provider_bloc.dart';

@freezed
sealed class EikeDatabaseProviderState with _$EikeDatabaseProviderState {
  const factory EikeDatabaseProviderState({
    required EikeDatabase? database,
    required bool hasError,
    required bool isLoading,
  }) = _EikeDatabaseProviderState;

  factory EikeDatabaseProviderState.initial() {
    return const EikeDatabaseProviderState(
      database: null,
      hasError: false,
      isLoading: true,
    );
  }
}
