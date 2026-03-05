import 'package:data_database/eike_database.dart';
import 'package:data_entities/tables/team_contacts_table.dart';
import 'package:feat_settings/data/daos/settings_dao.dart';
import 'package:service_settings/domain/repositories/eike_settings_repository.dart';

import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDao dao;
  final EikeSettingsRepository settingsRepository;
  const SettingsRepositoryImpl(this.dao, this.settingsRepository);

  @override
  Future<void> upsert(
    TeamContactTeamName teamName,
    TeamContactPhone phone,
    TeamContactEmail email,
  ) {
    return dao.upsert(teamName, phone, email);
  }

  @override
  Future<void> cleanupLocalStorage() async {
    await dao.clearAllTables();
    await settingsRepository.resetAllSettings();
  }

  @override
  Stream<TeamContactEntity?> observeTeamContact() {
    return dao.observeTeamContact();
  }
}
