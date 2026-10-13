part of 'tip_detail_bloc.dart';

@freezed
sealed class TipDetailEvent with _$TipDetailEvent {
  const factory TipDetailEvent.onSetup() = _OnSetup;
  const factory TipDetailEvent.onUserNoteChanged(TipUserNote userNote) =
      _OnUserNoteChanged;
}
