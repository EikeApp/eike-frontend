import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/app_header.dart';

class ImprintScreen extends StatelessWidget {
  const ImprintScreen({super.key});

  Future<void> _launchEmail(String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _launchTel(String phone) async {
    final cleaned = phone.replaceAll(' ', '');
    final uri = Uri(scheme: 'tel', path: cleaned);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: 'Impressum'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _heading('Anbieter'),
            const Text(
              'Deutscher Fachverband für Psychosoziale Notfallversorgung (DF-PSNV) e.V.\n'
              'P.-H.-Eggers-Straße 22\n'
              '24768 Rendsburg\n'
              'Deutschland',
            ),
            const SizedBox(height: 16),
            _heading('Vertreten durch'),
            const Text(
              'Volker Schenk (Vorstandsvorsitzender)\n'
              'Ingo Vigneron (Stellvertreter)',
            ),
            const SizedBox(height: 16),
            _heading('Kontakt'),
            const Text(
              'E-Mail: eikeapp@df-psnv.de\n'
              'Telefon: +49 4331 7353705',
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                TextButton.icon(
                  onPressed: () => _launchEmail('eikeapp@df-psnv.de'),
                  icon: const Icon(Icons.email_outlined, size: 18),
                  label: const Text('E-Mail schreiben'),
                ),
                TextButton.icon(
                  onPressed: () => _launchTel('+49 4331 7353705'),
                  icon: const Icon(Icons.phone_outlined, size: 18),
                  label: const Text('Anrufen'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _heading('Registereintrag'),
            const Text(
              // TODO: Anpassen
              'Eingetragen im Vereinsregister\n'
              'Registergericht: Amtsgericht Berlin\n'
              'Registernummer: VR 30959 B',
            ),
            // Optional: Ggf. bei redaktionellen Inhalten erforderlich
            // const SizedBox(height: 16),
            // _heading('Inhaltlich verantwortlich (§ 18 Abs. 2 MStV)'),
            // const Text(
            //   // TODO: Anpassen
            //   'Max Mustermann\n'
            //   'Musterstraße 123\n'
            //   '12345 Musterstadt',
            // ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _heading(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
