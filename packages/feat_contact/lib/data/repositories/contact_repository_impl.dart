import 'package:data_database/eike_database.dart';
import 'package:data_entities/tables/team_contacts_table.dart';
import 'package:feat_contact/data/daos/contact_dao.dart';
import 'package:feat_contact/domain/repositories/contact_repository.dart';

class ContactRepositoryImpl implements ContactRepository {
  const ContactRepositoryImpl(this.dao);

  final ContactDao dao;

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
