import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/data_entities/tables/tip_table.dart';
import 'package:eike_app/feat_tip_detail/data/daos/tip_detail_dao.dart';
import 'package:eike_app/feat_tip_detail/domain/repositories/tip_detail_repository.dart';

class TipDetailRepositoryImpl implements TipDetailRepository {
  final TipDetailDao dao;
  const TipDetailRepositoryImpl(this.dao);

  @override
  Stream<TipEntity?> observeTip(TipId tipId) {
    return dao.observeTip(tipId);
  }

  @override
  Future<void> updateUserNote(TipId tipId, TipUserNote userNote) {
    return dao.updateUserNote(tipId, userNote);
  }
}
