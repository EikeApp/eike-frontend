import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datenschutz'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Datenschutzerklärung',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'gemäß Art. 13 DSGVO',
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
              'Die verantwortliche Stelle für die Datenverarbeitung in dieser App ist:\n\n'
              'Deutscher Fachverband für Psychosoziale Notfallversorgung (DF-PSNV) e.V.\n'
              'Schweetskroog 19\n'
              '22967 Tremsbüttel',
            ),
            // const SizedBox(height: 16),
            _heading('Datenverarbeitung in dieser App'),
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
