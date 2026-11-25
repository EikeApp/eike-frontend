import 'package:eike_app/feat_notification/data/repositories/notification_repository_impl.dart';
import 'package:eike_app/feat_notification/domain/models/eike_notification.dart';
import 'package:eike_app/feat_notification/domain/repositories/notification_repository.dart';
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
        const EikeNotification(
          type: .info,
          title: 'Test Notification (Info)',
          message: 'This is a info notification.',
        ),
      );

      repository.emitNotification(
        const EikeNotification(
          type: .error,
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
