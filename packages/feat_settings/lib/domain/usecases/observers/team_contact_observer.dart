import 'package:data_database/eike_database.dart';
import 'package:feat_settings/domain/repositories/settings_repository.dart';

class TeamContactObserver {
  final SettingsRepository repository;
  const TeamContactObserver(this.repository);

  Stream<TeamContactEntity?> observe() {
    return repository.observeTeamContact();
  }
}
