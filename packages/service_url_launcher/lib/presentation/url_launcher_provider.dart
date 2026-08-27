import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_url_launcher/data/repositories/url_launcher_repository_impl.dart';
import 'package:service_url_launcher/presentation/bloc/url_launcher_bloc.dart';

class UrlLauncherProvider extends StatelessWidget {
  const UrlLauncherProvider({super.key, required this.child});
  final Widget child;

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
