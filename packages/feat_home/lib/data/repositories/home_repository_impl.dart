import 'package:data_database/eike_database.dart';
import 'package:data_entities/tables/tip_table.dart';
import 'package:feat_home/data/daos/home_dao.dart';
import 'package:feat_home/data/datasources/home_datasource.dart';
import 'package:feat_home/domain/models/tip.dart';
import 'package:feat_home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDao dao;
  final HomeDatasource datasource;
  const HomeRepositoryImpl(this.dao, this.datasource);

  @override
  Future<void> syncTips() async {
    final tipDtos = await datasource.fetchTips();
    final entities = tipDtos.map((dto) => dto.toEntity());
    return dao.insert(entities);
  }

  @override
  Stream<List<TipEntity>> observeTips() {
    return dao.observeTips();
  }
}

extension on Tip {
  TipEntity toEntity() {
    return TipEntity(
      id: TipId(id),
      title: TipTitle(title),
      note: TipNote(description),
      imagePath: TipImagePath(image.imagePath),
      imageDescription: TipImageDescription(image.alt),
    );
  }
}
