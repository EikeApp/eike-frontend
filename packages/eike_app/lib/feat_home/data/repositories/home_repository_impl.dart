import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/data_entities/tables/tip_table.dart';
import 'package:eike_app/feat_home/data/daos/home_dao.dart';
import 'package:eike_app/feat_home/data/datasources/home_datasource.dart';
import 'package:eike_app/feat_home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDao dao;
  final HomeDatasource datasource;
  const HomeRepositoryImpl(this.dao, this.datasource);

  @override
  Future<void> syncTips() async {
    final tipDtos = await datasource.fetchTips();
    return dao.insert(tipDtos);
  }

  @override
  Stream<List<TipEntity>> observeTips() {
    return dao.observeTips();
  }

  @override
  Future<void> updateUserNote(TipId tipId, TipUserNote userNote) {
    return dao.updateUserNote(tipId, userNote);
  }
}
