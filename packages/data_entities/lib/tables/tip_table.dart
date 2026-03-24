import 'package:drift/drift.dart';

extension type const TipId(int value) implements int {}
extension type const TipTitle(String value) implements String {}
extension type const TipDescription(String value) implements String {}
extension type const TipImagePath(String value) implements String {}
extension type const TipImageDescription(String value) implements String {}
extension type const TipUserNote(String value) implements String {}

@DataClassName('TipEntity')
class TipTable extends Table {
  IntColumn get id => integer().map(const TipIdConverter())();
  TextColumn get title => text().map(const TipTitleConverter())();
  TextColumn get description => text().map(const TipDescriptionConverter())();
  TextColumn get imagePath => text().map(const TipImagePathConverter())();
  TextColumn get imageDescription =>
      text().map(const TipImageDescriptionConverter())();
  TextColumn get userNote => text().map(const TipUserNoteConverter())();

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

class TipDescriptionConverter implements TypeConverter<TipDescription, String> {
  const TipDescriptionConverter();

  @override
  TipDescription fromSql(String fromDb) {
    return TipDescription(fromDb);
  }

  @override
  String toSql(TipDescription value) {
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

class TipUserNoteConverter implements TypeConverter<TipUserNote, String> {
  const TipUserNoteConverter();

  @override
  TipUserNote fromSql(String fromDb) {
    return TipUserNote(fromDb);
  }

  @override
  String toSql(TipUserNote value) {
    return value;
  }
}
