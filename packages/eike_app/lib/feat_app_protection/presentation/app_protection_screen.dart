import 'package:eike_app/feat_app_protection/data/repositories/app_protection_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eike_app/feat_app_protection/presentation/bloc/app_protection_bloc.dart';
import 'package:eike_app/service_design/components/eike_app_bar.dart';

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
            RepositoryProvider.of(context),
          ),
          RepositoryProvider.of(context),
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
    final isUnlocked = state.maybeMap(
      unlocked: (_) => true,
      orElse: () => false,
    );

    return Stack(
      children: [
        builder(context),
        IgnorePointer(
          ignoring: isUnlocked,
          child: _LockOverlay(state: state, isUnlocked: isUnlocked),
        ),
      ],
    );
  }
}

class _LockOverlay extends StatelessWidget {
  const _LockOverlay({
    required this.state,
    required this.isUnlocked,
  });

  static const transitionDuration = Duration(milliseconds: 420);

  final AppProtectionState state;
  final bool isUnlocked;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: state.map(
            initial: (_) => const _AuthenticatingScreen(),
            locked: (_) => const _LockedScreen(),
            unlocked: (_) => const _LockedScreen(),
          ),
        )
        .animate(target: isUnlocked ? 1.0 : 0.0)
        .slideY(
          duration: transitionDuration,
          begin: 0.0,
          end: -1.0,
          curve: Curves.easeInOutCubic,
        )
        .fadeOut(
          duration: transitionDuration,
          curve: Curves.easeInOutCubic,
        );
  }
}

class _AuthenticatingScreen extends StatelessWidget {
  const _AuthenticatingScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EikeAppBar(title: 'Authentifiziere...'),
    );
  }
}

class _LockedScreen extends StatelessWidget {
  const _LockedScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EikeAppBar(title: 'Entsperren Sie die App'),
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
