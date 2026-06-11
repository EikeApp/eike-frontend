import 'package:data_database/eike_database.dart';
import 'package:data_entities/tables/team_contacts_table.dart';
import 'package:drift/drift.dart';
import 'package:meta/meta.dart';

part 'contact_dao.g.dart';

@DriftAccessor(tables: [TeamContactTable])
class ContactDao extends DatabaseAccessor<EikeDatabase> with _$ContactDaoMixin {
  @visibleForTesting
  static const teamContactEntryId = TeamContactId(1);

  ContactDao(super.attachedDatabase);

  Stream<TeamContactEntity?> observeTeamContact() {
    return select(teamContactTable).watchSingleOrNull();
  }

  Future<void> upsertTeamContact(
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
}
