part of 'contact_bloc.dart';

@freezed
sealed class ContactEvent with _$ContactEvent {
  const factory onSetup() = _OnSetup;
  const factory onSetTeamContactData({
    required TeamContactTeamName teamName,
    required TeamContactPhone phoneNumber,
    required TeamContactEmail email,
  }) = _OnSetTeamContactData;
}
