import 'package:drift/drift.dart';

// NOTE: Wenn du Tabellen/Spalten/Indizes in Drift änderst,
// musst du den Code-Generator neu laufen lassen:
// dart run build_runner build --delete-conflicting-outputs
//
// (Optional während der Entwicklung)
// dart run build_runner watch --delete-conflicting-outputs

class UserTipNotes extends Table {
  IntColumn get position => integer()(); // 1..7 (Primary Key)
  TextColumn get note => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {position};
}

class TeamContacts extends Table {
  // Wir erzwingen "genau 1 Datensatz" indem wir die ID fix auf 0/1 setzen.
  // (Alternativ ginge auch: ohne PK und LIMIT 1 – aber PK ist cleaner.)
  IntColumn get id => integer()(); // keine autoIncrement
  TextColumn get teamName => text().withDefault(const Constant(''))();
  TextColumn get phone => text().withDefault(const Constant(''))();
  TextColumn get email => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};
}
