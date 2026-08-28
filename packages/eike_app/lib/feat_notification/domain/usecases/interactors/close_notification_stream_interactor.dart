import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:use_in_case/use_in_case.dart';

import '../../repositories/notification_repository.dart';

class CloseNotificationStreamInteractor implements Interactor {
  final NotificationRepository repository;
  const CloseNotificationStreamInteractor(this.repository);

  @override
  FutureOr<void> getOrThrow(Unit input) {
    return repository.closeStream();
  }
}
