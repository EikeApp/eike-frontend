import 'package:data_database/eike_database.dart';
import 'package:data_entities/tables/team_contacts_table.dart';
import 'package:drift/native.dart';
import 'package:feat_settings/data/daos/settings_dao.dart';
import 'package:feat_settings/data/repositories/settings_repository_impl.dart';
import 'package:feat_settings/domain/repositories/settings_repository.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:service_settings/data/repositories/eike_settings_repository_impl.dart';
import 'package:service_settings/domain/repositories/eike_settings_repository.dart';
import 'package:test/test.dart';

void main() {
  group(SettingsRepository, () {
    late EikeDatabase database;
    late EikeSettingsRepository eikeSettingsRepository;
    late SettingsRepository settingsRepository;

    setUp(() {
      SharedPreferences.setMockInitialValues({});

      database = EikeDatabase(NativeDatabase.memory());
      eikeSettingsRepository = EikeSettingsRepositoryImpl(
        RxSharedPreferences.getInstance(),
      );

      settingsRepository = SettingsRepositoryImpl(
        SettingsDao(database),
        eikeSettingsRepository,
      );
    });

    tearDown(() async {
      return database.close();
    });

    test('should not contain a team contact initially', () async {
      final teamContact = settingsRepository.getTeamContact();
      expectLater(teamContact, completion(isNull));
    });

    test('should contain team contact after call to upsert', () async {
      final teamName = TeamContactTeamName('TeamName');
      final phone = TeamContactPhone('Phone');
      final email = TeamContactEmail('Email');

      await settingsRepository.upsert(teamName, phone, email);
      var teamContact = await settingsRepository.getTeamContact();
      expect(teamContact, isNotNull);

      teamContact = teamContact!;
      expect(teamContact.id, equals(SettingsDao.teamContactEntryId));
      expect(teamContact.teamName, equals(teamName));
      expect(teamContact.phone, equals(phone));
      expect(teamContact.email, equals(email));
    });
  });
}
