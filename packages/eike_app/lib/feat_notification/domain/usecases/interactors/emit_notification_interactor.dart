import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

import '../../models/eike_notification.dart';
import '../../repositories/notification_repository.dart';

class const EmitNotificationInteractor(
  final NotificationRepository repository,
) implements ParameterizedInteractor<EikeNotification> {
  @override
  FutureOr<void> getOrThrow(EikeNotification input) {
    repository.emitNotification(input);
  }
}
