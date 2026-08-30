import 'package:eike_app/feat_splash/presentation/bloc/splash_screen_bloc.dart';
import 'package:eike_app/service_design/theming/eike_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedSplashScreen extends StatelessWidget {
  const AnimatedSplashScreen({super.key, required this.app});

  final Widget app;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SplashScreenBloc()..add(const SplashScreenEvent.onSetup());
      },
      child: BlocBuilder<SplashScreenBloc, SplashScreenState>(
        builder: (context, state) {
          final (appChild, target, appInteractive) = state.map(
            splash: (_) => (const SizedBox.shrink(), 0.0, false),
            transitioning: (_) => (app, 1.0, false),
            ready: (_) => (app, 1.0, true),
          );

          return Stack(
            children: [
              IgnorePointer(
                ignoring: !appInteractive,
                child: appChild
                    .animate(target: target)
                    .slideX(
                      duration: SplashScreenBloc.transitionDuration,
                      begin: 1.0,
                      end: 0.0,
                      curve: Curves.easeInOutCubic,
                    ),
              ),
              const _SplashContent()
                  .animate(target: target)
                  .slideX(
                    duration: SplashScreenBloc.transitionDuration,
                    begin: 0.0,
                    end: -1.0,
                    curve: Curves.easeInOutCubic,
                  ),
            ],
          );
        },
      ),
    );
  }
}

class _SplashContent extends StatelessWidget {
  const _SplashContent();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: EikeTheme.lightTheme(context),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: context.colors.primary,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EikeTheme.pagePadding,
                    child:
                        Column(
                          children: [
                            Text(
                              "EIKE",
                              style: context.textTheme.displayLarge?.copyWith(
                                color: context.colors.onPrimary,
                                fontWeight: .bold,
                              ),
                            ),
                            Text(
                              "Hilfe für Helfer",
                              style: context.textTheme.headlineMedium?.copyWith(
                                color: context.colors.onPrimary,
                              ),
                            ),
                          ],
                        ).animate().fadeIn(
                          delay: const Duration(milliseconds: 1200),
                          duration: const Duration(milliseconds: 500),
                        ),
                  ),
                  Image.asset(
                        'assets/images/splash_screen_logo.png',
                        width: 400,
                        height: 400,
                      )
                      .animate()
                      .scale(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInOutBack,
                        alignment: .center,
                      )
                      .fadeIn(duration: const Duration(milliseconds: 100)),
                  Padding(
                    padding: EikeTheme.pagePadding,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/splash_screen_footer.png',
                          ).animate().fadeIn(
                            delay: const Duration(milliseconds: 1200),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOutCubic,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
