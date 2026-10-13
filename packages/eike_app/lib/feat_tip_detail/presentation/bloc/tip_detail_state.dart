part of 'tip_detail_bloc.dart';

@freezed
sealed class TipDetailState with _$TipDetailState {
  const factory TipDetailState({
    required TipEntity? tip,
    required bool isLoading,
  }) = _TipDetailState;

  factory TipDetailState.initial() {
    return const TipDetailState(
      tip: null,
      isLoading: true,
    );
  }
}
