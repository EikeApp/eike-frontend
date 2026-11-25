import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:use_in_case/use_in_case.dart';

import 'package:eike_app/service_app_info/domain/models/app_info.dart';
import 'package:eike_app/service_app_info/domain/repositories/app_info_repository.dart';

class const GetAppInfoInteractor(final AppInfoRepository repository)
    implements ResultInteractor<AppInfo> {
  @override
  FutureOr<AppInfo> getOrThrow(Unit input) {
    return repository.getAppInfo();
  }
}
