import 'package:eike_app/feat_settings/data/daos/settings_dao.dart';

import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDao dao;
  const SettingsRepositoryImpl(this.dao);

  @override
  Future<void> cleanupLocalStorage() async {
    await dao.clearAllTables();
  }
}
