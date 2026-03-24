import 'package:data_database/eike_database.dart';
import 'package:feat_home/domain/repositories/home_repository.dart';

class TipsObserver {
  final HomeRepository repository;
  const TipsObserver(this.repository);

  Stream<List<TipEntity>> observe() {
    return repository.observeTips();
  }
}
