import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/data_entities/tables/team_contacts_table.dart';
import 'package:eike_app/feat_contact/domain/repositories/contact_repository.dart';
import 'package:eike_app/feat_contact/presentation/bloc/contact_bloc.dart';
import 'package:eike_app/feat_notification/domain/models/eike_notification.dart';
import 'package:eike_app/feat_notification/domain/repositories/notification_repository.dart';
import 'package:test/test.dart';

class _FakeContactRepository implements ContactRepository {
  final _controller = StreamController<TeamContactEntity?>.broadcast();
  final upsertCalls = <TeamContactEntity>[];

  void emit(TeamContactEntity? entity) => _controller.add(entity);

  @override
  Stream<TeamContactEntity?> observeTeamContact() => _controller.stream;

  @override
  Future<void> upsertTeamContact({
    required TeamContactTeamName teamName,
    required TeamContactPhone phoneNumber,
    required TeamContactEmail email,
  }) async {
    upsertCalls.add(
      TeamContactEntity(
        id: const TeamContactId(1),
        teamName: teamName,
        phone: phoneNumber,
        email: email,
      ),
    );
  }
}

class _FakeNotificationRepository implements NotificationRepository {
  final emittedNotifications = <EikeNotification>[];

  @override
  Future<void> closeStream() async {}

  @override
  void emitNotification(EikeNotification notification) {
    emittedNotifications.add(notification);
  }

  @override
  Stream<EikeNotification> observeNotification() => const Stream.empty();
}

void main() {
  group(ContactBloc, () {
    late _FakeContactRepository repository;
    late _FakeNotificationRepository notificationRepo;

    setUp(() {
      repository = _FakeContactRepository();
      notificationRepo = _FakeNotificationRepository();
    });

    ContactBloc buildBloc() => ContactBloc(repository, notificationRepo);

    final teamContact = TeamContactEntity(
      id: const TeamContactId(1),
      teamName: TeamContactTeamName('Blauer Engel'),
      phone: TeamContactPhone('0170123456'),
      email: TeamContactEmail('team@example.com'),
    );

    blocTest<ContactBloc, ContactState>(
      'should reflect team contact updates observed from the repository',
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const ContactEvent.onSetup());
        // Let the emit.forEach subscription in _onSetup actually attach
        // before pushing through the repository stream.
        await Future<void>.delayed(Duration.zero);
        repository.emit(teamContact);
      },
      expect: () => [ContactState(teamContact: teamContact)],
    );

    blocTest<ContactBloc, ContactState>(
      'should upsert the entered team contact data',
      build: buildBloc,
      act: (bloc) => bloc.add(
        ContactEvent.onSetTeamContactData(
          teamName: TeamContactTeamName('Blauer Engel'),
          phoneNumber: TeamContactPhone('0170123456'),
          email: TeamContactEmail('team@example.com'),
        ),
      ),
      expect: () => [],
      verify: (_) => expect(repository.upsertCalls, hasLength(1)),
    );
  });
}
