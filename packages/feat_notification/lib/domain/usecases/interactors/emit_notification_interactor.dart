import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

import '../../models/eike_notification.dart';
import '../../repositories/notification_repository.dart';

class EmitNotificationInteractor
    implements ParameterizedInteractor<EikeNotification> {
  final NotificationRepository repository;
  const EmitNotificationInteractor(this.repository);

  @override
  FutureOr<void> getOrThrow(EikeNotification input) {
    return repository.emitNotification(input);
  }
}
