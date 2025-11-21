import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:yaml/yaml.dart';

const String repoOwner = 'EikeApp';
const String repoName = 'eike-content';
const String cacheDir = '.eike_cache';
const String targetDir = 'assets/content';

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
  String version = '';
  
  // Priority 1: Command line argument (make run VERSION=x)
  if (args.isNotEmpty && args[0].isNotEmpty) {
    version = args[0];
  } else {
    // Priority 2: pubspec.yaml
    final pubspecFile = File('pubspec.yaml');
    if (await pubspecFile.exists()) {
      try {
        final content = await pubspecFile.readAsString();
        final yaml = loadYaml(content);
        // Access eike -> content_version
        version = yaml['eike']?['content_version']?.toString() ?? '';
      } catch (e) {
        print('❌ Error parsing pubspec.yaml: $e');
        exit(1);
      }
    }

    if (version.isEmpty) {
      print('❌ Error: No version specified.');
      print('   Please provide a version via argument: make run VERSION=v1.0.0');
      print('   OR define it in pubspec.yaml under eike: content_version: ...');
      exit(1);
    }
  }

  print('📦 Managing content for version: $version');

  // 2. Check if content is already up-to-date
  // We check a marker file in the target directory to see if it matches the requested version
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
      // Pull Request Logic: pr-8 -> Pull Request #8
      final prNumber = version.split('-')[1];
      url = 'https://api.github.com/repos/$repoOwner/$repoName/zipball/pull/$prNumber/head';
    } else {
      // Tag/Release Logic: v1.0.0 or 0.1.0
      url = 'https://github.com/$repoOwner/$repoName/archive/refs/tags/$version.zip';
    }

    print('⬇️  Downloading from $url...');
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      await zipFile.writeAsBytes(response.bodyBytes);
      print('✅ Download complete.');
    } else {
      print('❌ Failed to download content. Status code: ${response.statusCode}');
      print('   URL: $url');
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
      // The zip usually contains a root folder (e.g. eike-content-0.1.0/file.txt)
      // We want to strip that root folder.
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

  // 6. Write version marker
  await currentVersionMarker.writeAsString(version);
  print('✅ Content ready for version $version');
}
