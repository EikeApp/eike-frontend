import 'package:eike_app/feat_settings/data/daos/settings_dao.dart';

import '../../domain/repositories/settings_repository.dart';

class const SettingsRepositoryImpl(final SettingsDao dao)
    implements SettingsRepository {
  @override
  Future<void> cleanupLocalStorage() async {
    await dao.clearAllTables();
  }
}
