import 'package:drift/drift.dart';

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
