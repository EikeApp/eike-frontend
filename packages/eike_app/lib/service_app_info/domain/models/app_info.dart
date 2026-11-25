class const AppInfo({
  required final String version,
  required final String buildNumber,
}) {
  String get displayVersion {
    return buildNumber.isEmpty ? version : '$version ($buildNumber)';
  }
}
