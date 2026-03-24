part of 'contact_bloc.dart';

@freezed
sealed class ContactEvent with _$ContactEvent {
  const factory ContactEvent.onSetup() = _OnSetup;
}
