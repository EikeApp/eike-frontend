class AppInfo {
  const AppInfo({
    required this.version,
    required this.buildNumber,
  });

  final String version;
  final String buildNumber;

  /// Human-readable version string for display, e.g. in bug reports.
  ///
  /// Falls back to just the version if no build number is set (e.g. in
  /// local debug builds, where `pubspec.yaml` has no `+<buildNumber>` and
  /// CI doesn't pass `--build-number`).
  String get displayVersion =>
      buildNumber.isEmpty ? version : '$version ($buildNumber)';
}
