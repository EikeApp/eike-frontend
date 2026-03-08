import 'dart:convert';
import 'dart:math';

import 'package:data_database/eike_database.dart';
import 'package:encrypted_drift/encrypted_drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/repositories/eike_database_provider_repository.dart';

extension type _DatabaseEncryptionKey(String value) implements String {
  static final _random = Random.secure();
  static const _keyLength = 32;

  static _DatabaseEncryptionKey generate() {
    final randomBytes = List.generate(_keyLength, (_) => _random.nextInt(256));
    final key = base64Encode(randomBytes);
    return _DatabaseEncryptionKey(key);
  }

  static _DatabaseEncryptionKey? fromNullable(String? value) {
    if (value == null) {
      return null;
    }

    return _DatabaseEncryptionKey(value);
  }
}

class EikeDatabaseProviderRepositoryImpl
    implements EikeDatabaseProviderRepository {
  static final _databaseKeyId = 'db_sqlcipher_key_v1';

  const EikeDatabaseProviderRepositoryImpl(this.storage);

  final FlutterSecureStorage storage;

  @override
  Future<EikeDatabase> getDatabaseInstance() async {
    final encryptionKey = await storage
        .read(key: _databaseKeyId)
        .then((key) => _DatabaseEncryptionKey.fromNullable(key))
        .then((key) => key ?? _DatabaseEncryptionKey.generate());

    print('Key: $encryptionKey');

    return _openDatabase(encryptionKey);
  }

  Future<EikeDatabase> _openDatabase(
    _DatabaseEncryptionKey encryptionKey,
  ) async {
    return EikeDatabase(
      EncryptedExecutor.inDatabaseFolder(
        path: 'app.sqlite',
        password: encryptionKey,
        logStatements: kDebugMode,
      ),
    );
  }
}
