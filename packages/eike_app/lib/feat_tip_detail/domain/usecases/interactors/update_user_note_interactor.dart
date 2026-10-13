import 'dart:async';

import 'package:eike_app/data_entities/tables/tip_table.dart';
import 'package:eike_app/feat_tip_detail/domain/repositories/tip_detail_repository.dart';
import 'package:use_in_case/use_in_case.dart';

typedef UpdateUserNoteInput = ({
  TipId tipId,
  TipUserNote userNote,
});

class UpdateUserNoteInteractor
    implements ParameterizedInteractor<UpdateUserNoteInput> {
  final TipDetailRepository repository;
  const UpdateUserNoteInteractor(this.repository);

  @override
  FutureOr<void> getOrThrow(UpdateUserNoteInput input) {
    return repository.updateUserNote(input.tipId, input.userNote);
  }
}
