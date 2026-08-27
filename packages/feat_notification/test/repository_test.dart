import 'package:feat_notification/data/repositories/notification_repository_impl.dart';
import 'package:feat_notification/domain/models/eike_notification.dart';
import 'package:feat_notification/domain/repositories/notification_repository.dart';
import 'package:test/test.dart';

void main() {
  group(NotificationRepository, () {
    late NotificationRepository repository;

    setUp(() {
      repository = NotificationRepositoryImpl();
    });

    tearDown(() async {
      await repository.closeStream();
    });

    test('should return emitted notifications via observation', () {
      final stream = repository.observeNotification();

      repository.emitNotification(
        EikeNotification(
          type: EikeNotificationType.info,
          title: 'Test Notification (Info)',
          message: 'This is a info notification.',
        ),
      );

      repository.emitNotification(
        EikeNotification(
          type: EikeNotificationType.error,
          title: 'Test Notification (Error)',
          message: 'This is a error notification.',
        ),
      );

      expect(
        stream,
        emitsInOrder([
          isA<EikeNotification>()
              .having((n) => n.type, 'type', EikeNotificationType.info)
              .having((n) => n.title, 'title', 'Test Notification (Info)')
              .having(
                (n) => n.message,
                'message',
                'This is a info notification.',
              ),
          isA<EikeNotification>()
              .having((n) => n.type, 'type', EikeNotificationType.error)
              .having((n) => n.title, 'title', 'Test Notification (Error)')
              .having(
                (n) => n.message,
                'message',
                'This is a error notification.',
              ),
        ]),
      );
    });
  });
}
