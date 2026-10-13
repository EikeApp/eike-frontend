import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/data_entities/tables/tip_table.dart';

abstract interface class TipDetailRepository {
  Stream<TipEntity?> observeTip(TipId tipId);
  Future<void> updateUserNote(TipId tipId, TipUserNote userNote);
}
