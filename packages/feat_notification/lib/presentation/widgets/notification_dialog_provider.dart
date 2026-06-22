import 'dart:async';

import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:feat_notification/data/repositories/notification_repository_impl.dart';
import 'package:feat_notification/domain/models/eike_notification.dart';
import 'package:feat_notification/domain/repositories/notification_repository.dart';
import 'package:feat_notification/presentation/bloc/notification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_design/theming/eike_theme.dart';

Future<void> _onShowNotificationDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (dialogContext) {
      return BlocProvider.value(
        value: BlocProvider.of<NotificationBloc>(context),
        child: BlocBuilder<NotificationBloc, NotificationState>(
          buildWhen: (prev, curr) => curr.notifications.isNotEmpty,
          builder: (context, state) {
            final currentNotification =
                state.notifications[state.currentNotificationIndex];

            return _Dialog(
              currentNotification: currentNotification,
              currentNotificationIndex: state.currentNotificationIndex,
              notificationCount: state.notifications.length,
              canScrollBackward: state.canScrollBackward,
              canScrollForward: state.canScrollForward,
            );
          },
        ),
      );
    },
  );
}

class NotificationDialogProvider extends StatelessWidget {
  final Widget child;

  const NotificationDialogProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<NotificationRepository>.value(
      value: NotificationRepositoryImpl(),
      child: BlocProvider(
        create: (context) =>
            NotificationBloc(RepositoryProvider.of(context))
              ..add(const NotificationEvent.onSetup()),
        lazy: false,
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            return BlocPresentationListener<
              NotificationBloc,
              NotificationPresentationEvent
            >(
              listener: (context, event) {
                event.when(
                  onShowNotification: () {
                    unawaited(
                      _onShowNotificationDialog(context).whenComplete(() {
                        if (context.mounted) {
                          BlocProvider.of<NotificationBloc>(context).add(
                            const NotificationEvent.onCloseNotifications(),
                          );
                        }
                      }),
                    );
                  },
                );
              },
              child: child,
            );
          },
        ),
      ),
    );
  }
}

class _Dialog extends StatelessWidget {
  final EikeNotification currentNotification;

  final int currentNotificationIndex;
  final int notificationCount;
  final bool canScrollBackward;
  final bool canScrollForward;
  const _Dialog({
    required this.currentNotification,
    required this.currentNotificationIndex,
    required this.notificationCount,
    required this.canScrollBackward,
    required this.canScrollForward,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        padding: EikeTheme.cardPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: EikeTheme.verticalComponentSpacingMedium,
          children: [
            Row(
              spacing: EikeTheme.horizontalComponentSpacingMedium,
              children: [
                Icon(
                  currentNotification.getIconData(),
                  color: currentNotification.getDisplayColor(context),
                  size: 32,
                ),
                Expanded(
                  child: Text(
                    currentNotification.getTitle(),
                    style: context.textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    BlocProvider.of<NotificationBloc>(context).add(
                      const NotificationEvent.onCloseNotifications(),
                    );
                  },
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            Divider(),
            Text(currentNotification.message),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: canScrollBackward
                      ? () {
                          BlocProvider.of<NotificationBloc>(context).add(
                            const NotificationEvent.onShowPreviousNotification(),
                          );
                        }
                      : null,
                  icon: const Icon(Icons.arrow_back_ios_rounded),
                ),
                Text(
                  '${currentNotificationIndex + 1} / $notificationCount',
                  style: context.textTheme.bodyLarge,
                ),
                IconButton(
                  onPressed: canScrollForward
                      ? () {
                          BlocProvider.of<NotificationBloc>(context).add(
                            const NotificationEvent.onShowNextNotification(),
                          );
                        }
                      : null,
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension on EikeNotification {
  Color getDisplayColor(BuildContext context) {
    return switch (type) {
      EikeNotificationType.error => context.colors.error,
      EikeNotificationType.info => context.colors.primary,
    };
  }

  IconData getIconData() {
    return switch (type) {
      EikeNotificationType.error => Icons.error,
      EikeNotificationType.info => Icons.info,
    };
  }

  String getTitle() {
    return switch (type) {
      EikeNotificationType.error => 'Fehler',
      EikeNotificationType.info => 'Info',
    };
  }
}
