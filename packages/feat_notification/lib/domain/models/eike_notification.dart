enum EikeNotificationType {
  error,
  info,
}

class EikeNotification {
  const EikeNotification({
    required this.type,
    required this.title,
    required this.message,
  });

  final EikeNotificationType type;
  final String title;
  final String message;

  factory EikeNotification.error(String message) => EikeNotification(
    type: .error,
    title: 'Error',
    message: message,
  );

  factory EikeNotification.info(String message) => EikeNotification(
    type: .info,
    title: 'Info',
    message: message,
  );
}
