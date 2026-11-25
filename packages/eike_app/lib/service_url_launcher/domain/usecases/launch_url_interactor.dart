import 'dart:async';

import 'package:eike_app/service_url_launcher/domain/repositories/url_launcher_repository.dart';
import 'package:use_in_case/use_in_case.dart';

class const LaunchUrlInteractor(final UrlLauncherRepository repository)
    implements ParameterizedResultInteractor<Uri, bool> {
  @override
  FutureOr<bool> getOrThrow(Uri input) {
    return repository.launch(input);
  }
}
