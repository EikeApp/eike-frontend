import 'package:feat_app_protection/data/repositories/app_protection_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:feat_app_protection/presentation/bloc/app_protection_bloc.dart';
import 'package:service_design/theming/eike_theme.dart';

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
        )..add(AppProtectionEvent.onSetup());
      },
      lazy: false,
      child: _AppLifecycleObserver(
        child: BlocBuilder<AppProtectionBloc, AppProtectionState>(
          builder: (context, state) {
            return state.map(
              initial: (state) => const _LoadingScreen(),
              unlocked: (state) => _UnlockedContent(builder: builder),
              locked: (state) => _LockScreen(
                isAuthenticating: state.isAuthenticating,
                errorMessage: state.errorText,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

/// Built only after authentication succeeds — app content with fade-in entrance.
class _UnlockedContent extends StatefulWidget {
  const _UnlockedContent({required this.builder});

  final WidgetBuilder builder;

  @override
  State<_UnlockedContent> createState() => _UnlockedContentState();
}

class _UnlockedContentState extends State<_UnlockedContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.builder(context),
    );
  }
}

/// Full-screen lock screen — no app content rendered at all.
class _LockScreen extends StatelessWidget {
  const _LockScreen({required this.isAuthenticating, this.errorMessage});

  final bool isAuthenticating;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EikeTheme.pagePadding,
        child: Column(
          children: [
            Expanded(child: SizedBox.shrink()),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_rounded,
                      size: 64,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'App gesperrt',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _BiometricPrompt(
                isAuthenticating: isAuthenticating,
                errorMessage: errorMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BiometricPrompt extends StatelessWidget {
  const _BiometricPrompt({
    required this.isAuthenticating,
    this.errorMessage,
  });

  final bool isAuthenticating;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: EikeTheme.verticalComponentSpacingMedium,
      children: [
        SizedBox.fromSize(
          size: Size.fromHeight(68.0),
          child: errorMessage != null
              ? Card.filled(
                  color: context.colors.errorContainer,
                  child: Padding(
                    padding: EikeTheme.cardPadding,
                    child: Text(
                      (errorMessage ?? '') * 2,
                      maxLines: 2,
                      style: TextStyle(color: context.colors.onErrorContainer),
                    ),
                  ),
                )
              : Container(),
        ),
        Column(
          spacing: EikeTheme.verticalComponentSpacingSmall,
          children: [
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      BlocProvider.of<AppProtectionBloc>(context).add(
                        const AppProtectionEvent.onAuthRequested(),
                      );
                    },
                    icon: const Icon(Icons.fingerprint_rounded),
                    label: const Text('Entsperren'),
                  ),
                ),
              ],
            ),
            Text("Verwende Biometrie oder deinen PIN"),
          ],
        ),
      ],
    );
  }
}

/// Observes app lifecycle to trigger locking when the app is sent to background.
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

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      BlocProvider.of<AppProtectionBloc>(context).add(
        const AppProtectionEvent.onAppPaused(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
