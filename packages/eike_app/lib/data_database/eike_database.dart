import 'package:eike_app/data_entities/tables/team_contacts_table.dart';
import 'package:eike_app/data_entities/tables/tip_table.dart';
import 'package:drift/drift.dart';

part 'eike_database.g.dart';

@DriftDatabase(tables: [TeamContactTable, TipTable])
class EikeDatabase extends _$EikeDatabase {
  EikeDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
