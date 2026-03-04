import 'package:data_database/eike_database.dart';
import 'package:data_entities/tables/tip_table.dart';
import 'package:drift/drift.dart';

part 'home_dao.g.dart';

@DriftAccessor(tables: [TipTable])
class HomeDao extends DatabaseAccessor<EikeDatabase> with _$HomeDaoMixin {
  HomeDao(super.attachedDatabase);

  Future<void> insert(Iterable<TipEntity> entities) async {
    return batch((batch) {
      // NOTE(Felix): Would be better to replace individuals instead of getting rid of all of 'em.
      batch
        ..deleteAll(tipTable)
        ..insertAllOnConflictUpdate(tipTable, entities);
    });
  }

  Stream<List<TipEntity>> observeTips() {
    return select(tipTable).watch();
  }
}
