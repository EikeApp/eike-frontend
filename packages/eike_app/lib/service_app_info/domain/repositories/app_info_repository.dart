import 'package:eike_app/service_app_info/domain/models/app_info.dart';

abstract interface class AppInfoRepository {
  Future<AppInfo> getAppInfo();
}
