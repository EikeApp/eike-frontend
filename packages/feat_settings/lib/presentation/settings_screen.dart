import 'package:feat_settings/data/daos/settings_dao.dart';
import 'package:feat_settings/data/repositories/settings_repository_impl.dart';
import 'package:feat_settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_design/theming/eike_theme.dart';

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
      appBar: AppBar(title: Text('Einstellungen')),
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
                  'Einsatznachsorgeteam',
                  style: context.textTheme.headlineSmall,
                ),
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: EikeTheme.cardPadding,
                    child: Column(
                      spacing: EikeTheme.verticalComponentSpacingMedium,
                      children: [
                        TextField(
                          controller: state.teamNameController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Teamname',
                            hintText: 'z.B. PSNV Kreis Musterhausen',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.people_rounded),
                          ),
                        ),
                        TextField(
                          controller: state.phoneController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Telefonnummer',
                            hintText: 'z.B. 0150 11211211',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone_rounded),
                          ),
                        ),
                        TextField(
                          controller: state.emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: 'E-Mail',
                            hintText: 'z.B. PSNV@musterwehr.de',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email_rounded),
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
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: EikeTheme.verticalComponentSpacingSmall,
              children: [
                Text(
                  'Datenschutz & Sicherung',
                  style: context.textTheme.headlineMedium,
                ),
                Card(
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
                Card(
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
                Card(
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
          ],
        ),
      ),
    );
  }
}
