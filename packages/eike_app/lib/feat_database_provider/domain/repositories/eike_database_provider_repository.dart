import 'package:eike_app/data_database/eike_database.dart';

abstract interface class EikeDatabaseProviderRepository {
  Future<EikeDatabase> getDatabaseInstance();
}
