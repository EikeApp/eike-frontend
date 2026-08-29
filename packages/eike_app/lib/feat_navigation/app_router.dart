import 'package:eike_app/feat_contact/presentation/contact_screen.dart';
import 'package:eike_app/feat_home/presentation/home_screen.dart';
import 'package:eike_app/feat_imprint/presentation/imprint_screen.dart';
import 'package:eike_app/feat_licenses/presentation/licenses_screen.dart';
import 'package:eike_app/feat_navigation/eike_routes.dart';
import 'package:eike_app/feat_navigation/main_scaffold.dart';
import 'package:eike_app/feat_privacy_policy/presentation/privacy_policy_screen.dart';
import 'package:eike_app/feat_settings/presentation/settings_screen.dart';
import 'package:go_router/go_router.dart';

final eikeRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScaffold(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              name: EikeRoute.home.name,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/contact',
              name: EikeRoute.contact.name,
              builder: (context, state) => const ContactScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              name: EikeRoute.settings.name,
              builder: (context, state) => const SettingsScreen(),
              routes: [
                GoRoute(
                  path: 'privacy-policy',
                  name: EikeRoute.privacyPolicy.name,
                  builder: (context, state) => const PrivacyPolicyScreen(),
                ),
                GoRoute(
                  path: 'licenses',
                  name: EikeRoute.licenses.name,
                  builder: (context, state) => const LicensesScreen(),
                ),
                GoRoute(
                  path: 'imprint',
                  name: EikeRoute.imprint.name,
                  builder: (context, state) => const ImprintScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
