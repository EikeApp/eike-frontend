import 'package:data_entities/tables/team_contacts_table.dart';
import 'package:feat_contact/data/daos/contact_dao.dart';
import 'package:feat_contact/data/repositories/contact_repository_impl.dart';
import 'package:feat_contact/presentation/bloc/contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  TeamContactPhone? get phone => state.teamContact?.phone;
  TeamContactEmail? get mail => state.teamContact?.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kontakt')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EikeTheme.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: EikeTheme.verticalComponentSpacingMedium,
            children: [
              _AlertCard(
                title: 'Akute Krise?',
                message:
                    'Wenn du dich in einer akuten Krise befindest oder sofort Hilfe benötigst, wende dich bitte an die Telefonseelsorge oder den Notruf.',
              ),
              _ExpandableCard(
                title: 'Notfall-Kontakte',
                icon: Icons.emergency_rounded,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: EikeTheme.verticalComponentSpacingMedium,
                    children: [
                      Text(
                        'Telefonseelsorge',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '24 Stunden, 7 Tage die Woche vertrauliche und kostenlose Beratung unter den folgenden Nummern',
                      ),
                      Wrap(
                        spacing: EikeTheme.horizontalComponentSpacingMedium,
                        children: [
                          FilledButton.tonalIcon(
                            onPressed: () {},
                            icon: Icon(Icons.phone_rounded),
                            label: Text('0800 111 0 111'),
                          ),
                          FilledButton.tonalIcon(
                            onPressed: () {},
                            icon: Icon(Icons.phone_rounded),
                            label: Text('0800 111 0 222'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: EikeTheme.verticalComponentSpacingMedium,
                    children: [
                      Text(
                        'Notruf',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Zögern Sie nicht bei akuter Gefahr die Notfalldienste zu benachrichtigen.',
                      ),
                      Wrap(
                        spacing: EikeTheme.horizontalComponentSpacingMedium,
                        children: [
                          FilledButton.tonalIcon(
                            onPressed: () {
                              BlocProvider.of<UrlLauncherBloc>(context).add(
                                UrlLauncherEvent.onLaunchUrl(
                                  Uri(scheme: 'tel', path: '110'),
                                ),
                              );
                            },
                            icon: Icon(Icons.phone_rounded),
                            label: Text('110'),
                          ),
                          FilledButton.tonalIcon(
                            onPressed: () {
                              BlocProvider.of<UrlLauncherBloc>(context).add(
                                UrlLauncherEvent.onLaunchUrl(
                                  Uri(scheme: 'tel', path: '112'),
                                ),
                              );
                            },
                            icon: Icon(Icons.phone_rounded),
                            label: Text('112'),
                          ),
                          FilledButton.tonalIcon(
                            onPressed: () {
                              BlocProvider.of<UrlLauncherBloc>(context).add(
                                UrlLauncherEvent.onLaunchUrl(
                                  Uri(scheme: 'tel', path: '116117'),
                                ),
                              );
                            },
                            icon: Icon(Icons.phone_rounded),
                            label: Text('116117'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              _ExpandableCard(
                title: 'PSNV für Einsatzkräfte',
                icon: Icons.contact_emergency_rounded,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: EikeTheme.verticalComponentSpacingMedium,
                    children: [
                      Text(
                        'Dein Einsatznachsorgeteam',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Die Kontaktdaten können in den Einstellungen hinterlegt werden.',
                      ),
                      Wrap(
                        spacing: EikeTheme.horizontalComponentSpacingMedium,
                        children: [
                          if (phone case TeamContactPhone phone)
                            if (phone.isNotEmpty)
                              FilledButton.icon(
                                onPressed: () {
                                  BlocProvider.of<UrlLauncherBloc>(context).add(
                                    UrlLauncherEvent.onLaunchUrl(
                                      Uri(scheme: 'tel', path: phone),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.phone_outlined),
                                label: Text(phone),
                              ),
                          if (mail case TeamContactEmail mail)
                            if (mail.isNotEmpty)
                              FilledButton.icon(
                                onPressed: () {
                                  BlocProvider.of<UrlLauncherBloc>(context).add(
                                    UrlLauncherEvent.onLaunchUrl(
                                      Uri(scheme: 'mailto', path: mail),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.mail_outline),
                                label: Text(mail),
                              ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpandableCard extends StatelessWidget {
  const _ExpandableCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(EikeTheme.cornerRadius),
          ),
          title: Row(
            spacing: EikeTheme.horizontalComponentSpacingMedium,
            children: [
              Icon(icon),
              Text(title),
            ],
          ),
          initiallyExpanded: true,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          childrenPadding: EdgeInsets.only(
            left: EikeTheme.horizontalCardPadding,
            right: EikeTheme.horizontalCardPadding,
            bottom: EikeTheme.verticalCardPadding,
          ),
          children: [
            if (children.isNotEmpty) ...[
              Divider(
                color: context.colors.surfaceContainerHighest,
                height: 2,
                thickness: 2,
                indent: 0,
              ),
              const SizedBox(height: EikeTheme.verticalComponentSpacingMedium),
            ],
            for (final (index, child) in children.indexed) ...[
              if (index > 0)
                const SizedBox(
                  height: EikeTheme.verticalComponentSpacingMedium,
                ),
              child,
            ],
          ],
        ),
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  const _AlertCard({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      color: context.colors.errorContainer,
      child: Padding(
        padding: EikeTheme.cardPadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: EikeTheme.horizontalComponentSpacingMedium,
          children: [
            Icon(Icons.error, color: context.colors.onErrorContainer),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: EikeTheme.verticalComponentSpacingSmall,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colors.onErrorContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(message),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
