import 'dart:async';

import 'package:eike_app/feat_navigation/eike_routes.dart';
import 'package:eike_app/feat_settings/data/daos/settings_dao.dart';
import 'package:eike_app/feat_settings/data/repositories/settings_repository_impl.dart';
import 'package:eike_app/feat_settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eike_app/service_design/components/eike_app_bar.dart';
import 'package:eike_app/service_design/theming/eike_theme.dart';
import 'package:eike_app/service_design/components/eike_titled_card.dart';

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
  const _Scaffold({required this.state});

  final SettingsState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EikeAppBar(title: 'Settings'),
      body: ListView(
        padding: EikeTheme.pagePadding,
        children: [
          EikeTitledCard(
            leading: Icon(
              Icons.lock_outline_rounded,
              color: context.colors.primary,
            ),
            title: "Datenschutz & Sicherheit",
            child: Column(
              spacing: EikeTheme.verticalComponentSpacingMedium,
              children: [
                Card(
                  color: context.colors.surfaceContainerLowest,
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(EikeTheme.cornerRadius),
                      topRight: Radius.circular(EikeTheme.cornerRadius),
                      bottomRight: Radius.circular(EikeTheme.cornerRadius),
                    ),
                  ),
                  child: Padding(
                    padding: EikeTheme.cardPadding,
                    child: Text(
                      "Alle Daten werden lokal auf deinem Gerät gespeichert und verlassen dein Smartphone nicht.",
                      style: TextStyle(color: context.colors.primary),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'App-Sperre',
                            style: context.textTheme.titleMedium?.copyWith(
                              color: context.colors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Biometrische Authentifizierung"),
                        ],
                      ),
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
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Daten löschen',
                            style: context.textTheme.titleMedium?.copyWith(
                              color: context.colors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Daten unwiderruflich vom Gerät löschen"),
                        ],
                      ),
                    ),
                    IconButton.filled(
                      onPressed: () {
                        unawaited(
                          _onShowCleanupStorageConfirmationDialog(context),
                        );
                      },
                      icon: Icon(Icons.delete_rounded),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: EikeTheme.verticalComponentSpacingMedium),
          EikeTitledCard(
            title: 'Rechtliches',
            leading: Icon(Icons.security_outlined),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: EikeTheme.verticalComponentSpacingMedium,
              children: [
                Text("Informationen zum Umgang mit deinen Daten"),
                TextButton.icon(
                  onPressed: () {
                    unawaited(
                      Navigator.of(
                        context,
                      ).pushNamed(EikeRoute.privacyPolicy.route),
                    );
                  },
                  icon: Icon(Icons.privacy_tip_outlined),
                  label: Row(
                    spacing: EikeTheme.horizontalComponentSpacingMedium,
                    children: [
                      Expanded(child: Text('Datenschutz')),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                ),
                Text("Open-Source-Bibliotheken, die diese App ermöglichen"),
                TextButton.icon(
                  onPressed: () {
                    unawaited(
                      Navigator.of(context).pushNamed(EikeRoute.licenses.route),
                    );
                  },
                  icon: Icon(Icons.description_outlined),
                  label: Row(
                    spacing: EikeTheme.horizontalComponentSpacingMedium,
                    children: [
                      Expanded(child: Text('Lizenzen')),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                ),
                Text("Angaben zum Anbieter und Kontaktmöglichkeiten"),
                TextButton.icon(
                  onPressed: () {
                    unawaited(
                      Navigator.of(context).pushNamed(EikeRoute.imprint.route),
                    );
                  },
                  icon: Icon(Icons.article_outlined),
                  label: Row(
                    spacing: EikeTheme.horizontalComponentSpacingMedium,
                    children: [
                      Expanded(child: Text('Impressum')),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.paddingOf(context).bottom),
        ],
      ),
    );
  }
}

Future<void> _onShowCleanupStorageConfirmationDialog(
  BuildContext context,
) async {
  return showDialog(
    context: context,
    builder: (dialogContext) => BlocProvider.value(
      value: BlocProvider.of<SettingsBloc>(context),
      child: const _CleanupStorageConfirmationDialog(),
    ),
  );
}

class _CleanupStorageConfirmationDialog extends StatelessWidget {
  const _CleanupStorageConfirmationDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Daten löschen"),
      content: Text("Möchtest du wirklich alle Daten löschen?"),
      icon: Icon(Icons.delete_rounded),
      iconColor: context.colors.error,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Abbrechen"),
        ),
        FilledButton.tonal(
          onPressed: () {
            BlocProvider.of<SettingsBloc>(context).add(
              const SettingsEvent.onCleanupLocalStorage(),
            );

            Navigator.of(context).pop();
          },
          style: FilledButton.styleFrom(
            backgroundColor: context.colors.error,
            foregroundColor: context.colors.onError,
          ),
          child: Text("Löschen"),
        ),
      ],
    );
  }
}

