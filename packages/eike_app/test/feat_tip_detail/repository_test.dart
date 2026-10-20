import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/data_entities/tables/tip_table.dart';
import 'package:eike_app/feat_tip_detail/data/daos/tip_detail_dao.dart';
import 'package:eike_app/feat_tip_detail/data/repositories/tip_detail_repository_impl.dart';
import 'package:eike_app/feat_tip_detail/domain/repositories/tip_detail_repository.dart';
import 'package:test/test.dart';

void main() {
  group(TipDetailRepository, () {
    const tipId = TipId(3);
    late EikeDatabase database;
    late TipDetailRepository repository;

    setUp(() async {
      database = EikeDatabase(NativeDatabase.memory());
      repository = TipDetailRepositoryImpl(TipDetailDao(database));

      await database.tipTable.insertOne(
        TipTableCompanion.insert(
          id: const Value(tipId),
          position: TipPosition(4),
          title: TipTitle('Title'),
          description: TipDescription('Description'),
          imagePath: TipImagePath('ImgPath'),
          imageDescription: TipImageDescription('Alt'),
          userNote: TipUserNote(''),
        ),
      );
    });

    tearDown(() async {
      await database.close();
    });

    test('should observe the requested tip', () async {
      final tip = await repository.observeTip(tipId).first;

      expect(tip?.id, equals(tipId));
    });

    test('should observe null for an unknown tip', () async {
      final tip = await repository.observeTip(const TipId(42)).first;

      expect(tip, isNull);
    });

    test('should update user note', () async {
      const updatedUserNote = TipUserNote('Updated_Tip');

      await repository.updateUserNote(tipId, updatedUserNote);
      final tip = await repository.observeTip(tipId).first;

      expect(tip?.userNote, equals(updatedUserNote));
    });
  });
}
