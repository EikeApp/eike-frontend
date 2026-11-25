import 'package:drift/drift.dart';

extension type const TipId(int value) implements int;

extension type const TipPosition(int value) implements int;

extension type const TipTitle(String value) implements String;

extension type const TipDescription(String value) implements String;

extension type const TipQuestion(String value) implements String;

extension type const TipImagePath(String value) implements String;

extension type const TipImageDescription(String value) implements String;

extension type const TipUserNote(String value) implements String;

@DataClassName('TipEntity')
class TipTable extends Table {
  IntColumn get id => integer().map(const TipIdConverter())();
  IntColumn get position => integer().map(const TipPositionConverter())();
  TextColumn get title => text().map(const TipTitleConverter())();
  TextColumn get description => text().map(const TipDescriptionConverter())();
  TextColumn get question =>
      text().nullable().map(const TipQuestionConverter())();
  TextColumn get imagePath => text().map(const TipImagePathConverter())();
  TextColumn get imageDescription =>
      text().map(const TipImageDescriptionConverter())();
  TextColumn get userNote => text().map(const TipUserNoteConverter())();

  @override
  Set<Column> get primaryKey => {id};
}

class const TipIdConverter() implements TypeConverter<TipId, int> {
  @override
  TipId fromSql(int fromDb) {
    return TipId(fromDb);
  }

  @override
  int toSql(TipId value) {
    return value;
  }
}

class const TipPositionConverter() implements TypeConverter<TipPosition, int> {
  @override
  TipPosition fromSql(int fromDb) {
    return TipPosition(fromDb);
  }

  @override
  int toSql(TipPosition value) {
    return value;
  }
}

class const TipTitleConverter() implements TypeConverter<TipTitle, String> {
  @override
  TipTitle fromSql(String fromDb) {
    return TipTitle(fromDb);
  }

  @override
  String toSql(TipTitle value) {
    return value;
  }
}

class const TipDescriptionConverter()
    implements TypeConverter<TipDescription, String> {
  @override
  TipDescription fromSql(String fromDb) {
    return TipDescription(fromDb);
  }

  @override
  String toSql(TipDescription value) {
    return value;
  }
}

class const TipQuestionConverter()
    implements TypeConverter<TipQuestion, String> {
  @override
  TipQuestion fromSql(String fromDb) {
    return TipQuestion(fromDb);
  }

  @override
  String toSql(TipQuestion value) {
    return value;
  }
}

class const TipImagePathConverter()
    implements TypeConverter<TipImagePath, String> {
  @override
  TipImagePath fromSql(String fromDb) {
    return TipImagePath(fromDb);
  }

  @override
  String toSql(TipImagePath value) {
    return value;
  }
}

class const TipImageDescriptionConverter()
    implements TypeConverter<TipImageDescription, String> {
  @override
  TipImageDescription fromSql(String fromDb) {
    return TipImageDescription(fromDb);
  }

  @override
  String toSql(TipImageDescription value) {
    return value;
  }
}

class const TipUserNoteConverter()
    implements TypeConverter<TipUserNote, String> {
  @override
  TipUserNote fromSql(String fromDb) {
    return TipUserNote(fromDb);
  }

  @override
  String toSql(TipUserNote value) {
    return value;
  }
}
