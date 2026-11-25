import 'package:eike_app/feat_notification/domain/repositories/notification_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EikeBloc<State, Event>(
  super.initialState,
  final NotificationRepository repository,
) extends Bloc<State, Event> {
  void submitError(Exception error) {
    repository.emitNotification(.error(error.toString()));
  }
}
