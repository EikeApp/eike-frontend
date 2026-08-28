import 'dart:async';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:eike_app/feat_notification/domain/usecases/interactors/close_notification_stream_interactor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:eike_app/service_logging/logging_interactor.dart';
import 'package:use_in_case/use_in_case.dart';

import '../../domain/models/eike_notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../../domain/usecases/observers/notifications_observer.dart';

part 'notification_bloc.freezed.dart';
part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState>
    with
        BlocPresentationMixin<
          NotificationState,
          NotificationPresentationEvent
        > {
  final NotificationsObserver observer;
  final CloseNotificationStreamInteractor closeStream;

  NotificationBloc(NotificationRepository repository)
    : observer = NotificationsObserver(repository),
      closeStream = CloseNotificationStreamInteractor(repository),
      super(NotificationState.initial()) {
    on<_OnSetup>(_onSetup);
    on<_OnCloseNotifications>(_onCloseNotifications, transformer: droppable());
    on<_OnShowPreviousNotification>(
      _onShowPreviousNotification,
      transformer: sequential(),
    );
    on<_OnShowNextNotification>(
      _onShowNextNotification,
      transformer: sequential(),
    );
  }

  @override
  Future<void> close() async {
    await closeStream.logger().run(unit);
    await super.close();
  }

  FutureOr<void> _onSetup(_OnSetup event, Emitter<NotificationState> emit) {
    return emit.onEach(
      observer.observe(),
      onData: (notification) {
        final isFirstNotification = state.notifications.isEmpty;

        emit(
          state.copyWith(
            notifications: [...state.notifications, notification],
          ),
        );

        if (isFirstNotification) {
          emitPresentation(NotificationPresentationEvent.onShowNotification());
        }
      },
    );
  }

  FutureOr<void> _onCloseNotifications(
    _OnCloseNotifications event,
    Emitter<NotificationState> emit,
  ) {
    emit(
      state.copyWith(
        notifications: [],
        currentNotificationIndex: 0,
      ),
    );
  }

  FutureOr<void> _onShowPreviousNotification(
    _OnShowPreviousNotification event,
    Emitter<NotificationState> emit,
  ) {
    emit(
      state.copyWith(
        currentNotificationIndex: max(state.currentNotificationIndex - 1, 0),
      ),
    );
  }

  FutureOr<void> _onShowNextNotification(
    _OnShowNextNotification event,
    Emitter<NotificationState> emit,
  ) {
    emit(
      state.copyWith(
        currentNotificationIndex: min(
          state.currentNotificationIndex + 1,
          state.notifications.length,
        ),
      ),
    );
  }
}
