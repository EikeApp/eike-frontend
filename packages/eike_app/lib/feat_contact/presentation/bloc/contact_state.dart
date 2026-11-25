part of 'contact_bloc.dart';

@freezed
sealed class ContactState with _$ContactState {
  const factory({required TeamContactEntity? teamContact}) = _ContactState;

  factory initial() {
    return const ContactState(
      teamContact: null,
    );
  }
}
