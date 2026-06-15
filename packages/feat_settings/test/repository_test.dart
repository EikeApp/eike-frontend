import 'package:data_database/eike_database.dart';
import 'package:data_entities/tables/team_contacts_table.dart';
import 'package:data_entities/tables/tip_table.dart';
import 'package:drift/drift.dart';
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

    test(
      'should clear all tables and reset all settings on cleanupLocalStorage',
      () async {
        for (var i = 0; i < 10; ++i) {
          await database
              .into(database.tipTable)
              .insert(
                TipTableCompanion.insert(
                  id: Value(TipId(i)),
                  position: TipPosition(i + 1),
                  title: TipTitle('Test Tip $i'),
                  description: TipDescription('This is a test tip.'),
                  imagePath: TipImagePath('path/to/image.png'),
                  imageDescription: TipImageDescription('Image description'),
                  userNote: TipUserNote('User note for the tip.'),
                ),
              );
        }

        await database
            .into(database.teamContactTable)
            .insert(
              TeamContactTableCompanion.insert(
                id: Value(TeamContactId(1)),
                teamName: TeamContactTeamName('John Doe'),
                email: TeamContactEmail(''),
                phone: TeamContactPhone(''),
              ),
            );

        await settingsRepository.cleanupLocalStorage();

        expect(database.teamContactTable.select().get(), completion(isEmpty));

        final tips = await database.tipTable.select().get();
        expect(tips, hasLength(10));
        expect(
          tips,
          predicate(
            (Iterable<TipEntity> tips) {
              return tips.every((tip) => tip.userNote.value == '');
            },
          ),
        );
      },
    );
  });
}
