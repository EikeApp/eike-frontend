import 'package:feat_settings/data/daos/settings_dao.dart';
import 'package:feat_settings/data/repositories/settings_repository_impl.dart';
import 'package:feat_settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      appBar: const EikeAppBar(title: 'Einstellungen'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Text(
              'Einsatznachsorgeteam',
              style: TextTheme.of(context).titleMedium,
            ),
            Card.filled(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  spacing: 16,
                  children: [
                    TextField(
                      controller: state.teamNameController,
                      decoration: InputDecoration(
                        labelText: 'Teamname',
                        hintText: 'z.B. PSNV Kreis Musterhausen',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    TextField(
                      controller: state.phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Telefonnummer',
                        hintText: 'z.B. 0150 11211211',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    TextField(
                      controller: state.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'E-Mail',
                        hintText: 'z.B. PSNV@musterwehr.de',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FilledButton.icon(
                          onPressed: () {
                            BlocProvider.of<SettingsBloc>(context).add(
                              const SettingsEvent.onUpsertTeamContact(),
                            );
                          },
                          icon: Icon(Icons.save),
                          label: Text('Speichern'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Datenschutz & Sicherung',
              style: TextTheme.of(context).titleMedium,
            ),
            Card.filled(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
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
            Text(
              'Daten verwalten',
              style: TextTheme.of(context).titleMedium,
            ),
            Card.filled(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
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
            Text(
              'Rechtliches',
              style: TextTheme.of(context).titleMedium,
            ),
            Card.filled(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informationen zum Umgang mit deinen Daten',
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.privacy_tip_outlined),
                      label: Text('Datenschutz'),
                    ),
                    Text(
                      'Open-Source-Bibliotheken, die diese App ermöglichen',
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.description_outlined),
                      label: Text('Lizenzen'),
                    ),
                    Text(
                      'Angaben zum Anbieter und Kontaktmöglichkeiten',
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.info_outline),
                      label: Text('Impressum'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
