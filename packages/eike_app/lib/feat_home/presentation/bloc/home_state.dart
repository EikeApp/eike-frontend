part of 'home_bloc.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState({
    required List<TipEntity> tips,
    required bool hasError,
    required bool isLoading,
  }) = _HomeState;

  factory HomeState.initial() {
    return const HomeState(
      tips: [],
      hasError: false,
      isLoading: true,
    );
  }
}
