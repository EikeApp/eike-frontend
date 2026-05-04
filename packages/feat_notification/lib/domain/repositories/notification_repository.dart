import '../models/eike_notification.dart';

abstract interface class NotificationRepository {
  Future<void> closeStream();
  Future<void> emitNotification(EikeNotification notification);
  Stream<EikeNotification> observeNotification();
}
