import 'dart:async';

import 'package:data_entities/tables/team_contacts_table.dart';
import 'package:feat_contact/data/daos/contact_dao.dart';
import 'package:feat_contact/data/repositories/contact_repository_impl.dart';
import 'package:feat_contact/presentation/bloc/contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_design/components/eike_app_bar.dart';
import 'package:service_design/components/eike_titled_card.dart';
import 'package:service_design/theming/eike_theme.dart';
import 'package:service_url_launcher/presentation/bloc/url_launcher_bloc.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ContactBloc(
          ContactRepositoryImpl(ContactDao(RepositoryProvider.of(context))),
        )..add(const ContactEvent.onSetup());
      },
      child: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          return _Scaffold(state: state);
        },
      ),
    );
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({required this.state});

  final ContactState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EikeAppBar(title: 'Kontakt'),
      body: ListView(
        padding: EikeTheme.pagePadding,
        children: [
          _EinsatznachsorgeteamCard(
            teamName: state.teamContact?.teamName,
            phone: state.teamContact?.phone,
            email: state.teamContact?.email,
          ),
          const SizedBox(height: EikeTheme.verticalComponentSpacingMedium),
          const _NotfallKontakteCard(),
          SizedBox(height: MediaQuery.paddingOf(context).bottom),
        ],
      ),
    );
  }
}

class _EinsatznachsorgeteamCard extends StatelessWidget {
  const _EinsatznachsorgeteamCard({
    required this.teamName,
    required this.phone,
    required this.email,
  });

  final TeamContactTeamName? teamName;
  final TeamContactPhone? phone;
  final TeamContactEmail? email;

