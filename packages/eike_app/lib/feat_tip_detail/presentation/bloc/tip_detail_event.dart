part of 'tip_detail_bloc.dart';

@freezed
sealed class TipDetailEvent with _$TipDetailEvent {
  const factory onSetup() = _OnSetup;
  const factory onUserNoteChanged(TipUserNote userNote) = _OnUserNoteChanged;
}
