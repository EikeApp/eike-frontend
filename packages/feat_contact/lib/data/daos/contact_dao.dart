import 'package:data_database/eike_database.dart';
import 'package:data_entities/tables/team_contacts_table.dart';
import 'package:drift/drift.dart';

part 'contact_dao.g.dart';

@DriftAccessor(tables: [TeamContactTable])
class ContactDao extends DatabaseAccessor<EikeDatabase> with _$ContactDaoMixin {
  ContactDao(super.attachedDatabase);

  Stream<TeamContactEntity?> observeTeamContact() {
    return select(teamContactTable).watchSingleOrNull();
  }
}
