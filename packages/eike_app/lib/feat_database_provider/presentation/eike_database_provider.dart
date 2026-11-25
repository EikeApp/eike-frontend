import 'package:eike_app/data_database/eike_database.dart';
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
    if (state.database case EikeDatabase database) {
      return RepositoryProvider.value(
        value: database,
        child: child,
      );
    } else if (state.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: Text(
            'Es ist ein Fehler beim öffnen der Datenbank aufgetreten.',
          ),
        ),
      );
    }
  }
}
