import 'package:eike_app/feat_splash/presentation/bloc/splash_screen_bloc.dart';
import 'package:eike_app/service_design/theming/eike_theme.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class const AnimatedSplashScreen({
  super.key,
  required final Widget app,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SplashScreenBloc()..add(const .onSetup());
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

class const _SplashContent() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.withNoTextScaling(
      child: Theme(
        data: EikeTheme.lightTheme(context),
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: context.colors.primary,
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Padding(
                      padding: EikeTheme.pagePadding,
                      child:
                          Text(
                            "EIKE",
                            style: context.textTheme.displayLarge?.copyWith(
                              color: context.colors.onPrimary,
                              fontWeight: .bold,
                            ),
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
                          mainAxisAlignment: .center,
                          children: [
                            const _PSNVLogo().animate().fadeIn(
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
      ),
    );
  }
}

class const _PSNVLogo() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EikeTheme.cardPadding,
        child: Row(
          spacing: EikeTheme.horizontalComponentSpacingMedium,
          children: [
            SvgPicture.asset(
              'assets/images/splash_screen_people.svg',
              width: 60,
              height: 60,
            ),
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  "PSNV",
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colors.onSurface,
                    fontWeight: .bold,
                  ),
                ),
                Text(
                  "Deutscher Fachverband",
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colors.onSurface,
                    fontWeight: .bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
