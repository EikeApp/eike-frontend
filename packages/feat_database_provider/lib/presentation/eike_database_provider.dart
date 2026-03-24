import 'package:data_database/eike_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/eike_database_provider_bloc.dart';

import '../data/repositories/eike_database_provider_repository_impl.dart';

class EikeDatabaseProvider extends StatelessWidget {
  final Widget child;
  const EikeDatabaseProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return EikeDatabaseProviderBloc(
          EikeDatabaseProviderRepositoryImpl(
            RepositoryProvider.of(context),
            RepositoryProvider.of(context),
          ),
        )..add(const EikeDatabaseProviderEvent.onSetup());
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

class _Wrapper extends StatelessWidget {
  const _Wrapper({
    required this.state,
    required this.child,
  });

  final EikeDatabaseProviderState state;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (state.database case EikeDatabase database) {
      return RepositoryProvider.value(
        value: database,
        child: child,
      );
    } else if (state.isLoading) {
      return Scaffold(
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        body: const Center(
          child: Text(
            'Es ist ein Fehler beim öffnen der Datenbank aufgetreten.',
          ),
        ),
      );
    }
  }
}
