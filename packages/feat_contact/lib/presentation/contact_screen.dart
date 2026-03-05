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
              Text('Notfall-Kontakte', style: context.textTheme.titleMedium),
              _ContactCard(
                title: 'Telefonseelsorge',
                subtitle: '24/7 kostenlos und vertraulich',
                actions: [
                  Flexible(
                    child: TextButton.icon(
                      onPressed: () {
                        final url = Uri(scheme: 'tel', path: '0800 111 0 111');
                        BlocProvider.of<UrlLauncherBloc>(context).add(
                          UrlLauncherEvent.onLaunchUrl(url),
                        );
                      },
                      icon: Icon(Icons.phone_outlined),
                      label: Text('0800 111 0 111'),
                    ),
                  ),
                  Flexible(
                    child: TextButton.icon(
                      onPressed: () {
                        final url = Uri(scheme: 'tel', path: '0800 111 0 222');
                        BlocProvider.of<UrlLauncherBloc>(context).add(
                          UrlLauncherEvent.onLaunchUrl(url),
                        );
                      },
                      icon: Icon(Icons.phone_outlined),
                      label: Text('0800 111 0 222'),
                    ),
                  ),
                ],
              ),
              _ContactCard(
                title: 'Notruf',
                subtitle: 'Bei akuter Gefahr',
                actions: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        final url = Uri(scheme: 'tel', path: '112');
                        BlocProvider.of<UrlLauncherBloc>(context).add(
                          UrlLauncherEvent.onLaunchUrl(url),
                        );
                      },
                      icon: Icon(Icons.phone_outlined),
                      label: Text('112'),
                      style: FilledButton.styleFrom(
                        backgroundColor: context.colors.errorContainer,
                        foregroundColor: context.colors.onErrorContainer,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'PSNV für Einsatzkräfte',
                style: context.textTheme.titleMedium,
              ),
              _ContactCard(
                title: 'Dein Einsatznachsorgeteam',
                subtitle:
                    'Die Kontaktdaten können in den Einstellungen hinterlegt werden.',
                actions: [
                  Flexible(
                    child: FilledButton.icon(
                      onPressed: phone.buttonAvailable
                          ? () {
                              if (phone case TeamContactPhone phone) {
                                BlocProvider.of<UrlLauncherBloc>(context).add(
                                  UrlLauncherEvent.onLaunchUrl(
                                    Uri(scheme: 'tel', path: phone),
                                  ),
                                );
                              }
                            }
                          : null,
                      icon: Icon(Icons.phone_outlined),
                      label: Text(phone.buttonText),
                    ),
                  ),
                  Flexible(
                    child: FilledButton.icon(
                      onPressed: mail.buttonAvailable
                          ? () {
                              if (mail case TeamContactEmail mail) {
                                BlocProvider.of<UrlLauncherBloc>(context).add(
                                  UrlLauncherEvent.onLaunchUrl(
                                    Uri(scheme: 'mailto', path: mail),
                                  ),
                                );
                              }
                            }
                          : null,
                      icon: Icon(Icons.mail_outline),
                      label: Text(mail.buttonText),
                    ),
                  ),
                ],
              ),
              // StreamBuilder<TeamContact?>(
              //   stream: context.read<AppDatabase>().watchTeamContact(),
              //   builder: (context, snapshot) {
              //     final team = snapshot.data;
              //
              //     final phone = (team?.phone ?? '').trim();
              //     final email = (team?.email ?? '').trim();
              //
              //     final hasPhone = phone.isNotEmpty;
              //     final hasEmail = email.isNotEmpty;
              //
              //     return _ContactCard(
              //       title: 'Dein Einsatznachsorgeteam',
              //       subtitle:
              //           'Die Kontaktdaten können in den Einstellungen hinterlegt werden.',
              //       actions: [
              //         FilledButton.icon(
              //           onPressed: hasPhone
              //               ? () => _dialPhone(context, phone)
              //               : null,
              //           icon: Icon(Icons.phone_outlined),
              //           label: hasPhone ? phone : 'Nicht hinterlegt',
              //         ),
              //         FilledButton.icon(
              //           onPressed: hasEmail
              //               ? () => _sendEmail(
              //                   context,
              //                   email,
              //                   subject: 'EIKE – Einsatznachsorge',
              //                 )
              //               : null,
              //           icon: Icon(Icons.mail_outline),
              //           label: hasEmail ? email : 'Nicht hinterlegt',
              //         ),
              //       ],
              //     );
              //   },
              // ),
            ],
          ),
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

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.title,
    required this.subtitle,
    required this.actions,
  });

  final String title;
  final String subtitle;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EikeTheme.cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: EikeTheme.verticalComponentSpacingMedium,
          children: [
            Text(
              title,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(subtitle),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: EikeTheme.horizontalComponentSpacingMedium,
              children: actions,
            ),
          ],
        ),
      ),
    );
  }
}

extension on TeamContactPhone? {
  String get buttonText =>
      this?.isNotEmpty == true ? toString() : 'Nicht hinterlegt';
  bool get buttonAvailable => this?.isNotEmpty == true;
}

extension on TeamContactEmail? {
  String get buttonText =>
      this?.isNotEmpty == true ? toString() : 'Nicht hinterlegt';
  bool get buttonAvailable => this?.isNotEmpty == true;
}
