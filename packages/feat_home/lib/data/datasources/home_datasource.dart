import 'package:feat_home/domain/models/tip.dart';

abstract interface class HomeDatasource {
  Future<List<Tip>> fetchTips();
}
