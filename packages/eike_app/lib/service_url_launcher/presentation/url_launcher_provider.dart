import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eike_app/service_url_launcher/data/repositories/url_launcher_repository_impl.dart';
import 'package:eike_app/service_url_launcher/presentation/bloc/url_launcher_bloc.dart';

class const UrlLauncherProvider({
  super.key,
  required final Widget child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return UrlLauncherBloc(
          UrlLauncherRepositoryImpl(),
          RepositoryProvider.of(context),
        );
      },
      lazy: false,
      child: child,
    );
  }
}
