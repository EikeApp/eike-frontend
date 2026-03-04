import 'package:drift/drift.dart';

extension type const TipId(int value) implements int {}
extension type const TipTitle(String value) implements String {}
extension type const TipNote(String value) implements String {}
extension type const TipImagePath(String value) implements String {}
extension type const TipImageDescription(String value) implements String {}

@DataClassName('TipEntity')
class TipTable extends Table {
  IntColumn get id => integer().map(const TipIdConverter())();
  TextColumn get title => text().map(const TipTitleConverter())();
  TextColumn get note => text().map(const TipNoteConverter())();
  TextColumn get imagePath => text().map(const TipImagePathConverter())();
  TextColumn get imageDescription =>
      text().map(const TipImageDescriptionConverter())();

  @override
  Set<Column> get primaryKey => {id};
}

class TipIdConverter implements TypeConverter<TipId, int> {
  const TipIdConverter();

  @override
  TipId fromSql(int fromDb) {
    return TipId(fromDb);
  }

  @override
  int toSql(TipId value) {
    return value;
  }
}

class TipTitleConverter implements TypeConverter<TipTitle, String> {
  const TipTitleConverter();

  @override
  TipTitle fromSql(String fromDb) {
    return TipTitle(fromDb);
  }

  @override
  String toSql(TipTitle value) {
    return value;
  }
}

class TipNoteConverter implements TypeConverter<TipNote, String> {
  const TipNoteConverter();

  @override
  TipNote fromSql(String fromDb) {
    return TipNote(fromDb);
  }

  @override
  String toSql(TipNote value) {
    return value;
  }
}

class TipImagePathConverter implements TypeConverter<TipImagePath, String> {
  const TipImagePathConverter();

  @override
  TipImagePath fromSql(String fromDb) {
    return TipImagePath(fromDb);
  }

  @override
  String toSql(TipImagePath value) {
    return value;
  }
}

class TipImageDescriptionConverter
    implements TypeConverter<TipImageDescription, String> {
  const TipImageDescriptionConverter();

  @override
  TipImageDescription fromSql(String fromDb) {
    return TipImageDescription(fromDb);
  }

  @override
  String toSql(TipImageDescription value) {
    return value;
  }
}
