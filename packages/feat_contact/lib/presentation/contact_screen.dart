import 'package:data_entities/tables/team_contacts_table.dart';
import 'package:feat_contact/data/daos/contact_dao.dart';
import 'package:feat_contact/data/repositories/contact_repository_impl.dart';
import 'package:feat_contact/presentation/bloc/contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_design/components/eike_app_bar.dart';
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
      appBar: EikeAppBar(title: 'Kontakt'),
      body: SingleChildScrollView(
        padding: EikeTheme.pagePadding,
        child: Column(
          spacing: EikeTheme.verticalComponentSpacingMedium,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AlertCard(
              title: 'Akute Krise?',
              message:
                  'Wenn du dich in einer akuten Krise befindest oder sofort Hilfe benötigst, wende dich bitte an die Telefonseelsorge oder den Notruf.',
            ),
            Text(
              'Notfall-Kontakte',
              style: context.textTheme.titleMedium,
            ),
            Card.outlined(
              child: Padding(
                padding: EikeTheme.cardPadding,
                child: Column(
                  crossAxisAlignment: .stretch,
                  spacing: EikeTheme.verticalComponentSpacingMedium,
                  children: [
                    Text(
                      'Telefonseelsorge',
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('24/7 kostenlos und vertraulich'),
                    Wrap(
                      spacing: EikeTheme.horizontalComponentSpacingMedium,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {
                            BlocProvider.of<UrlLauncherBloc>(context).add(
                              UrlLauncherEvent.onLaunchUrl(
                                Uri.parse('tel:08001110111'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.phone_outlined),
                          label: Text('0800 111 0 111'),
                        ),
                        OutlinedButton.icon(
                          onPressed: () {
                            BlocProvider.of<UrlLauncherBloc>(context).add(
                              UrlLauncherEvent.onLaunchUrl(
                                Uri.parse('tel:116123'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.phone_outlined),
                          label: Text('116 123'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card.outlined(
              child: Padding(
                padding: EikeTheme.cardPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: EikeTheme.verticalComponentSpacingMedium,
                  children: [
                    Text(
                      'Notruf',
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Bei akuter Gefahr'),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: context.colors.errorContainer,
                              foregroundColor: context.colors.onErrorContainer,
                            ),
                            onPressed: () {
                              BlocProvider.of<UrlLauncherBloc>(context).add(
                                UrlLauncherEvent.onLaunchUrl(
                                  Uri.parse('tel:112'),
                                ),
                              );
                            },
                            icon: const Icon(Icons.phone_outlined),
                            label: Text('112'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'PSNV für Einsatzkräfte',
              style: context.textTheme.titleMedium,
            ),
            Row(
              children: [
                Expanded(
                  child: Card.outlined(
                    child: Padding(
                      padding: EikeTheme.cardPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: EikeTheme.verticalComponentSpacingMedium,
                        children: [
                          Text(
                            'Team-Kontakt',
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Wrap(
                            spacing: EikeTheme.horizontalComponentSpacingMedium,
                            children: [
                              Builder(
                                builder: (context) {
                                  final phone = this.phone;
                                  if (phone == null || phone.isEmpty) {
                                    return OutlinedButton.icon(
                                      onPressed: null,
                                      icon: const Icon(Icons.phone_outlined),
                                      label: const Text('Nicht hinterlegt'),
                                    );
                                  }

                                  return OutlinedButton.icon(
                                    onPressed: () {
                                      BlocProvider.of<UrlLauncherBloc>(
                                        context,
                                      ).add(
                                        UrlLauncherEvent.onLaunchUrl(
                                          Uri.parse('tel:${phone.value}'),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.phone_outlined),
                                    label: Text(phone.value),
                                  );
                                },
                              ),
                              Builder(
                                builder: (context) {
                                  final mail = this.mail;
                                  if (mail == null || mail.isEmpty) {
                                    return OutlinedButton.icon(
                                      onPressed: null,
                                      icon: const Icon(Icons.email_outlined),
                                      label: const Text('Nicht hinterlegt'),
                                    );
                                  }

                                  return OutlinedButton.icon(
                                    onPressed: () {
                                      BlocProvider.of<UrlLauncherBloc>(
                                        context,
                                      ).add(
                                        UrlLauncherEvent.onLaunchUrl(
                                          Uri.parse('mailto:${mail.value}'),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.email_outlined),
                                    label: Text(mail.value),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
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
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(EikeTheme.cornerRadius),
      ),
      child: Padding(
        padding: EikeTheme.cardPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: EikeTheme.horizontalComponentSpacingMedium,
          children: [
            Icon(
              Icons.error_outlined,
              color: context.colors.onErrorContainer,
            ),
            Flexible(
              child: Column(
                spacing: EikeTheme.verticalComponentSpacingMedium,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colors.onErrorContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    message,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.onErrorContainer,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
