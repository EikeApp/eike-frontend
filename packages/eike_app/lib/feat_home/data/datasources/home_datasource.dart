import 'package:eike_app/feat_home/domain/models/tip.dart';

abstract interface class HomeDatasource {
  Future<List<Tip>> fetchTips();
}
