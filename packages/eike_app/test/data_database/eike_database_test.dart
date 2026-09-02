import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/data_entities/tables/tip_table.dart';
import 'package:eike_app/feat_home/data/daos/home_dao.dart';
import 'package:eike_app/feat_home/data/datasources/home_datasource.dart';
import 'package:eike_app/feat_home/data/repositories/home_repository_impl.dart';
import 'package:eike_app/feat_home/domain/models/tip.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:test/test.dart';

class _FakeHomeDatasource implements HomeDatasource {
  const _FakeHomeDatasource();

  @override
  Future<List<Tip>> fetchTips() async {
    return const [
      Tip(
        id: 0,
        position: 1,
        title: 'Tip',
        description: 'Desc',
        image: TipImage(imagePath: 'ImgPath', alt: 'Alt'),
      ),
    ];
  }
}

void main() {
  group(EikeDatabase, () {
    // Regression test for the bug where `TipTable.position` was added
    // without bumping `schemaVersion` - already-installed apps kept their
    // pre-`position` on-disk schema forever, and every query touching
    // TipTable started failing with "no such column: position", which
    // rendered the home screen empty for exactly those users. This
    // reproduces that stale on-disk shape and confirms opening the
    // database now recovers instead of failing.
    test(
      'should recover when opened against a pre-"position" on-disk schema',
      () async {
        final raw = sqlite3.openInMemory();
        raw.execute('''
          CREATE TABLE tip_table (
            id INTEGER NOT NULL,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            image_path TEXT NOT NULL,
            image_description TEXT NOT NULL,
            user_note TEXT NOT NULL,
            PRIMARY KEY (id)
          )
        ''');
        raw.execute(
          "INSERT INTO tip_table VALUES (0, 'Old', 'Old', 'p', 'd', '')",
        );
        raw.execute('PRAGMA user_version = 1');

        final database = EikeDatabase(NativeDatabase.opened(raw));
        addTearDown(database.close);

        // Opening (and the first query touching TipTable) must not throw
        // "no such column: position" anymore.
        await expectLater(
          database.tipTable.select().get(),
          completion(isEmpty), // wiped, not migrated column-by-column
        );

        // And the app is fully usable again afterwards.
        final repository = HomeRepositoryImpl(
          HomeDao(database),
          const _FakeHomeDatasource(),
        );
        await repository.syncTips();

        final tips = await database.tipTable.select().get();
        expect(tips.single.position, equals(TipPosition(1)));
      },
    );
  });
}
