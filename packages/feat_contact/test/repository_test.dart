import 'package:data_database/eike_database.dart';
import 'package:data_entities/tables/team_contacts_table.dart';
import 'package:drift/native.dart';
import 'package:feat_contact/data/daos/contact_dao.dart';
import 'package:feat_contact/data/repositories/contact_repository_impl.dart';
import 'package:feat_contact/domain/repositories/contact_repository.dart';
import 'package:test/test.dart';

void main() {
  group(ContactRepository, () {
    late EikeDatabase database;
    late ContactRepository repository;

    setUp(() {
      database = EikeDatabase(NativeDatabase.memory());
      repository = ContactRepositoryImpl(ContactDao(database));
    });

    tearDown(() async {
      return database.close();
    });

    test('Should return true', () {
      expect(true, isTrue);
    });

    test('should not contain a team contact initially', () async {
      final teamContact = repository.observeTeamContact().first;
      expectLater(teamContact, completion(isNull));
    });

    test('should contain team contact after call to upsert', () async {
      final teamName = TeamContactTeamName('TeamName');
      final phone = TeamContactPhone('Phone');
      final email = TeamContactEmail('Email');

      await database
          .into(database.teamContactTable)
          .insert(
            TeamContactTableCompanion.insert(
              teamName: teamName,
              phone: phone,
              email: email,
            ),
          );

      var teamContact = await repository.observeTeamContact().first;
      expect(teamContact, isNotNull);

      teamContact = teamContact!;
      expect(teamContact.teamName, equals(teamName));
      expect(teamContact.phone, equals(phone));
      expect(teamContact.email, equals(email));
    });
  });
}
