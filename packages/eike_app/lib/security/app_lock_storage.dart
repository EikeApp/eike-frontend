import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppLockStorage {
  static const storageKey = 'app_lock_enabled_v1';
  final FlutterSecureStorage storage;

  const AppLockStorage(this.storage);

  Future<bool> readEnabled() async =>
      (await storage.read(key: storageKey)) == '1';
  Future<void> writeEnabled(bool v) async =>
      storage.write(key: storageKey, value: v ? '1' : '0');
}
