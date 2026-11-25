import '../../models/eike_notification.dart';
import '../../repositories/notification_repository.dart';

class const NotificationsObserver(final NotificationRepository repository) {
  Stream<EikeNotification> observe() {
    return repository.observeNotification();
  }
}
