import '../../models/eike_notification.dart';
import '../../repositories/notification_repository.dart';

class NotificationsObserver {
  final NotificationRepository repository;
  const NotificationsObserver(this.repository);

  Stream<EikeNotification> observe() {
    return repository.observeNotification();
  }
}
