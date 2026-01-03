import 'package:flutter/material.dart';

import '../widgets/app_header.dart';
import '../widgets/button.dart';
import '../widgets/section_title.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: 'Kontakt'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AlertCard(
                title: 'Akute Krise?',
                message:
                    'Wenn du dich in einer akuten Krise befindest oder sofort Hilfe benötigst, wende dich bitte an die Telefonseelsorge oder den Notruf.',
              ),
              const SectionTitle('Notfall- Kontakte'),
              _ContactCard(
                title: 'Telefonseelsorge',
                subtitle: '24/7 kostenlos und vertraulich',
                actions: [
                  Button(
                    icon: Icons.phone,
                    label: '0800 111 0 111',
                    onPressed: () {},
                  ),
                  Button(
                    icon: Icons.phone,
                    label: '0800 111 0 222',
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _ContactCard(
                title: 'Notruf',
                subtitle: 'Bei akuter Gefahr',
                actions: [
                  Button(
                    icon: Icons.phone_outlined,
                    label: '112',
                    variant: ButtonVariant.alert,
                    fullWidth: true,
                    onPressed: () {},
                  ),
                ],
              ),
              const SectionTitle('PSNV für Einsatzkräfte'),
              _ContactCard(
                title: 'Dein Einsatznachsorgeteam',
                subtitle:
                    'Die Kontaktdaten können in den Einstellungen hinterlegt werden.',
                actions: [
                  Button(icon: Icons.phone, label: 'Nicht hinterlegt'),
                  Button(icon: Icons.mail_outline, label: 'Nicht hinterlegt'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  const _AlertCard({required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Icon(Icons.error, color: theme.colorScheme.onErrorContainer),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onErrorContainer,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onErrorContainer,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
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
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              subtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.center,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: actions,
            ),
          ),
        ],
      ),
    );
  }
}
