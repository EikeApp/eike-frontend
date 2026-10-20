import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/data_entities/tables/tip_table.dart';
import 'package:eike_app/feat_tip_detail/domain/repositories/tip_detail_repository.dart';

class TipObserver {
  final TipDetailRepository repository;
  const TipObserver(this.repository);

  Stream<TipEntity?> observe(TipId tipId) {
    return repository.observeTip(tipId);
  }
}
