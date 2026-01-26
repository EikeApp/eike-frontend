import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables.dart';
import 'sqlcipher_setup.dart';
import 'db_key_manager.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [TeamContacts /*, ... deine anderen Tabellen */])
class AppDatabase extends _$AppDatabase {
  AppDatabase(DbKeyManager keyManager) : super(_openConnection(keyManager));

  @override
  int get schemaVersion => 1;

  // ---- TeamContacts API ----

  static const int _teamContactRowId = 1;

  Future<TeamContact?> getTeamContact() {
    return (select(
      teamContacts,
    )..where((t) => t.id.equals(_teamContactRowId))).getSingleOrNull();
  }

  Stream<TeamContact?> watchTeamContact() {
    return (select(
      teamContacts,
    )..where((t) => t.id.equals(_teamContactRowId))).watchSingleOrNull();
  }

  Future<void> upsertTeamContact({
    required String teamName,
    required String phone,
    required String email,
  }) async {
    await into(teamContacts).insertOnConflictUpdate(
      TeamContactsCompanion(
        id: const Value(_teamContactRowId),
        teamName: Value(teamName.trim()),
        phone: Value(phone.trim()),
        email: Value(email.trim()),
      ),
    );
  }

  Future<void> deleteTeamContact() async {
    await (delete(
      teamContacts,
    )..where((t) => t.id.equals(_teamContactRowId))).go();
  }

  /// Für euren "alle Daten löschen" Button:
  /// Falls ihr später weitere Tabellen habt, einfach ergänzen.
  Future<void> deleteAllData() async {
    await transaction(() async {
      await delete(teamContacts).go();
      // z.B. später:
      // await delete(otherTable).go();
    });
  }
}

LazyDatabase _openConnection(DbKeyManager keyManager) {
  return LazyDatabase(() async {
    // 1) Key im MAIN isolate holen/erzeugen (flutter_secure_storage nutzt Platform Channels)
    final key = await keyManager.getOrCreateKey();

    // 2) DB-Dateipfad
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'app.sqlite'));

    // 3) DB in Hintergrund-Isolate öffnen, aber dort SQLCipher-Setup ausführen!
    //    (sonst greift open.overrideFor(...) evtl. nicht im DB-Isolate)
    return NativeDatabase.createInBackground(
      file,
      isolateSetup:
          setupSqlCipher, // aus Drift-Changelog: isolateSetup für solche Fälle :contentReference[oaicite:3]{index=3}
      setup: (rawDb) {
        // Safety: sicherstellen, dass wirklich SQLCipher aktiv ist
        final cipher = rawDb.select('PRAGMA cipher_version;');
        assert(
          cipher.isNotEmpty,
          'SQLCipher not active (cipher_version empty)',
        );

        rawDb.execute("PRAGMA key = '$key';");

        // Drift empfiehlt das für SQLCipher / sqlite3-Konfig
        rawDb.config.doubleQuotedStringLiterals = false;
      },
    );
  });
}
