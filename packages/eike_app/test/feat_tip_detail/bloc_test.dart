import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/data_entities/tables/tip_table.dart';
import 'package:eike_app/feat_notification/domain/models/eike_notification.dart';
import 'package:eike_app/feat_notification/domain/repositories/notification_repository.dart';
import 'package:eike_app/feat_tip_detail/domain/repositories/tip_detail_repository.dart';
import 'package:eike_app/feat_tip_detail/presentation/bloc/tip_detail_bloc.dart';
import 'package:test/test.dart';

class _FakeTipDetailRepository implements TipDetailRepository {
  final _controller = StreamController<TipEntity?>.broadcast();
  final observedTipIds = <TipId>[];
  final updateCalls = <(TipId, TipUserNote)>[];

  void emit(TipEntity? entity) => _controller.add(entity);

  @override
  Stream<TipEntity?> observeTip(TipId tipId) {
    observedTipIds.add(tipId);
    return _controller.stream;
  }

  @override
  Future<void> updateUserNote(TipId tipId, TipUserNote userNote) async {
    updateCalls.add((tipId, userNote));
  }
}

class _FakeNotificationRepository implements NotificationRepository {
  @override
  Future<void> closeStream() async {}

  @override
  void emitNotification(EikeNotification notification) {}

  @override
  Stream<EikeNotification> observeNotification() => const Stream.empty();
}

void main() {
  group(TipDetailBloc, () {
    const tipId = TipId(3);
    late _FakeTipDetailRepository repository;

    setUp(() {
      repository = _FakeTipDetailRepository();
    });

    TipDetailBloc buildBloc() {
      return TipDetailBloc(tipId, repository, _FakeNotificationRepository());
    }

    final tip = TipEntity(
      id: tipId,
      position: TipPosition(4),
      title: TipTitle('Title'),
      description: TipDescription('Description'),
      question: TipQuestion('Question'),
      imagePath: TipImagePath('ImgPath'),
      imageDescription: TipImageDescription('Alt'),
      userNote: TipUserNote(''),
    );

    blocTest<TipDetailBloc, TipDetailState>(
      'should reflect the tip observed from the repository',
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const TipDetailEvent.onSetup());
        // Let the emit.forEach subscription in _onSetup actually attach
        // before pushing through the repository stream.
        await Future<void>.delayed(Duration.zero);
        repository.emit(tip);
      },
      expect: () => [TipDetailState(tip: tip, isLoading: false)],
      verify: (_) => expect(repository.observedTipIds, equals([tipId])),
    );

    blocTest<TipDetailBloc, TipDetailState>(
      'should stop loading when the tip does not exist',
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const TipDetailEvent.onSetup());
        await Future<void>.delayed(Duration.zero);
        repository.emit(null);
      },
      expect: () => [const TipDetailState(tip: null, isLoading: false)],
    );

    blocTest<TipDetailBloc, TipDetailState>(
      'should store every user note change in order',
      build: buildBloc,
      act: (bloc) => bloc
        ..add(const TipDetailEvent.onUserNoteChanged(TipUserNote('J')))
        ..add(const TipDetailEvent.onUserNoteChanged(TipUserNote('Jo')))
        ..add(const TipDetailEvent.onUserNoteChanged(TipUserNote('Jog'))),
      expect: () => [],
      verify: (_) => expect(
        repository.updateCalls,
        equals([
          (tipId, const TipUserNote('J')),
          (tipId, const TipUserNote('Jo')),
          (tipId, const TipUserNote('Jog')),
        ]),
      ),
    );
  });
}
