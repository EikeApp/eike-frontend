import 'dart:async';

import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:eike_app/feat_notification/data/repositories/notification_repository_impl.dart';
import 'package:eike_app/feat_notification/domain/models/eike_notification.dart';
import 'package:eike_app/feat_notification/domain/repositories/notification_repository.dart';
import 'package:eike_app/feat_notification/presentation/bloc/notification_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eike_app/service_design/theming/eike_theme.dart';

class const NotificationDialogProvider({
  super.key,
  required final Widget child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<NotificationRepository>(
      create: (context) => NotificationRepositoryImpl(),
      child: BlocProvider(
        create: (context) {
          return NotificationBloc(RepositoryProvider.of(context))
            ..add(const .onSetup());
        },
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
                            const .onCloseNotifications(),
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
              canScrollBackward: state.canScrollBackward,
              canScrollForward: state.canScrollForward,
            );
          },
        ),
      );
    },
  );
}

class const _Dialog({
  required final EikeNotification currentNotification,
  required final bool canScrollBackward,
  required final bool canScrollForward,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EikeTheme.cardPadding,
        child: Column(
          mainAxisSize: .min,
          spacing: EikeTheme.verticalComponentSpacingMedium,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    currentNotification.getIconData(),
                    color: currentNotification.getDisplayColor(context),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: CloseButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      BlocProvider.of<NotificationBloc>(context).add(
                        const .onCloseNotifications(),
                      );
                    },
                  ),
                ),
                Text(
                  currentNotification.title,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: .bold,
                  ),
                ),
              ],
            ),
            Text(currentNotification.message),
            Row(
              mainAxisAlignment: .end,
              spacing: EikeTheme.horizontalComponentSpacingMedium,
              children: [
                IconButton(
                  onPressed: canScrollBackward
                      ? () {
                          BlocProvider.of<NotificationBloc>(context).add(
                            const .onShowPreviousNotification(),
                          );
                        }
                      : null,
                  icon: const Icon(Icons.keyboard_arrow_left),
                ),
                IconButton(
                  onPressed: canScrollForward
                      ? () {
                          BlocProvider.of<NotificationBloc>(context).add(
                            const .onShowNextNotification(),
                          );
                        }
                      : null,
                  icon: const Icon(Icons.keyboard_arrow_right),
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
      .error => context.colors.error,
      .info => context.colors.primary,
    };
  }

  IconData getIconData() {
    return switch (type) {
      .error => Icons.error,
      .info => Icons.info,
    };
  }
}
