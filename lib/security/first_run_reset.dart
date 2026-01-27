import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'app_lock_storage.dart';
import '../db/db_key_manager.dart';

class FirstRunReset {
  static const _installedMarker = 'installed_marker_v1';

  static Future<void> run() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstRun = !(prefs.getBool(_installedMarker) ?? false);

    if (!isFirstRun) return;

    // Marker setzen (ab jetzt nicht mehr "first run")
    await prefs.setBool(_installedMarker, true);

    const storage = FlutterSecureStorage();

    // App-Lock sicher deaktivieren
    await storage.delete(key: AppLockStorage.storageKey);

    // DB-Key ebenfalls löschen
    await storage.delete(key: DbKeyManager.storageKey);
  }
}
