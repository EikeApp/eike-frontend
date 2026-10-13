import 'package:drift/drift.dart';
import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/data_entities/tables/tip_table.dart';

part 'tip_detail_dao.g.dart';

@DriftAccessor(tables: [TipTable])
class TipDetailDao extends DatabaseAccessor<EikeDatabase>
    with _$TipDetailDaoMixin {
  TipDetailDao(super.attachedDatabase);

  Stream<TipEntity?> observeTip(TipId tipId) {
    final query = select(tipTable)
      ..where((table) => table.id.equalsValue(tipId));

    return query.watchSingleOrNull();
  }

  Future<void> updateUserNote(TipId tipId, TipUserNote userNote) {
    final updateQuery = update(tipTable)
      ..where((table) => table.id.equalsValue(tipId));

    return updateQuery.write(TipTableCompanion(userNote: Value(userNote)));
  }
}
