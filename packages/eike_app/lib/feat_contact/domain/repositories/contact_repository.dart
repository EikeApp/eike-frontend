import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/data_entities/tables/team_contacts_table.dart';

abstract interface class ContactRepository {
  Stream<TeamContactEntity?> observeTeamContact();
  Future<void> upsertTeamContact({
    required TeamContactTeamName teamName,
    required TeamContactPhone phoneNumber,
    required TeamContactEmail email,
  });
}
