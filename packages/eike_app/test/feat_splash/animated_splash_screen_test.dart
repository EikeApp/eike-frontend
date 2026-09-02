import 'package:eike_app/feat_splash/presentation/animated_splash_screen.dart';
import 'package:eike_app/feat_splash/presentation/bloc/splash_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(AnimatedSplashScreen, () {
    testWidgets(
      'should not overflow when the system font size is scaled up',
      (tester) async {
        // Default test surface is 800x600 - wider than tall, unlike a
        // phone. Use a realistic portrait size so this actually reflects
        // what users see.
        tester.view.physicalSize = const Size(390, 844);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(
          MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(3.0)),
            child: MaterialApp(
              home: AnimatedSplashScreen(app: const SizedBox.shrink()),
            ),
          ),
        );
        await tester.pump();

        expect(tester.takeException(), isNull);

        // SplashScreenBloc holds two real Timers (splash -> transition ->
        // ready) - run them to completion so none leak past this test.
        await tester.pump(
          SplashScreenBloc.splashDuration + SplashScreenBloc.transitionDuration,
        );
      },
    );
  });
}
