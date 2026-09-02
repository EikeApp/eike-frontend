import 'package:package_info_plus/package_info_plus.dart';

import 'package:eike_app/service_app_info/domain/models/app_info.dart';
import 'package:eike_app/service_app_info/domain/repositories/app_info_repository.dart';

class AppInfoRepositoryImpl implements AppInfoRepository {
  @override
  Future<AppInfo> getAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return AppInfo(
      version: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
    );
  }
}
