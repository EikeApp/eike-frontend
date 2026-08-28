import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/feat_home/domain/repositories/home_repository.dart';

class TipsObserver {
  final HomeRepository repository;
  const TipsObserver(this.repository);

  Stream<List<TipEntity>> observe() {
    return repository.observeTips();
  }
}
