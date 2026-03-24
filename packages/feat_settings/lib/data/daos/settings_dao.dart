import 'package:data_database/eike_database.dart';
import 'package:data_entities/tables/team_contacts_table.dart';
import 'package:drift/drift.dart';
import 'package:meta/meta.dart' show visibleForTesting;

part 'settings_dao.g.dart';

@DriftAccessor(tables: [TeamContactTable])
class SettingsDao extends DatabaseAccessor<EikeDatabase>
    with _$SettingsDaoMixin {
  @visibleForTesting
  static const teamContactEntryId = TeamContactId(1);

  SettingsDao(super.attachedDatabase);

  Future<void> upsert(
    TeamContactTeamName teamName,
    TeamContactPhone phone,
    TeamContactEmail email,
  ) {
    final entity = TeamContactTableCompanion.insert(
      id: Value(teamContactEntryId),
      teamName: TeamContactTeamName(teamName.trim()),
      phone: TeamContactPhone(phone.trim()),
      email: TeamContactEmail(email.trim()),
    );

    return into(teamContactTable).insertOnConflictUpdate(entity);
  }

  Future<void> clearAllTables() {
    // NOTE(Felix): Future-Proove implementation would be to deactivate foreign-key constraints and drop each table in reverse order.
    return batch((batch) {
      batch
        ..deleteAll(db.tipTable)
        ..deleteAll(db.teamContactTable);
    });
  }

  Stream<TeamContactEntity?> observeTeamContact() {
    final query = select(teamContactTable)..limit(1);
    return query.watchSingleOrNull();
  }
}
