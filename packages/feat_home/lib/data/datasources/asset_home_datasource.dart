import 'package:feat_home/data/datasources/home_datasource.dart';
import 'package:feat_home/domain/models/tip.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class AssetHomeDatasource implements HomeDatasource {
  const AssetHomeDatasource();

  @override
  Future<List<Tip>> fetchTips() async {
    final contents = await rootBundle.loadString('assets/content/data.yaml');
    final rawYaml = loadYaml(contents);
    final yaml = _normalizeYaml(rawYaml) as Map<String, dynamic>;
    final yamlTips = yaml['data']['flyer']['tips'] as List<dynamic>;
    return yamlTips.cast<Map<String, dynamic>>().map(Tip.fromJson).toList();
  }
}

dynamic _normalizeYaml(dynamic node) {
  if (node is YamlMap) {
    return {
      for (final entry in node.entries)
        entry.key.toString(): _normalizeYaml(entry.value),
    };
  }

  if (node is YamlList) {
    return node.map(_normalizeYaml).toList();
  }

  return node;
}
