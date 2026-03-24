part of 'home_bloc.dart';

@freezed
sealed class HomeEvent with _$HomeEvent {
  const factory HomeEvent.onSetup() = _OnSetup;
  const factory HomeEvent.onUserNoteChanged(TipId tipId, TipUserNote userNote) =
      _OnUserNoteChanged;
}
