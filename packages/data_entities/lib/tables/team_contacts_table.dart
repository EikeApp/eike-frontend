import 'package:drift/drift.dart';

extension type const TeamContactId(int value) implements int {}
extension type const TeamContactTeamName(String value) implements String {}
extension type const TeamContactPhone(String value) implements String {}
extension type const TeamContactEmail(String value) implements String {}

@DataClassName('TeamContactEntity')
class TeamContactTable extends Table {
  // Wir erzwingen "genau 1 Datensatz" indem wir die ID fix auf 0/1 setzen.
  // (Alternativ ginge auch: ohne PK und LIMIT 1 – aber PK ist cleaner.)
  IntColumn get id =>
      integer().map(const TeamContactIdConverter())(); // keine autoIncrement
  TextColumn get teamName => text()
      .withDefault(const Constant(''))
      .map(const TeamContactTeamNameConverter())();
  TextColumn get phone => text()
      .withDefault(const Constant(''))
      .map(const TeamContactPhoneConverter())();
  TextColumn get email => text()
      .withDefault(const Constant(''))
      .map(const TeamContactEmailConverter())();

  @override
  Set<Column> get primaryKey => {id};
}

class TeamContactIdConverter implements TypeConverter<TeamContactId, int> {
  const TeamContactIdConverter();

  @override
  TeamContactId fromSql(int fromDb) => TeamContactId(fromDb);

  @override
  int toSql(TeamContactId value) => value;
}

class TeamContactTeamNameConverter
    implements TypeConverter<TeamContactTeamName, String> {
  const TeamContactTeamNameConverter();

  @override
  TeamContactTeamName fromSql(String fromDb) => TeamContactTeamName(fromDb);

  @override
  String toSql(TeamContactTeamName value) => value;
}

class TeamContactPhoneConverter
    implements TypeConverter<TeamContactPhone, String> {
  const TeamContactPhoneConverter();

  @override
  TeamContactPhone fromSql(String fromDb) => TeamContactPhone(fromDb);

  @override
  String toSql(TeamContactPhone value) => value;
}

class TeamContactEmailConverter
    implements TypeConverter<TeamContactEmail, String> {
  const TeamContactEmailConverter();

  @override
  TeamContactEmail fromSql(String fromDb) => TeamContactEmail(fromDb);

  @override
  String toSql(TeamContactEmail value) => value;
}
