import 'package:eike_app/data_database/eike_database.dart';

abstract interface class HomeRepository {
  Future<void> syncTips();
  Stream<List<TipEntity>> observeTips();
}
