part of 'tip_detail_bloc.dart';

@freezed
sealed class TipDetailState with _$TipDetailState {
  const factory({
    required TipEntity? tip,
    required bool isLoading,
  }) = _TipDetailState;

  factory initial() {
    return const TipDetailState(
      tip: null,
      isLoading: true,
    );
  }
}
