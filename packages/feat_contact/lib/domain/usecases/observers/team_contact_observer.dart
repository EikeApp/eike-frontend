import 'package:data_database/eike_database.dart';
import 'package:feat_contact/domain/repositories/contact_repository.dart';

class TeamContactObserver {
  const TeamContactObserver(this.repository);

  final ContactRepository repository;

  Stream<TeamContactEntity?> observe() {
    return repository.observeTeamContact();
  }
}
