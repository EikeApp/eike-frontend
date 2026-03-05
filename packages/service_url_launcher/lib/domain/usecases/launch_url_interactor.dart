import 'dart:async';

import 'package:service_url_launcher/domain/repositories/url_launcher_repository.dart';
import 'package:use_in_case/use_in_case.dart';

class LaunchUrlInteractor implements ParameterizedResultInteractor<Uri, bool> {
  final UrlLauncherRepository repository;
  const LaunchUrlInteractor(this.repository);

  @override
  FutureOr<bool> getOrThrow(Uri input) {
    return repository.launch(input);
  }
}