  @override
  Widget build(BuildContext context) {
    return EikeTitledCard(
      title: 'Dein Einsatznachsorgeteam',
      leading: Icon(
        Icons.people_outline_rounded,
        color: context.colors.primary,
      ),
      trailing: IconButton.filledTonal(
        onPressed: () => unawaited(
          _showEinsatznachsorgeteamEditDialog(context),
        ),
        icon: Icon(Icons.edit),
      ),
      child: Column(
        spacing: EikeTheme.verticalComponentSpacingMedium,
        children: [
          Text(
            "Wenn du dich in einer akuten Krise befindest oder sofort Hilfe benötigst, wende dich bitte an die Telefonseelsorge oder den Notruf.",
            style: TextStyle(color: context.colors.onSurface),
          ),
          Card(
            color: context.colors.surfaceContainerLowest,
            child: Padding(
              padding: EikeTheme.cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    teamName?.isNotEmpty == true
                        ? (teamName?.value ?? '')
                        : "Team",
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: EikeTheme.verticalComponentSpacingSmall,
                  ),
                  Row(
                    spacing: EikeTheme.horizontalComponentSpacingMedium,
                    children: [
                      Expanded(
                        child: Text(
                          (phone == null || phone!.isEmpty)
                              ? 'Keine Telefonnummer hinterlegt'
                              : (phone?.value ?? ''),
                          style: (phone == null || phone?.isEmpty == true)
                              ? context.textTheme.labelLarge?.copyWith(
                                  fontStyle: FontStyle.italic,
                                )
                              : context.textTheme.bodyLarge,
                        ),
                      ),
                      IconButton.filled(
                        onPressed: (phone == null || phone?.isEmpty == true)
                            ? null
                            : () {
                                if (phone case TeamContactPhone phone) {
                                  BlocProvider.of<UrlLauncherBloc>(
                                    context,
                                  ).add(
                                    UrlLauncherEvent.onLaunchUrl(
                                      Uri(scheme: 'tel', path: phone.value),
                                    ),
                                  );
                                }
                              },
                        icon: Icon(Icons.phone_rounded),
                      ),
                    ],
                  ),
                  Row(
                    spacing: EikeTheme.horizontalComponentSpacingMedium,
                    children: [
                      Expanded(
                        child: Text(
                          (email == null || email!.isEmpty)
                              ? 'Keine Email hinterlegt'
                              : (email?.value ?? ''),
                          style: (email == null || email?.isEmpty == true)
                              ? context.textTheme.labelLarge?.copyWith(
                                  fontStyle: FontStyle.italic,
                                )
                              : context.textTheme.bodyLarge,
                        ),
                      ),
                      IconButton.filled(
                        onPressed: (email == null || email?.isEmpty == true)
                            ? null
                            : () {
                                if (email case TeamContactEmail email) {
                                  BlocProvider.of<UrlLauncherBloc>(
                                    context,
                                  ).add(
                                    UrlLauncherEvent.onLaunchUrl(
                                      Uri(
                                        scheme: 'mailto',
                                        path: email.value,
                                      ),
                                    ),
                                  );
                                }
                              },
                        icon: Icon(Icons.email_rounded),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotfallKontakteCard extends StatelessWidget {
  const _NotfallKontakteCard();

  @override
  Widget build(BuildContext context) {
    return EikeTitledCard(
      leading: Icon(
        Icons.error_outline_outlined,
        color: context.colors.primary,
      ),
      title: "Notfall - Kontakte",
      child: Column(
        spacing: EikeTheme.verticalComponentSpacingMedium,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: EikeTheme.verticalComponentSpacingSmall,
            children: [
              Text(
                "Akute Krise?",
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Wenn du dich in einer akuten Krise befindest oder sofort Hilfe benötigst, wende dich bitte an die Telefonseelsorge oder den Notruf.",
                style: TextStyle(color: context.colors.onSurface),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notruf",
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Bei akuter Gefahr"),
              const SizedBox(height: EikeTheme.verticalComponentSpacingSmall),
              FilledButton.tonal(
                onPressed: () {
                  BlocProvider.of<UrlLauncherBloc>(
                    context,
                  ).add(
                    UrlLauncherEvent.onLaunchUrl(
                      Uri(scheme: 'tel', path: '112'),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text("112", textAlign: TextAlign.center),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.phone_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Telefonseelsorge",
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("24/7 Kostenlos und vertraulich"),
              const SizedBox(height: EikeTheme.verticalComponentSpacingSmall),
              FilledButton.tonal(
                onPressed: () {
                  BlocProvider.of<UrlLauncherBloc>(
                    context,
                  ).add(
                    UrlLauncherEvent.onLaunchUrl(
                      Uri(scheme: 'tel', path: '08001110111'),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text("0800 111 0 111"),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.phone_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<void> _showEinsatznachsorgeteamEditDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (dialogContext) {
      return BlocProvider.value(
        value: BlocProvider.of<ContactBloc>(context),
        child: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            return _EinsatznachsorgeteamEditDialog(
              initialTeamName: state.teamContact?.teamName,
              initialPhone: state.teamContact?.phone,
              initialEmail: state.teamContact?.email,
            );
          },
        ),
      );
    },
  );
}

class _EinsatznachsorgeteamEditDialog extends StatefulWidget {
  const _EinsatznachsorgeteamEditDialog({
    required this.initialTeamName,
    required this.initialPhone,
    required this.initialEmail,
  });

  final TeamContactTeamName? initialTeamName;
  final TeamContactPhone? initialPhone;
  final TeamContactEmail? initialEmail;

  @override
  State<_EinsatznachsorgeteamEditDialog> createState() =>
      _EinsatznachsorgeteamEditDialogState();
}

class _EinsatznachsorgeteamEditDialogState
    extends State<_EinsatznachsorgeteamEditDialog> {
  late final TextEditingController _teamNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();

    _teamNameController = TextEditingController(text: widget.initialTeamName);
    _phoneController = TextEditingController(text: widget.initialPhone);
    _emailController = TextEditingController(text: widget.initialEmail);
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Kontaktdaten anpassen"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: EikeTheme.verticalComponentSpacingMedium,
        children: [
          Text(
            "Hier kannst du die Kontaktdaten deines Einsatznachsorgeteams anpassen.",
          ),
          TextField(
            controller: _teamNameController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: "Team Name",
              prefixIcon: Icon(Icons.people_rounded),
              suffixIcon: ValueListenableBuilder(
                valueListenable: _teamNameController,
                builder: (context, value, child) {
                  return AnimatedScale(
                    scale: _teamNameController.text.isNotEmpty ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: child,
                  );
                },
                child: IconButton(
                  onPressed: () {
                    _teamNameController.clear();
                  },
                  icon: Icon(Icons.close_rounded),
                ),
              ),
            ),
          ),
          TextField(
            controller: _phoneController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: "Telefonnummer",
              prefixIcon: Icon(Icons.phone_rounded),
              suffixIcon: ValueListenableBuilder(
                valueListenable: _phoneController,
                builder: (context, value, child) {
                  return AnimatedScale(
                    scale: _phoneController.text.isNotEmpty ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: child,
                  );
                },
                child: IconButton(
                  onPressed: () {
                    _phoneController.clear();
                  },
                  icon: Icon(Icons.close_rounded),
                ),
              ),
            ),
          ),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.email_rounded),
              suffixIcon: ValueListenableBuilder(
                valueListenable: _phoneController,
                builder: (context, value, child) {
                  return AnimatedScale(
                    scale: _emailController.text.isNotEmpty ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: child,
                  );
                },
                child: IconButton(
                  onPressed: () {
                    _emailController.clear();
                  },
                  icon: Icon(Icons.close_rounded),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Abbrechen"),
        ),
        FilledButton.tonal(
          onPressed: () {
            BlocProvider.of<ContactBloc>(context).add(
              ContactEvent.onSetTeamContactData(
                teamName: TeamContactTeamName(_teamNameController.text),
                phoneNumber: TeamContactPhone(_phoneController.text),
                email: TeamContactEmail(_emailController.text),
              ),
            );

            Navigator.of(context).pop();
          },
          child: Text("speichern"),
        ),
      ],
    );
  }
}
