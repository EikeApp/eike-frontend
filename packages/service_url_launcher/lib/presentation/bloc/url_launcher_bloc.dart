import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:service_logging/logging_interactor.dart';
import 'package:service_url_launcher/domain/repositories/url_launcher_repository.dart';
import 'package:service_url_launcher/domain/usecases/launch_url_interactor.dart';
import 'package:use_in_case/use_in_case.dart';

part 'url_launcher_bloc.freezed.dart';
part 'url_launcher_event.dart';
part 'url_launcher_state.dart';

class UrlLauncherBloc extends Bloc<UrlLauncherEvent, UrlLauncherState> {
  final LaunchUrlInteractor launchUrl;

  UrlLauncherBloc(UrlLauncherRepository repository)
    : launchUrl = LaunchUrlInteractor(repository),
      super(UrlLauncherState.initial()) {
    on<_OnSetup>(_onSetup);
    on<_OnLaunchUrl>(_onLaunchUrl);
  }

  FutureOr<void> _onSetup(_OnSetup event, Emitter<UrlLauncherState> emit) {}

  FutureOr<void> _onLaunchUrl(
    _OnLaunchUrl event,
    Emitter<UrlLauncherState> emit,
  ) {
    return launchUrl.logger().run(event.url);
  }
}
