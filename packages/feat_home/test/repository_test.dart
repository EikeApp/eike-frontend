import 'package:data_database/eike_database.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:feat_home/data/daos/home_dao.dart';
import 'package:feat_home/data/datasources/home_datasource.dart';
import 'package:feat_home/data/repositories/home_repository_impl.dart';
import 'package:feat_home/domain/models/tip.dart';
import 'package:feat_home/domain/repositories/home_repository.dart';
import 'package:test/test.dart';

class _FakeHomeDatasource implements HomeDatasource {
  const _FakeHomeDatasource({required this.tipCount});

  final int tipCount;

  @override
  Future<List<Tip>> fetchTips() async {
    return [
      for (var i = 0; i < tipCount; ++i)
        Tip(
          id: i,
          title: "Tip$i",
          description: "Desc$i",
          image: TipImage(imagePath: "ImgPath$i", alt: "Alt$i"),
        ),
    ];
  }
}

void main() {
  group('group name', () {
    const tipCount = 10;
    late EikeDatabase database;
    late HomeRepository repository;

    setUp(() {
      database = EikeDatabase(NativeDatabase.memory());
      repository = HomeRepositoryImpl(
        HomeDao(database),
        _FakeHomeDatasource(tipCount: tipCount),
      );
    });

    tearDown(() async {
      await database.close();
    });

    test('should synchronize all tips', () async {
      await repository.syncTips();

      final allTips = await database.tipTable.select().get();
      expect(allTips.length, equals(tipCount));
    });

    test('should update/overwrite existing todos', () async {
      await repository.syncTips();
      final firstTips = await database.tipTable.select().get();

      await repository.syncTips();
      final secondTips = await database.tipTable.select().get();

      expect(firstTips, orderedEquals(secondTips));
    });
  });
}
