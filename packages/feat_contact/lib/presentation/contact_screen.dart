import 'package:data_database/eike_database.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EikeAppBar(title: 'Kontakt'),
      body: ListView(
        padding: EdgeInsets.only(
          left: EikeTheme.horizontalPagePadding,
          right: EikeTheme.horizontalPagePadding,
          top: EikeTheme.verticalPagePadding,
          bottom: EikeTheme.verticalPagePadding + kToolbarHeight * 1.5,
        ),
        children: [
          _TeamCard(
            teamContact: state.teamContact,
          ),
          const SizedBox(height: EikeTheme.verticalComponentSpacingLarge),
          _EmergencyCard(),
        ],
      ),
    );
  }
}

class _TeamCard extends StatelessWidget {
  const _TeamCard({required this.teamContact});

  final TeamContactEntity? teamContact;

  TeamContactPhone? get phone => switch (teamContact?.phone) {
    final value => value?.isNotEmpty == true ? value : null,
  };

  TeamContactEmail? get email => switch (teamContact?.email) {
    final value => value?.isNotEmpty == true ? value : null,
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EikeTheme.cardPadding,
        child: Column(
          spacing: EikeTheme.verticalComponentSpacingMedium,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: EikeTheme.horizontalComponentSpacingMedium,
              children: [
                Row(
                  spacing: EikeTheme.horizontalComponentSpacingSmall,
                  children: [
                    Icon(
                      Icons.people_outlined,
                      color: context.colors.primary,
                    ),
                    Text(
                      'Dein Einsatznachsorgeteam',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colors.primary,
                      ),
                    ),
                  ],
                ),
                IconButton.filledTonal(
                  onPressed: () {},
                  icon: Icon(Icons.edit_outlined),
                ),
              ],
            ),
            Divider(color: context.colors.primary),

            if (phone == null && email == null) ...[
              Text(
                'Du hast noch keine Kontaktdaten für dein Einsatznachsorgeteam hinterlegt. Bitte füge mindestens eine Kontaktmöglichkeit hinzu.',
                style: context.textTheme.bodyMedium,
              ),
            ] else ...[
              Card(
                color: context.colors.surfaceContainerLowest,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(EikeTheme.cornerRadius),
                    topRight: Radius.circular(EikeTheme.cornerRadius),
                    bottomRight: Radius.circular(EikeTheme.cornerRadius),
                  ),
                ),
                child: Padding(
                  padding: EikeTheme.cardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wenn du dich in einer akuten Krise befindest oder sofort Hilfe benötigst, wende dich bitte an die Telefonseelsorge oder den Notruf.',
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
            if (phone case TeamContactPhone phone) ...[
              Row(
                spacing: EikeTheme.horizontalComponentSpacingMedium,
                children: [
                  Expanded(
                    child: Text(
                      phone,
                      style: context.textTheme.bodyLarge,
                    ),
                  ),
                  IconButton.filled(
                    onPressed: () {
                      BlocProvider.of<UrlLauncherBloc>(context).add(
                        UrlLauncherEvent.onLaunchUrl(
                          Uri.parse('tel:$phone'),
                        ),
                      );
                    },
                    icon: Icon(Icons.phone),
                  ),
                ],
              ),
            ],
            if (email case TeamContactEmail email) ...[
              Row(
                spacing: EikeTheme.horizontalComponentSpacingMedium,
                children: [
                  Expanded(
                    child: Text(
                      email,
                      style: context.textTheme.bodyLarge,
                    ),
                  ),
                  IconButton.filled(
                    onPressed: () {
                      BlocProvider.of<UrlLauncherBloc>(context).add(
                        UrlLauncherEvent.onLaunchUrl(
                          Uri.parse('mailto:$email'),
                        ),
                      );
                    },
                    icon: Icon(Icons.email),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _EmergencyCard extends StatelessWidget {
  const _EmergencyCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EikeTheme.cardPadding,
        child: Column(
          spacing: EikeTheme.verticalComponentSpacingMedium,
          children: [
            Row(
              spacing: EikeTheme.horizontalComponentSpacingSmall,
              children: [
                Icon(
                  Icons.emergency_outlined,
                  color: context.colors.primary,
                ),
                Text(
                  'Notfall - Kontakte',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colors.primary,
                  ),
                ),
              ],
            ),
            Divider(color: context.colors.primary),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Akute Krise?',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colors.primary,
                  ),
                ),
                Text(
                  'Wenn du dich in einer akuten Krise befindest oder sofort Hilfe benötigst, wende dich bitte an die Telefonseelsorge oder den Notruf.',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.primary,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: EikeTheme.verticalComponentSpacingSmall,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notruf',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colors.primary,
                      ),
                    ),
                    Text(
                      'Bei akuter Gefahr',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colors.primary,
                      ),
                    ),
                  ],
                ),
                FilledButton.tonalIcon(
                  onPressed: () {
                    BlocProvider.of<UrlLauncherBloc>(context).add(
                      UrlLauncherEvent.onLaunchUrl(
                        Uri.parse('tel:112'),
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Color(0xFFD2E4FF),
                  ),
                  icon: Icon(Icons.phone_outlined),
                  label: SizedBox(
                    width: double.infinity,
                    child: Text('112', textAlign: TextAlign.center),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: EikeTheme.verticalComponentSpacingSmall,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Telefonseelsorge',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colors.primary,
                      ),
                    ),
                    Text(
                      '24/7 Kostenlos und vertraulich',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colors.primary,
                      ),
                    ),
                  ],
                ),
                FilledButton.tonalIcon(
                  onPressed: () {
                    BlocProvider.of<UrlLauncherBloc>(context).add(
                      UrlLauncherEvent.onLaunchUrl(
                        Uri.parse('tel:08001110111'),
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Color(0xFFD2E4FF),
                  ),
                  icon: Icon(Icons.phone_outlined),
                  label: SizedBox(
                    width: double.infinity,
                    child: Text('0800 111 0 111', textAlign: TextAlign.center),
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
