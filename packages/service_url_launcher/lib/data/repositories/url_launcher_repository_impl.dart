import 'package:service_url_launcher/domain/repositories/url_launcher_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherRepositoryImpl implements UrlLauncherRepository {
  @override
  Future<bool> launch(Uri uri) {
    return launchUrl(uri, mode: LaunchMode.platformDefault);
  }
}
