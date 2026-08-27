import 'package:feat_notification/domain/models/eike_notification.dart';
import 'package:feat_notification/domain/repositories/notification_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EikeBloc<State, Event> extends Bloc<State, Event> {
  EikeBloc(
    super.initialState,
    this.repository,
  );
  final NotificationRepository repository;
  void submitError(Exception error) {
    repository.emitNotification(EikeNotification.error(error.toString()));
  }
}
