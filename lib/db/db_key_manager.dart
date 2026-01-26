import 'dart:convert';
import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DbKeyManager {
  static const _storageKey = 'db_sqlcipher_key_v1';
  final FlutterSecureStorage _storage;

  DbKeyManager(this._storage);

  Future<String> getOrCreateKey() async {
    final existing = await _storage.read(key: _storageKey);
    if (existing != null && existing.isNotEmpty) return existing;

    final bytes = List<int>.generate(32, (_) => Random.secure().nextInt(256));
    final key = base64UrlEncode(
      bytes,
    ); // enthält keine ' Zeichen → gut für PRAGMA key '...'
    await _storage.write(key: _storageKey, value: key);
    return key;
  }
}
