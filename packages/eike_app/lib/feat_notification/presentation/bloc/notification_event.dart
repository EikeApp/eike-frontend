part of 'notification_bloc.dart';

@freezed
sealed class NotificationEvent with _$NotificationEvent {
  const factory onSetup() = _OnSetup;
  const factory onCloseNotifications() = _OnCloseNotifications;
  const factory onShowPreviousNotification() = _OnShowPreviousNotification;
  const factory onShowNextNotification() = _OnShowNextNotification;
}

@freezed
sealed class NotificationPresentationEvent
    with _$NotificationPresentationEvent {
  const factory onShowNotification() = _OnShowNotification;
}
