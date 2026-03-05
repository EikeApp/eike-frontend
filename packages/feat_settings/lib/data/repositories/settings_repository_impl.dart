import 'package:data_database/eike_database.dart';
import 'package:data_entities/tables/team_contacts_table.dart';
import 'package:feat_settings/data/daos/settings_dao.dart';

import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDao dao;
  const SettingsRepositoryImpl(this.dao);

  @override
  Future<void> upsert(
    TeamContactTeamName teamName,
    TeamContactPhone phone,
    TeamContactEmail email,
  ) {
    return dao.upsert(teamName, phone, email);
  }

  @override
  Future<void> cleanupLocalStorage() async {}

  @override
  Future<TeamContactEntity?> getTeamContact() {
    return dao.getTeamContact();
  }
}
