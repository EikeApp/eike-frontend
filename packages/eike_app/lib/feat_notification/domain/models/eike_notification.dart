enum EikeNotificationType {
  error,
  info,
}

class const EikeNotification({
  required final EikeNotificationType type,
  required final String title,
  required final String message,
}) {
  factory error(String message) =>
      EikeNotification(type: .error, title: 'Error', message: message);

  factory info(String message) =>
      EikeNotification(type: .info, title: 'Info', message: message);
}
