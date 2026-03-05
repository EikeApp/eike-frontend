import 'package:data_database/eike_database.dart';
import 'package:data_entities/tables/team_contacts_table.dart';
import 'package:drift/drift.dart';

part 'settings_dao.g.dart';

@DriftAccessor(tables: [TeamContactTable])
class SettingsDao extends DatabaseAccessor<EikeDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(super.attachedDatabase);

  Future<void> upsert(
    TeamContactTeamName teamName,
    TeamContactPhone phone,
    TeamContactEmail email,
  ) {
    final entity = TeamContactTableCompanion.insert(
      id: Value(TeamContactId(1)),
      teamName: teamName,
      phone: phone,
      email: email,
    );

    return into(teamContactTable).insertOnConflictUpdate(entity);
  }

  Future<void> cleanupLocalStorage() {
    // NOTE(Felix): Future-Proove implementation would be to deactivate foreign-key constraints and drop each table in reverse order.
    return batch((batch) {
      batch
        ..deleteAll(db.tipTable)
        ..deleteAll(db.teamContactTable);
    });
  }

  Future<TeamContactEntity?> getTeamContact() {
    final query = select(teamContactTable)..limit(1);
    return query.getSingleOrNull();
  }
}
