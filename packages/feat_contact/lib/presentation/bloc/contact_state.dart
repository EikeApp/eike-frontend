part of 'contact_bloc.dart';

@freezed
sealed class ContactState with _$ContactState {
  const factory ContactState({required TeamContactEntity? teamContact}) =
      _ContactState;

  factory ContactState.initial() {
    return const ContactState(
      teamContact: null,
    );
  }
}
