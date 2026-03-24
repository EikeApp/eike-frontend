import 'dart:async';

import 'package:data_entities/tables/tip_table.dart';
import 'package:feat_home/domain/repositories/home_repository.dart';
import 'package:use_in_case/use_in_case.dart';

typedef UpdateUserNoteInput = ({
  TipId tipId,
  TipUserNote userNote,
});

class UpdateUserNoteInteractor
    implements ParameterizedInteractor<UpdateUserNoteInput> {
  final HomeRepository repository;
  const UpdateUserNoteInteractor(this.repository);

  @override
  FutureOr<void> getOrThrow(UpdateUserNoteInput input) {
    return repository.updateUserNote(input.tipId, input.userNote);
  }
}
