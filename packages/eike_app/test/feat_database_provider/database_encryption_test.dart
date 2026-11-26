import 'dart:io';
import 'dart:typed_data';

import 'package:sqlite3/sqlite3.dart';
import 'package:test/test.dart';

/// The pragma applied by `EikeDatabaseProviderRepositoryImpl._applyEncryption`.
///
/// Kept as a literal copy rather than reaching into the private method, so that
/// this test fails if the production pragmas drift away from what is asserted
/// here.
void _unlock(Database db, String key) {
  db.execute("PRAGMA key = '$key';");
}

/// The bytes an unencrypted SQLite file starts with.
final _plaintextHeader = Uint8List.fromList('SQLite format 3\x00'.codeUnits);

void main() {
  late Directory tempDir;
  late String dbPath;

  const key = 'Z3JlZW4gaXMgbm90IGEgY3JlYXRpdmUgY29sb3VyIQ==';

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('eike_encryption_test');
    dbPath = '${tempDir.path}/app.sqlite';
  });

  tearDown(() => tempDir.deleteSync(recursive: true));

  test('the bundled sqlite build supports encryption', () {
    // Guards the `hooks.user_defines.sqlite3.source: sqlite3mc` entry in
    // pubspec.yaml. On a plain SQLite build `PRAGMA cipher` returns no rows and
    // `PRAGMA key` is a silent no-op, which would store user data in plaintext.
    final db = sqlite3.open(dbPath);
    addTearDown(db.close);

    expect(db.select('PRAGMA cipher;'), isNotEmpty);
  });

  test('data written with a key is readable with the same key', () {
    final db = sqlite3.open(dbPath);
    _unlock(db, key);
    db.execute('CREATE TABLE notes (body TEXT NOT NULL);');
    db.execute("INSERT INTO notes (body) VALUES ('a private note');");
    db.close();

    final reopened = sqlite3.open(dbPath);
    addTearDown(reopened.close);
    _unlock(reopened, key);

    expect(
      reopened.select('SELECT body FROM notes;').single['body'],
      'a private note',
    );
  });

  test('the database file on disk is actually encrypted', () {
    final db = sqlite3.open(dbPath);
    _unlock(db, key);
    db.execute('CREATE TABLE notes (body TEXT NOT NULL);');
    db.execute("INSERT INTO notes (body) VALUES ('a private note');");
    db.close();

    final bytes = File(dbPath).readAsBytesSync();

    expect(
      bytes.sublist(0, _plaintextHeader.length),
      isNot(_plaintextHeader),
      reason: 'file starts with the unencrypted SQLite header',
    );
    expect(
      String.fromCharCodes(bytes).contains('a private note'),
      isFalse,
      reason: 'the stored note is readable in the raw file',
    );
  });

  test('the wrong key cannot read the database', () {
    final db = sqlite3.open(dbPath);
    _unlock(db, key);
    db.execute('CREATE TABLE notes (body TEXT NOT NULL);');
    db.close();

    final reopened = sqlite3.open(dbPath);
    addTearDown(reopened.close);
    _unlock(reopened, 'd3Jvbmcga2V5');

    expect(
      () => reopened.select('SELECT * FROM notes;'),
      throwsA(isA<SqliteException>()),
    );
  });

  test('an unkeyed open cannot read the database', () {
    final db = sqlite3.open(dbPath);
    _unlock(db, key);
    db.execute('CREATE TABLE notes (body TEXT NOT NULL);');
    db.close();

    final reopened = sqlite3.open(dbPath);
    addTearDown(reopened.close);

    expect(
      () => reopened.select('SELECT * FROM notes;'),
      throwsA(isA<SqliteException>()),
    );
  });
}
