import 'package:data_database/eike_database.dart';
import 'package:data_entities/tables/team_contacts_table.dart';

abstract interface class SettingsRepository {
  Future<void> upsert(
    TeamContactTeamName teamName,
    TeamContactPhone phone,
    TeamContactEmail email,
  );

  Future<void> cleanupLocalStorage();
  Future<TeamContactEntity?> getTeamContact();
}
