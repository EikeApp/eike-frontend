// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:yaml/yaml.dart';
import 'package:path/path.dart' as path;

const String repoOwner = 'EikeApp';
const String repoName = 'eike-content';
const String cacheDir = '.eike_cache';
const String targetDir = 'assets/content';

// Allowed extensions for media files to keep
const Set<String> allowedExtensions = {
  // Images
  '.jpg',
  '.jpeg',
  '.png',
  '.gif',
  '.webp',
  '.svg',
  // Audio
  '.mp3',
  '.wav',
  '.m4a',
  // Video
  '.mp4',
  '.mov',
  // JSON data
  '.json',
};

void main(List<String> args) async {
  // Handle clean command
  if (args.isNotEmpty && args[0] == 'clean') {
    print('🧹 Cleaning content cache and assets...');
    final cache = Directory(cacheDir);
    final assets = Directory(targetDir);

    if (await cache.exists()) {
      await cache.delete(recursive: true);
      print('   Deleted $cacheDir');
    }
    if (await assets.exists()) {
      await assets.delete(recursive: true);
      print('   Deleted $targetDir');
    }
    print('✅ Clean complete.');
    return;
  }

  // 1. Determine Version
  if (args.isEmpty && args[0].isEmpty) {
    print('❌ Error: No version specified.');
    exit(1);
  }
  String version = args[0];

  print('📦 Managing content for version: $version');

  // 2. Check if content is already up-to-date
  final currentVersionMarker = File('$targetDir/.version');
  if (await currentVersionMarker.exists()) {
    final currentVersion = (await currentVersionMarker.readAsString()).trim();
    if (currentVersion == version) {
      print('✅ Content is already up to date ($version). Skipping.');
      return;
    }
  }

  // 3. Prepare Cache Directory
  final cacheDirectory = Directory(cacheDir);
  if (!await cacheDirectory.exists()) {
    await cacheDirectory.create();
  }

  final zipFileName = '$version.zip';
  final zipFile = File('${cacheDirectory.path}/$zipFileName');

  // 4. Download if not cached
  if (!await zipFile.exists()) {
    String url;
    if (version.startsWith('pr-')) {
      final prNumber = version.split('-')[1];
      url =
          'https://api.github.com/repos/$repoOwner/$repoName/zipball/pull/$prNumber/head';
    } else {
      url =
          'https://github.com/$repoOwner/$repoName/archive/refs/tags/$version.zip';
    }

    print('⬇️  Downloading from $url...');
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      await zipFile.writeAsBytes(response.bodyBytes);
      print('✅ Download complete.');
    } else {
      print(
        '❌ Failed to download content. Status code: ${response.statusCode}',
      );
      exit(1);
    }
  } else {
    print('♻️  Using cached version from ${zipFile.path}');
  }

  // 5. Clear old content and Extract
  print('📂 Extracting content...');
  final targetDirectory = Directory(targetDir);
  if (await targetDirectory.exists()) {
    await targetDirectory.delete(recursive: true);
  }
  await targetDirectory.create(recursive: true);

  final bytes = await zipFile.readAsBytes();
  final archive = ZipDecoder().decodeBytes(bytes);

  for (final file in archive) {
    if (file.isFile) {
      final filename = file.name;
      final parts = filename.split('/');
      if (parts.length > 1) {
        final relativePath = parts.sublist(1).join('/');
        if (relativePath.isEmpty) continue;

        final outFile = File('${targetDirectory.path}/$relativePath');
        await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content as List<int>);
      }
    }
  }

  // 6. Convert YAML to JSON
  print('🔄 Converting data.yaml to data.json...');
  final yamlFile = File('$targetDir/data.yaml');
  if (await yamlFile.exists()) {
    try {
      final yamlString = await yamlFile.readAsString();
      final yamlMap = loadYaml(yamlString);

      // Convert YamlMap/YamlList to standard Dart Map/List for JSON encoding
      final jsonMap = jsonDecode(jsonEncode(yamlMap));

      final jsonFile = File('$targetDir/data.json');
      await jsonFile.writeAsString(jsonEncode(jsonMap));
      print('   Converted data.yaml -> data.json');
    } catch (e) {
      print('❌ Error converting YAML to JSON: $e');
      // We don't exit here, maybe the rest of the assets are still useful
    }
  } else {
    print('⚠️  Warning: data.yaml not found in extracted content.');
  }

  // 7. Cleanup (Tree Shaking)
  print('🧹 Cleaning up unused files...');
  await _cleanupDirectory(targetDirectory);

  // 8. Write version marker
  await currentVersionMarker.writeAsString(version);
  print('✅ Content ready for version $version');
}

Future<void> _cleanupDirectory(Directory dir) async {
  final entities = dir.listSync(recursive: false);

  for (final entity in entities) {
    if (entity is File) {
      final ext = path.extension(entity.path).toLowerCase();
      // Keep .version file and allowed extensions
      if (path.basename(entity.path) != '.version' &&
          !allowedExtensions.contains(ext)) {
        await entity.delete();
        // print('   Deleted: ${path.basename(entity.path)}');
      }
    } else if (entity is Directory) {
      await _cleanupDirectory(entity);
      // If directory is empty after cleanup, delete it
      if (entity.listSync().isEmpty) {
        await entity.delete();
        // print('   Deleted empty dir: ${path.basename(entity.path)}');
      }
    }
  }
}
