import 'package:flutter/material.dart';

import '../widgets/app_header.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: 'Datenschutz'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gemäß Art. 13 DSGVO',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            const Text(
              'Der Schutz Ihrer persönlichen Daten hat einen hohen Stellenwert. An dieser Stelle informieren wir Sie darüber, wie wir mit den Daten umgehen, die Nutzer wissentlich oder unwissentlich hinterlassen, wenn Sie die App verwenden.',
            ),
            _heading('Allgemeine Beschreibung'),
            const Text(
              'Die App "Eike" kann Feuerwehr-Einsatzkräften Informationen und Unterstützung bei der Vorbereitung und Verarbeitung von belastenden Einsätzen geben.',
            ),
            _heading(
              'Verantwortlicher gem. Art. 4 Nr. 7 DSGVO und Behördlicher Datenschutzbeauftragter',
            ),
            const Text(
              'Deutscher Fachverband für Psychosoziale Notfallversorgung (DF-PSNV) e.V.\n'
              'P.-H.-Eggers-Straße 22\n'
              '24768 Rendsburg\n'
              'Deutschland',
            ),
            // const SizedBox(height: 16),
            _heading('Datenverarbeitung in dieser App'),
            _headingSmall('Grundsatz'),
            const Text(
              'Alle Daten werden lokal auf dem Gerät gespeichert.\n'
              'Es findet in der aktuellen Implementierung keine Übertragung an Server/Cloud statt.'
              'Biometrie wird nicht von der App gespeichert. Die App nutzt nur die vom Betriebssystem bereitgestellte Authentifizierung.',
            ),
            _headingSmall('Vorsätze'),
            const Text(
              'Beschreibung: Nutzende der App können eigene Verhaltensvorsätze in Textform in Freitextfelder schreiben. Die Angabe von Daten sind freiwillig.\n\n'
              'Speicherung: Die angegebenen Daten werden ausschließlich auf dem Endgerät in einer verschlüsselten Datenbank gespeichert und nicht an Dritte oder weitere Systeme übertragen.\n\n'
              'Veränderung: Die angebenen Daten können jederzeit durch den Nutzenden oder die Nutzende verändert werden.\n\n'
              'Löschung: Die angegebenen Daten bleiben so lange auf dem Gerät gespeichert, bis:\n'
              '• sie durch die Nutzende oder den Nutzenden geändert werden\n'
              '• sie durch die Nutzende oder den Nutzenden alle Daten (Button in Einstellungen) gelöscht werden\n'
              '• die App deinstalliert und hierdurch alle App-Daten gelöscht werden',
            ),
            _headingSmall('Welche Speicherorte nutzen wir wofür?'),
            const Text(
              'Wir verarbeiten und speichern Ihre Daten ausschließlich lokal auf Ihrem Endgerät. '
              'Dabei setzen wir je nach Zweck unterschiedliche, geräteinterne Speicherbereiche ein. '
              'Eine Übertragung an eigene Server oder in eine Cloud findet in der aktuellen Implementierung nicht statt.',
            ),
            _headingSmall('1) Verschlüsselte App-Datenbank'),
            const Text(
              'Zweck\n'
              '• Speicherung der von Ihnen eingegebenen Inhalte\n\n'
              'Welche Daten?\n'
              '• Kontaktdaten eines Einsatznachsorgeteams (z. B. Teamname, Telefonnummer, E-Mail-Adresse)\n'
              '• Persönliche Notizen/Freitexte zu den „7 Tipps“\n\n'
              'Technische Umsetzung (Packages)\n'
              '• Drift: https://pub.dev/packages/drift\n'
              '• SQLCipher (Bibliotheken): https://pub.dev/packages/sqlcipher_flutter_libs\n'
              '• SQLite3 (FFI): https://pub.dev/packages/sqlite3\n\n'
              'Schutz und Zugriff\n'
              '• Speicherung erfolgt verschlüsselt in einer lokalen Datenbank (SQLCipher)\n'
              '• Zugriff ausschließlich innerhalb der App',
            ),
            _headingSmall('2) Keychain/Keystore'),
            const Text(
              'Zweck\n'
              '• Ablage von Sicherheits- und Konfigurationsdaten\n\n'
              'Welche Daten?\n'
              '• Technischer Schlüssel zur Entschlüsselung der lokalen Datenbank\n'
              '• Einstellung, ob eine optionale App-Sperre aktiviert ist (ja/nein)\n\n'
              'Technische Umsetzung (Package)\n'
              '• flutter_secure_storage: https://pub.dev/packages/flutter_secure_storage\n\n'
              'Hinweis\n'
              '• Auf iOS können Keychain-Einträge eine Deinstallation ggf. überdauern; '
              'die App setzt Konfigurationswerte beim ersten Start nach Neuinstallation auf Standardwerte zurück.',
            ),
            _headingSmall('3) Technischer Marker für Initialisierung'),
            const Text(
              'Zweck\n'
              '• Technische Initialisierung (Erkennen des ersten Starts nach Installation)\n\n'
              'Welche Daten?\n'
              '• Ein einfacher Marker/Schalter (keine Inhaltsdaten, keine Notizen, keine Kontaktdaten)\n\n'
              'Technische Umsetzung (Package)\n'
              '• shared_preferences: https://pub.dev/packages/shared_preferences',
            ),
            _headingSmall('4) Biometrische Authentifizierung'),
            const Text(
              'Zweck\n'
              '• Entsperren der App über die vom Betriebssystem bereitgestellte Authentifizierung\n\n'
              'Technische Umsetzung (Package)\n'
              '• local_auth: https://pub.dev/packages/local_auth\n\n'
              'Wichtig\n'
              '• Die App erhebt oder speichert keine biometrischen Daten (z. B. Face ID/Fingerprint)\n'
              '• Die biometrische Verarbeitung erfolgt ausschließlich im Betriebssystem innerhalb der jeweiligen Sicherheitsumgebung',
            ),
            _heading('Löschkonzept'),
            const Text(
              'In der App gibt es “Alle Daten löschen”: entfernt die in Drift gespeicherten Inhalte (Kontaktdaten + Tipps/Notizen).\n\n'
              'Bei Deinstallation werden DB-Dateien in der App-Sandbox entfernt. Secure-Storage Einträge können auf iOS ggf. bestehen bleiben (wird durch First-run Reset auf Default zurückgeführt).',
            ),
            _headingSmall('Kontaktdaten eines PSNV-Teams'),
            const Text(
              'Beschreibung: Nutzende der App können Kontaktdaten zu ihrem zuständigen PSNV-Team eintragen, um die Kontaktdaten im Bedarfsfall angezeigt zu bekommen oder die Kontaktdaten an betriebssystemeigene Funktionen (Intents auf Telefon oder E-Mail) weitergeleitet zu bekommen. Die Angabe von Daten sind freiwillig.\n\n'
              'Speicherung: Die angegebenen Daten werden ausschließlich auf dem Endgerät in einer verschlüsselten Datenbank gespeichert und nicht an Dritte oder weitere Systeme übertragen.\n\n'
              'Veränderung: Die angebenen Daten können jederzeit durch den Nutzenden oder die Nutzende verändert werden.\n\n'
              'Löschung: Die angegebenen Daten bleiben so lange auf dem Gerät gespeichert, bis:\n'
              '• sie durch die Nutzende oder den Nutzenden geändert werden\n'
              '• sie durch die Nutzende oder den Nutzenden alle Daten (Button in Einstellungen) gelöscht werden\n'
              '• die App deinstalliert und hierdurch alle App-Daten gelöscht werden',
            ),
            _headingSmall('App-Einstellungen'),
            const Text(
              'Beschreibung: Nutzende der App können Einstellungen der App verändern, um sie nach ihren Wünschen und den gegebenen technischen Einstellungsmöglichkeiten anzupassen. Die Angabe von Daten sind freiwillig.\n\n'
              'Speicherung: Die angegebenen Daten werden ausschließlich auf dem Endgerät gespeichert und nicht an Dritte oder weitere Systeme übertragen.\n\n'
              'Veränderung: Die angebenen Daten können jederzeit durch den Nutzenden oder die Nutzende verändert werden.\n\n'
              'Löschung: Die angegebenen Daten bleiben so lange auf dem Gerät gespeichert, bis:\n'
              '• sie durch die Nutzende oder den Nutzenden geändert werden\n'
              '• sie durch die Nutzende oder den Nutzenden alle Daten (Button in Einstellungen) gelöscht werden\n'
              '• die App deinstalliert und hierdurch alle App-Daten gelöscht werden',
            ),
            _heading('Ihre Betroffenenrechte'),
            const Text(
              'Folgende Rechte stehen Ihnen als Betroffener gegenüber dem oben genannten Verantwortlichen zu:\n'
              '• Recht auf Widerruf der Einwilligung nach Art. 7 Absatz 3 DSGVO\n'
              '• Recht auf Auskunft nach Art. 15 DSGVO\n'
              '• Recht auf Berichtigung nach Art. 16 DSGVO\n'
              '• Recht auf Löschung nach Art. 17 DSGVO\n'
              '• Recht auf Einschränkung der Verarbeitung nach Art. 18 DSGVO\n'
              '• Recht auf Datenübertragbarkeit nach Art. 20 DSGVO\n'
              '• Recht auf Widerspruch nach Art. 21 DSGVO\n'
              '• Recht auf Beschwerde bei der Aufsichtsbehörde nach Art. 77 DSGVO, wenn Sie der Auffassung sind, dass die Verarbeitung Ihrer personenbezogenen Daten gegen Datenschutzbestimmungen verstößt.',
            ),
            _heading('Automatisierte Entscheidungsfindung und Profiling'),
            const Text(
              'Es findet keine automatisierte Entscheidungsfindung einschließlich Profiling gemäß Art. 22 Abs. 1 und 4 DSGVO statt.',
            ),
            _heading('Drittlandtransfer'),
            const Text(
              'Eine Übermittlung Ihrer Daten an ein Drittland oder eine internationale Organisation findet nicht statt und ist auch nicht geplant.',
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _heading(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _headingSmall(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
