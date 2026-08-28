import 'dart:async';

import '../../domain/models/eike_notification.dart';
import '../../domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final _controller = StreamController<EikeNotification>();

  @override
  Future<void> closeStream() {
    return _controller.close();
  }

  @override
  void emitNotification(EikeNotification notification) async {
    _controller.add(notification);
  }

  @override
  Stream<EikeNotification> observeNotification() {
    return _controller.stream;
  }
}
