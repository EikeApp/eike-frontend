import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/data_entities/tables/tip_table.dart';

abstract interface class HomeRepository {
  Future<void> syncTips();
  Stream<List<TipEntity>> observeTips();
  Future<void> updateUserNote(TipId tipId, TipUserNote userNote);
}
