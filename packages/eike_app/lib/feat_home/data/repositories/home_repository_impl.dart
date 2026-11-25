import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/feat_home/data/daos/home_dao.dart';
import 'package:eike_app/feat_home/data/datasources/home_datasource.dart';
import 'package:eike_app/feat_home/domain/repositories/home_repository.dart';

class const HomeRepositoryImpl(
  final HomeDao dao,
  final HomeDatasource datasource,
) implements HomeRepository {
  @override
  Future<void> syncTips() async {
    final tipDtos = await datasource.fetchTips();
    return dao.insert(tipDtos);
  }

  @override
  Stream<List<TipEntity>> observeTips() {
    return dao.observeTips();
  }
}
