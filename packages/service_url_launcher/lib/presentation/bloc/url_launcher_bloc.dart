import 'dart:async';

import 'package:feat_notification/domain/repositories/notification_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:service_bloc/contracts/eike_bloc.dart';
import 'package:service_logging/logging_interactor.dart';
import 'package:service_url_launcher/domain/repositories/url_launcher_repository.dart';
import 'package:service_url_launcher/domain/usecases/launch_url_interactor.dart';
import 'package:use_in_case/use_in_case.dart';

part 'url_launcher_bloc.freezed.dart';
part 'url_launcher_event.dart';
part 'url_launcher_state.dart';

class UrlLauncherBloc extends EikeBloc<UrlLauncherEvent, UrlLauncherState> {
  final LaunchUrlInteractor launchUrl;

  UrlLauncherBloc(
    UrlLauncherRepository repository,
    NotificationRepository notificationRepository,
  ) : launchUrl = LaunchUrlInteractor(repository),
      super(
        UrlLauncherState.initial(),
        notificationRepository,
      ) {
    on<_OnSetup>(_onSetup);
    on<_OnLaunchUrl>(_onLaunchUrl);
  }

  FutureOr<void> _onSetup(_OnSetup event, Emitter<UrlLauncherState> emit) {}

  FutureOr<void> _onLaunchUrl(
    _OnLaunchUrl event,
    Emitter<UrlLauncherState> emit,
  ) {
    return launchUrl.logger().intercept(submitError).run(event.url);
  }
}
