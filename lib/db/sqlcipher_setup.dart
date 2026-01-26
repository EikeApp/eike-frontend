import 'dart:io';
import 'package:sqlite3/open.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';

Future<void> setupSqlCipher() async {
  if (Platform.isAndroid) {
    await applyWorkaroundToOpenSqlCipherOnOldAndroidVersions();
    open.overrideFor(OperatingSystem.android, openCipherOnAndroid);
  }
}
