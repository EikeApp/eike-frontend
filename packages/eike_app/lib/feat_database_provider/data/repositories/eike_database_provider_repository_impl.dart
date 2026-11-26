import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:drift/native.dart';
import 'package:eike_app/data_database/eike_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:eike_app/service_logging/eike_logger.dart';

import '../../domain/repositories/eike_database_provider_repository.dart';

extension type _DatabaseEncryptionKey(String value) implements String {
  static final _random = Random.secure();
  static const _keyLength = 32;

  static _DatabaseEncryptionKey generate() {
    final randomBytes = List.generate(_keyLength, (_) => _random.nextInt(256));
    final key = base64Encode(randomBytes);
    return _DatabaseEncryptionKey(key);
  }

  static _DatabaseEncryptionKey? fromNullable(
    String? value,
    EikeLogger logger,
  ) {
    if (value == null) {
      return null;
    }

    return _DatabaseEncryptionKey(value);
  }
}

class MissingCipherSupportException implements Exception {
  const MissingCipherSupportException();

  @override
  String toString() =>
      'The bundled SQLite build does not support encryption. Check that the '
      '`hooks.user_defines.sqlite3.source: sqlite3mc` entry in pubspec.yaml is '
      'present and that the build hook ran.';
}

class EikeDatabaseProviderRepositoryImpl
    implements EikeDatabaseProviderRepository {
  static final _databaseKeyId = 'db_sqlcipher_key_v1';
  static const _databaseFileName = 'app.sqlite';

  const EikeDatabaseProviderRepositoryImpl(this.storage, this.logger);

  final EikeLogger logger;
  final FlutterSecureStorage storage;

  @override
  Future<EikeDatabase> getDatabaseInstance() async {
    var encryptionKey = await _getExistingKey();
    encryptionKey ??= await _getNewKey();
    final file = await _resolveDatabaseFile();
    return _openDatabase(file, encryptionKey);
  }

  Future<_DatabaseEncryptionKey?> _getExistingKey() async {
    final encryptionKey = await storage.read(key: _databaseKeyId);
    return _DatabaseEncryptionKey.fromNullable(encryptionKey, logger);
  }

  Future<_DatabaseEncryptionKey> _getNewKey() async {
    final encryptionKey = _DatabaseEncryptionKey.generate();
    await storage.write(key: _databaseKeyId, value: encryptionKey);
    return encryptionKey;
  }

  Future<File> _resolveDatabaseFile() async {
    final directory = await getApplicationSupportDirectory();
    await directory.create(recursive: true);
    return File(p.join(directory.path, _databaseFileName));
  }

  EikeDatabase _openDatabase(
    File file,
    _DatabaseEncryptionKey encryptionKey,
  ) {
    final key = encryptionKey.value;

    return EikeDatabase(
      NativeDatabase.createInBackground(
        file,
        logStatements: kDebugMode,
        setup: (rawDb) => _applyEncryption(rawDb, key),
      ),
    );
  }

  static void _applyEncryption(Database rawDb, String key) {
    if (rawDb.select('PRAGMA cipher;').isEmpty) {
      throw const MissingCipherSupportException();
    }

    rawDb.execute("PRAGMA key = '${_escapeSqlString(key)}';");
  }

  static String _escapeSqlString(String value) => value.replaceAll("'", "''");
}
