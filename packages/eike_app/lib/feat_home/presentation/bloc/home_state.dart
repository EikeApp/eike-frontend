part of 'home_bloc.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory({
    required List<TipEntity> tips,
    required bool hasError,
    required bool isLoading,
  }) = _HomeState;

  factory initial() {
    return const HomeState(
      tips: [],
      hasError: false,
      isLoading: true,
    );
  }
}
