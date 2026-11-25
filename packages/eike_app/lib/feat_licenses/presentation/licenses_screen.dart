import 'package:eike_app/feat_licenses/presentation/license_text_screen.dart';
import 'package:eike_app/service_design/components/eike_app_bar.dart';
import 'package:eike_app/service_design/components/eike_titled_card.dart';
import 'package:eike_app/service_design/theming/eike_theme.dart';
import 'package:eike_app/service_url_launcher/presentation/bloc/url_launcher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LicensesScreen extends StatelessWidget {
  const LicensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EikeAppBar(title: 'Lizenzen'),
      body: ListView(
        padding: EikeTheme.pagePadding,
        children: [
          const _ProjectLicenseCard(
            title: 'Quellcode',
            icon: Icons.code,
            licenseName: 'Lizenz: EUPL 1.2',
            licenseDescription:
                'Open-Source-Lizenz für die Europäische Union, Version 1.2',
            repositoryUrl: 'https://github.com/EikeApp/eike-frontend',
            licenseTitle: 'EUPL 1.2',
            licenseAsset: 'assets/licenses/EUPL-1.2.de.html',
            licenseSourceUrl: 'https://eupl.eu/1.2/de/',
          ),
          const SizedBox(height: EikeTheme.verticalComponentSpacingMedium),
          const _ProjectLicenseCard(
            title: 'Inhalte',
            icon: Icons.article_outlined,
            licenseName: 'Lizenz: CC BY-NC-ND 4.0',
            licenseDescription: 'Creative Commons Namensnennung – Nicht kommerziell – Keine Bearbeitungen 4.0 International',
            // Attribution from eike-content/LICENSE.md, shown with the full text.
            licenseNotice: 'eike-content © 2025 by DF-PSNV',
            repositoryUrl: 'https://github.com/EikeApp/eike-content',
            licenseTitle: 'CC BY-NC-ND 4.0',
            licenseAsset: 'assets/licenses/CC-BY-NC-ND-4.0.de.html',
            licenseSourceUrl: 'https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode.de',
          ),
          const SizedBox(height: EikeTheme.verticalComponentSpacingMedium),
          EikeTitledCard(
            title: 'Open-Source-Bibliotheken',
            leading: const Icon(Icons.library_books_outlined),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: EikeTheme.verticalComponentSpacingMedium,
              children: [
                const Text(
                  'Diese App verwendet weitere Open-Source-Bibliotheken '
                  'und Schriftarten.',
                ),
                _LicenseButton(
                  label: 'Drittanbieter-Lizenzen anzeigen',
                  icon: Icons.navigate_next,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const LicensePage(),
                      ),
                    );
                  },
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

class _ProjectLicenseCard extends StatelessWidget {
  const _ProjectLicenseCard({
    required this.title,
    required this.icon,
    required this.licenseName,
    required this.licenseDescription,
    required this.repositoryUrl,
    required this.licenseTitle,
    required this.licenseAsset,
    required this.licenseSourceUrl,
    this.licenseNotice,
  });

  final String title;
  final IconData icon;
  final String licenseName;
  final String licenseDescription;
  final String repositoryUrl;
  final String licenseTitle;
  final String licenseAsset;
  final String licenseSourceUrl;
  final String? licenseNotice;

  @override
  Widget build(BuildContext context) {
    return EikeTitledCard(
      title: title,
      leading: Icon(icon),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: EikeTheme.verticalComponentSpacingMedium,
        children: [
          Text(licenseName, style: context.textTheme.titleSmall),
          Text(licenseDescription),
          const Text(
            'Rechteinhaber: Deutscher Fachverband für Psychosoziale '
            'Notfallversorgung (DF-PSNV) e. V.',
          ),
          Column(
            spacing: EikeTheme.verticalComponentSpacingSmall,
            children: [
              _LicenseButton(
                label: 'Auf GitHub ansehen',
                icon: Icons.open_in_new,
                onPressed: () {
                  context.read<UrlLauncherBloc>().add(
                    UrlLauncherEvent.onLaunchUrl(Uri.parse(repositoryUrl)),
                  );
                },
              ),
              _LicenseButton(
                label: 'Vollständigen Lizenztext anzeigen',
                icon: Icons.description_outlined,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => LicenseTextScreen(
                        title: licenseTitle,
                        assetPath: licenseAsset,
                        sourceUrl: licenseSourceUrl,
                        notice: licenseNotice,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LicenseButton extends StatelessWidget {
  const _LicenseButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(minimumSize: const Size(48, 48)),
      onPressed: onPressed,
      child: Row(
        spacing: EikeTheme.horizontalComponentSpacingSmall,
        children: [
          Icon(icon),
          Expanded(child: Text(label)),
        ],
      ),
    );
  }
}
