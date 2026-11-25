import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:use_in_case/use_in_case.dart';

import '../../repositories/notification_repository.dart';

class const CloseNotificationStreamInteractor(
  final NotificationRepository repository,
) implements Interactor {
  @override
  FutureOr<void> getOrThrow(Unit input) {
    return repository.closeStream();
  }
}
