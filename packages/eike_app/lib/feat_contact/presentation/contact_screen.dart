import 'dart:async';

import 'package:eike_app/data_entities/tables/team_contacts_table.dart';
import 'package:eike_app/feat_contact/data/daos/contact_dao.dart';
import 'package:eike_app/feat_contact/data/repositories/contact_repository_impl.dart';
import 'package:eike_app/feat_contact/presentation/bloc/contact_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eike_app/service_design/components/eike_app_bar.dart';
import 'package:eike_app/service_design/components/eike_titled_card.dart';
import 'package:eike_app/service_design/theming/eike_theme.dart';
import 'package:eike_app/service_url_launcher/presentation/bloc/url_launcher_bloc.dart';

class const ContactScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ContactBloc(
          ContactRepositoryImpl(ContactDao(RepositoryProvider.of(context))),
          RepositoryProvider.of(context),
        )..add(const .onSetup());
      },
      child: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          return _Scaffold(state: state);
        },
      ),
    );
  }
}

class const _Scaffold({
  required final ContactState state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EikeAppBar(title: 'Kontakte'),
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

class const _EinsatznachsorgeteamCard({
  required final TeamContactTeamName? teamName,
  required final TeamContactPhone? phone,
  required final TeamContactEmail? email,
}) extends StatelessWidget {
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
        icon: const Icon(Icons.edit),
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
                crossAxisAlignment: .center,
                children: [
                  Text(
                    teamName?.isNotEmpty == true
                        ? (teamName?.value ?? '')
                        : "Team",
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.colors.primary,
                      fontWeight: .bold,
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
                                  fontStyle: .italic,
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
                                    .onLaunchUrl(
                                      Uri(scheme: 'tel', path: phone.value),
                                    ),
                                  );
                                }
                              },
                        icon: const Icon(Icons.phone_rounded),
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
                                  fontStyle: .italic,
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
                                    .onLaunchUrl(
                                      Uri(
                                        scheme: 'mailto',
                                        path: email.value,
                                      ),
                                    ),
                                  );
                                }
                              },
                        icon: const Icon(Icons.email_rounded),
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

class const _NotfallKontakteCard() extends StatelessWidget {
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
            crossAxisAlignment: .start,
            spacing: EikeTheme.verticalComponentSpacingSmall,
            children: [
              Text(
                "Akute Krise?",
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colors.primary,
                  fontWeight: .bold,
                ),
              ),
              Text(
                "Wenn du dich in einer akuten Krise befindest oder sofort Hilfe benötigst, wende dich bitte an die Telefonseelsorge oder den Notruf.",
                style: TextStyle(color: context.colors.onSurface),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                "Notruf",
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colors.primary,
                  fontWeight: .bold,
                ),
              ),
              const Text("Bei akuter Gefahr"),
              const SizedBox(height: EikeTheme.verticalComponentSpacingSmall),
              FilledButton.tonalIcon(
                onPressed: () {
                  BlocProvider.of<UrlLauncherBloc>(
                    context,
                  ).add(
                    .onLaunchUrl(
                      Uri(scheme: 'tel', path: '112'),
                    ),
                  );
                },
                icon: const Icon(Icons.phone_outlined),
                label: const Center(child: Text("112")),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                "Telefonseelsorge",
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colors.primary,
                  fontWeight: .bold,
                ),
              ),
              const Text("24/7 Kostenlos und vertraulich"),
              const SizedBox(height: EikeTheme.verticalComponentSpacingSmall),

              FilledButton.tonalIcon(
                onPressed: () {
                  BlocProvider.of<UrlLauncherBloc>(
                    context,
                  ).add(
                    .onLaunchUrl(
                      Uri(scheme: 'tel', path: '08001110111'),
                    ),
                  );
                },
                icon: const Icon(Icons.phone_outlined),
                label: const Center(child: Text("0800 111 0 111")),
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

class const _EinsatznachsorgeteamEditDialog({
  required final TeamContactTeamName? initialTeamName,
  required final TeamContactPhone? initialPhone,
  required final TeamContactEmail? initialEmail,
}) extends StatefulWidget {
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
      title: Text(
        "Kontaktdaten anpassen",
        style: TextStyle(color: context.colors.primary),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: .min,
          spacing: EikeTheme.verticalComponentSpacingMedium,
          children: [
            const Text(
              "Hier kannst du die Kontaktdaten deines Einsatznachsorgeteams anpassen.",
            ),
            TextField(
              controller: _teamNameController,
              textInputAction: .next,
              decoration: InputDecoration(
                labelText: "Team Name",
                prefixIcon: const Icon(Icons.people_rounded),
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
                    icon: const Icon(Icons.close_rounded),
                  ),
                ),
              ),
            ),
            TextField(
              controller: _phoneController,
              textInputAction: .next,
              keyboardType: .phone,
              decoration: InputDecoration(
                labelText: "Telefonnummer",
                prefixIcon: const Icon(Icons.phone_rounded),
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
                    icon: const Icon(Icons.close_rounded),
                  ),
                ),
              ),
            ),
            TextField(
              controller: _emailController,
              keyboardType: .emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: const Icon(Icons.email_rounded),
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
                    icon: const Icon(Icons.close_rounded),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Abbrechen"),
        ),
        FilledButton.tonal(
          onPressed: () {
            BlocProvider.of<ContactBloc>(context).add(
              .onSetTeamContactData(
                teamName: TeamContactTeamName(_teamNameController.text),
                phoneNumber: TeamContactPhone(_phoneController.text),
                email: TeamContactEmail(_emailController.text),
              ),
            );

            Navigator.of(context).pop();
          },
          child: const Text("speichern"),
        ),
      ],
    );
  }
}
