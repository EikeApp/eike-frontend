part of 'notification_bloc.dart';

@freezed
sealed class NotificationState with _$NotificationState {
  const factory NotificationState({
    required List<EikeNotification> notifications,
    required int currentNotificationIndex,
  }) = _NotificationState;

  factory NotificationState.initial() {
    return const NotificationState(
      notifications: [],
      currentNotificationIndex: 0,
    );
  }
}

extension GetButtonAvailability on NotificationState {
  bool get canScrollForward =>
      currentNotificationIndex < notifications.length - 1;
  bool get canScrollBackward => currentNotificationIndex > 0;
}
