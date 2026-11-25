import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/eike_database_provider_bloc.dart';

import '../data/repositories/eike_database_provider_repository_impl.dart';

class const EikeDatabaseProvider({
  super.key,
  required final Widget child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return EikeDatabaseProviderBloc(
          EikeDatabaseProviderRepositoryImpl(
            RepositoryProvider.of(context),
            RepositoryProvider.of(context),
          ),
          RepositoryProvider.of(context),
        )..add(const .onSetup());
      },
      child: BlocBuilder<EikeDatabaseProviderBloc, EikeDatabaseProviderState>(
        builder: (context, state) {
          return _Wrapper(
            state: state,
            child: child,
          );
        },
      ),
    );
  }
}

class const _Wrapper({
  required final EikeDatabaseProviderState state,
  required final Widget child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return switch (state) {
      EikeDatabaseProviderState(:final database?) => RepositoryProvider.value(
        value: database,
        child: child,
      ),
      EikeDatabaseProviderState(isLoading: true) => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      _ => const Scaffold(
        body: Center(
          child: Text(
            'Es ist ein Fehler beim öffnen der Datenbank aufgetreten.',
          ),
        ),
      ),
    };
  }
}
