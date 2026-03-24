import 'package:data_database/eike_database.dart';

abstract interface class ContactRepository {
  Stream<TeamContactEntity?> observeTeamContact();
}
