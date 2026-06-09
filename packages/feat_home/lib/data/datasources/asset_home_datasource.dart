import 'dart:convert';

import 'package:feat_home/data/datasources/home_datasource.dart';
import 'package:feat_home/domain/models/tip.dart';
import 'package:flutter/services.dart';

class AssetHomeDatasource implements HomeDatasource {
  const AssetHomeDatasource();

  @override
  Future<List<Tip>> fetchTips() async {
    final jsonString = await rootBundle.loadString('assets/content/data.yaml');
    final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
    final tips = (jsonData['data']?['flyer']?['tips'] as List?) ?? <dynamic>[];

    return [
      for (final tipJson in tips) Tip.fromJson(tipJson),
    ];
  }
}
