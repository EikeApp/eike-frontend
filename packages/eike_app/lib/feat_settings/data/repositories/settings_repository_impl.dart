import 'package:eike_app/feat_settings/data/daos/settings_dao.dart';
import 'package:eike_app/service_settings/domain/repositories/eike_settings_repository.dart';

import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDao dao;
  final EikeSettingsRepository settingsRepository;
  const SettingsRepositoryImpl(this.dao, this.settingsRepository);

  @override
  Future<void> cleanupLocalStorage() async {
    await dao.clearAllTables();
    await settingsRepository.resetAllSettings();
  }
}
