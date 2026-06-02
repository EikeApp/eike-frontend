import 'dart:async';

import 'package:feat_navigation/eike_routes.dart';
import 'package:feat_settings/data/daos/settings_dao.dart';
import 'package:feat_settings/data/repositories/settings_repository_impl.dart';
import 'package:feat_settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_design/theming/eike_theme.dart';
import 'package:service_design/components/eike_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SettingsBloc(
          SettingsRepositoryImpl(
            SettingsDao(RepositoryProvider.of(context)),
            RepositoryProvider.of(context),
          ),
          RepositoryProvider.of(context),
        )..add(const SettingsEvent.onSetup());
      },
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return _Scaffold(state: state);
        },
      ),
    );
  }
}

class _Scaffold extends StatelessWidget {
  final SettingsState state;
  const _Scaffold({required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EikeAppBar(title: 'Einstellungen'),
      body: SingleChildScrollView(
        padding: EikeTheme.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: EikeTheme.verticalComponentSpacingLarge,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: EikeTheme.verticalComponentSpacingSmall,
              children: [
                Text(
                  'Datenschutz & Sicherung',
                  style: context.textTheme.headlineMedium,
                ),
                Card.outlined(
                  child: Padding(
                    padding: EikeTheme.cardPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 16,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.lock_outline_rounded),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('App-Sperre'),
                                  Text('Geräteeigene Authentifizierung'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Switch(
                          value: state.isAppLockEnabled,
                          onChanged: (isEnabled) {
                            BlocProvider.of<SettingsBloc>(context).add(
                              SettingsEvent.onSetIsAppLockEnabled(isEnabled),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: EikeTheme.verticalComponentSpacingSmall,
              children: [
                Text(
                  'Daten verwalten',
                  style: context.textTheme.headlineMedium,
                ),
                Card.outlined(
                  child: Padding(
                    padding: EikeTheme.cardPadding,
                    child: Column(
                      spacing: 16,
                      children: [
                        Text(
                          'Lösche alle gespeicherten Vorsätze und Einstellungen unwiederuflich',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FilledButton.icon(
                              onPressed: () {
                                BlocProvider.of<SettingsBloc>(context).add(
                                  const SettingsEvent.onCleanupLocalStorage(),
                                );
                              },
                              icon: Icon(Icons.delete_outlined),
                              label: Text('Alle Daten löschen'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: EikeTheme.verticalComponentSpacingSmall,
              children: [
                Text(
                  'Rechtliches',
                  style: context.textTheme.headlineMedium,
                ),
                Card.outlined(
                  child: Padding(
                    padding: EikeTheme.cardPadding,
                    child: Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informationen zum Umgang mit deinen Daten',
                        ),
                        TextButton.icon(
                          onPressed: () {
                            unawaited(
                              Navigator.of(context).pushNamed(
                                EikeRoute.privacyPolicy.route,
                              ),
                            );
                          },
                          icon: Icon(Icons.privacy_tip_outlined),
                          label: Text('Datenschutz'),
                        ),
                        Text(
                          'Open-Source-Bibliotheken, die diese App ermöglichen',
                        ),
                        TextButton.icon(
                          onPressed: () {
                            unawaited(
                              Navigator.of(context).pushNamed(
                                EikeRoute.licenses.route,
                              ),
                            );
                          },
                          icon: Icon(Icons.description_outlined),
                          label: Text('Lizenzen'),
                        ),
                        Text(
                          'Angaben zum Anbieter und Kontaktmöglichkeiten',
                        ),
                        TextButton.icon(
                          onPressed: () {
                            unawaited(
                              Navigator.of(context).pushNamed(
                                EikeRoute.imprint.route,
                              ),
                            );
                          },
                          icon: Icon(Icons.info_outline),
                          label: Text('Impressum'),
                        ),
                      ],
                    ),
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
