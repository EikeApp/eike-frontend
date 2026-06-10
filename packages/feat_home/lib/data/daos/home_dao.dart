import 'package:data_database/eike_database.dart';
import 'package:data_entities/tables/tip_table.dart';
import 'package:drift/drift.dart';
import 'package:feat_home/domain/models/tip.dart';

part 'home_dao.g.dart';

@DriftAccessor(tables: [TipTable])
class HomeDao extends DatabaseAccessor<EikeDatabase> with _$HomeDaoMixin {
  HomeDao(super.attachedDatabase);

  Future<void> insert(Iterable<Tip> dtos) async {
    final existingTips = await select(tipTable).get();
    final existingTipById = {
      for (final tip in existingTips) tip.id: tip,
    };

    final tipIdsToRemove = <TipId>[];
    final tipEntities = <Insertable<TipEntity>>[];

    for (final dto in dtos) {
      final associatedTipEntity = existingTipById[dto.id];
      if (associatedTipEntity == null) {
        // DTO does not exist in our database yet - push em in
        tipEntities.add(_createInsertEntity(dto));
        continue;
      }

      tipEntities.add(_createUpdatedEntity(dto, associatedTipEntity));
    }

    return batch((batch) {
      batch
        ..deleteWhere(tipTable, (table) => table.id.isInValues(tipIdsToRemove))
        ..insertAllOnConflictUpdate(tipTable, tipEntities);
    });
  }

  Stream<List<TipEntity>> observeTips() {
    return select(tipTable).watch();
  }

  Future<void> updateUserNote(TipId tipId, TipUserNote userNote) {
    final updateQuery = update(tipTable)
      ..where((table) => table.id.equalsValue(tipId));

    return updateQuery.write(TipTableCompanion(userNote: Value(userNote)));
  }
}

Insertable<TipEntity> _createUpdatedEntity(Tip dto, TipEntity existingEntity) {
  return TipTableCompanion(
    id: Value(TipId(dto.id)),
    position: Value(TipPosition(dto.position)),
    title: Value(TipTitle(dto.title)),
    description: Value(TipDescription(dto.description)),
    imagePath: Value(TipImagePath(dto.image.imagePath)),
    imageDescription: Value(TipImageDescription(dto.image.alt)),
    userNote: Value(TipUserNote(existingEntity.userNote)), // Keep the user note
  );
}

Insertable<TipEntity> _createInsertEntity(Tip dto) {
  return TipTableCompanion(
    id: Value(TipId(dto.id)),
    position: Value(TipPosition(dto.position)),
    title: Value(TipTitle(dto.title)),
    description: Value(TipDescription(dto.description)),
    imagePath: Value(TipImagePath(dto.image.imagePath)),
    imageDescription: Value(TipImageDescription(dto.image.alt)),
    userNote: Value(TipUserNote('')),
  );
}
