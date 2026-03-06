import 'package:feat_app_protection/data/repositories/app_protection_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:feat_app_protection/presentation/bloc/app_protection_bloc.dart';
import 'package:local_auth/local_auth.dart';

class AppProtectionScreen extends StatelessWidget {
  const AppProtectionScreen({super.key, required this.builder});

  final Widget Function(BuildContext) builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AppProtectionBloc(
          AppProtectionRepositoryImpl(
            RepositoryProvider.of(context),
            LocalAuthentication(),
          ),
          RepositoryProvider.of(context),
        )..add(AppProtectionEvent.onSetup());
      },
      lazy: false,
      child: Builder(
        builder: (context) {
          return _AppLifecycleObserver(
            child: BlocBuilder<AppProtectionBloc, AppProtectionState>(
              builder: (context, state) {
                return _LockScreen(
                  state: state,
                  builder: builder,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _LockScreen extends StatelessWidget {
  const _LockScreen({
    required this.state,
    required this.builder,
  });

  final AppProtectionState state;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 270),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: state.map(
        initial: (_) => Scaffold(
          appBar: AppBar(
            title: Text('Authentifiziere...'),
          ),
        ),
        unlocked: (_) => builder(context),
        locked: (_) => const _LockedScreen(),
      ),
    );
  }
}

class _LockedScreen extends StatelessWidget {
  const _LockedScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Entsperren Sie die App')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: FilledButton.icon(
              onPressed: () {
                BlocProvider.of<AppProtectionBloc>(context).add(
                  AppProtectionEvent.onAuthRequested(),
                );
              },
              icon: Icon(Icons.fingerprint_rounded),
              label: Text('Entsperren'),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppLifecycleObserver extends StatefulWidget {
  const _AppLifecycleObserver({required this.child});

  final Widget child;

  @override
  State<_AppLifecycleObserver> createState() => __AppLifecycleObserverState();
}

class __AppLifecycleObserverState extends State<_AppLifecycleObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == .paused || state == .inactive) {
      BlocProvider.of<AppProtectionBloc>(context).add(
        AppProtectionEvent.onAppPaused(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
