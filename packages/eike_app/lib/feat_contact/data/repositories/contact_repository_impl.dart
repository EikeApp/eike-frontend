import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/data_entities/tables/team_contacts_table.dart';
import 'package:eike_app/feat_contact/data/daos/contact_dao.dart';
import 'package:eike_app/feat_contact/domain/repositories/contact_repository.dart';

class const ContactRepositoryImpl(final ContactDao dao)
    implements ContactRepository {
  @override
  Stream<TeamContactEntity?> observeTeamContact() {
    return dao.observeTeamContact();
  }

  @override
  Future<void> upsertTeamContact({
    required TeamContactTeamName teamName,
    required TeamContactPhone phoneNumber,
    required TeamContactEmail email,
  }) {
    return dao.upsertTeamContact(teamName, phoneNumber, email);
  }
}
