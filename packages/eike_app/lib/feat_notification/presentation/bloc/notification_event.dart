part of 'notification_bloc.dart';

@freezed
sealed class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent.onSetup() = _OnSetup;
  const factory NotificationEvent.onCloseNotifications() =
      _OnCloseNotifications;
  const factory NotificationEvent.onShowPreviousNotification() =
      _OnShowPreviousNotification;
  const factory NotificationEvent.onShowNextNotification() =
      _OnShowNextNotification;
}

@freezed
sealed class NotificationPresentationEvent
    with _$NotificationPresentationEvent {
  const factory NotificationPresentationEvent.onShowNotification() =
      _OnShowNotification;
}
