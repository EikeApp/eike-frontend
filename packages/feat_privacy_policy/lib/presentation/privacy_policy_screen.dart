import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:service_design/components/eike_app_bar.dart';
import 'package:service_design/theming/eike_theme.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EikeAppBar(title: 'Datenschutzerklärung'),
      body: ListView(
        padding: EikeTheme.pagePadding,
        children: [
          Html(data: _privacyHtml),
          SizedBox(height: MediaQuery.paddingOf(context).bottom),
        ],
      ),
    );
  }
}

const String _privacyHtml = '''
<!DOCTYPE html>
<html lang="de">
<head>
  <meta charset="UTF-8">
</head>
<body>
  <p><em>Gemäß Art. 13 DSGVO</em></p>

  <p>Der Schutz Ihrer persönlichen Daten hat einen hohen Stellenwert. An dieser Stelle informieren wir Sie darüber, wie wir mit den Daten umgehen, die Nutzer wissentlich oder unwissentlich hinterlassen, wenn Sie die App verwenden.</p>

  <h2>Allgemeine Beschreibung</h2>
  <p>Die App „Eike" kann Feuerwehr-Einsatzkräften Informationen und Unterstützung bei der Vorbereitung und Verarbeitung von belastenden Einsätzen geben.</p>

  <h2>Verantwortlicher gem. Art. 4 Nr. 7 DSGVO und Behördlicher Datenschutzbeauftragter</h2>
  <p>
    Deutscher Fachverband für Psychosoziale Notfallversorgung (DF-PSNV) e.V.<br>
    P.-H.-Eggers-Straße 22<br>
    24768 Rendsburg<br>
    Deutschland
  </p>

  <h2>Datenverarbeitung in dieser App</h2>

  <h3>Grundsatz</h3>
  <p>Alle Daten werden lokal auf dem Gerät gespeichert. Es findet in der aktuellen Implementierung keine Übertragung an Server/Cloud statt. Biometrie wird nicht von der App gespeichert. Die App nutzt nur die vom Betriebssystem bereitgestellte Authentifizierung.</p>

  <h3>Vorsätze</h3>
  <p><strong>Beschreibung:</strong> Nutzende der App können eigene Verhaltensvorsätze in Textform in Freitextfelder schreiben. Die Angabe von Daten sind freiwillig.</p>
  <p><strong>Speicherung:</strong> Die angegebenen Daten werden ausschließlich auf dem Endgerät in einer verschlüsselten Datenbank gespeichert und nicht an Dritte oder weitere Systeme übertragen.</p>
  <p><strong>Veränderung:</strong> Die angegebenen Daten können jederzeit durch den Nutzenden oder die Nutzende verändert werden.</p>
  <p><strong>Löschung:</strong> Die angegebenen Daten bleiben so lange auf dem Gerät gespeichert, bis:</p>
  <ul>
    <li>sie durch die Nutzende oder den Nutzenden geändert werden</li>
    <li>sie durch die Nutzende oder den Nutzenden alle Daten (Button in Einstellungen) gelöscht werden</li>
    <li>die App deinstalliert und hierdurch alle App-Daten gelöscht werden</li>
  </ul>

  <h3>Welche Speicherorte nutzen wir wofür?</h3>
  <p>Wir verarbeiten und speichern Ihre Daten ausschließlich lokal auf Ihrem Endgerät. Dabei setzen wir je nach Zweck unterschiedliche, geräteinterne Speicherbereiche ein. Eine Übertragung an eigene Server oder in eine Cloud findet in der aktuellen Implementierung nicht statt.</p>

  <h3>1) Verschlüsselte App-Datenbank</h3>
  <p><strong>Zweck</strong></p>
  <ul><li>Speicherung der von Ihnen eingegebenen Inhalte</li></ul>
  <p><strong>Welche Daten?</strong></p>
  <ul>
    <li>Kontaktdaten eines Einsatznachsorgeteams (z. B. Teamname, Telefonnummer, E-Mail-Adresse)</li>
    <li>Persönliche Notizen/Freitexte zu den „7 Tipps"</li>
  </ul>
  <p><strong>Technische Umsetzung (Packages)</strong></p>
  <ul>
    <li>Drift: https://pub.dev/packages/drift</li>
    <li>SQLCipher: https://pub.dev/packages/sqlcipher_flutter_libs</li>
    <li>SQLite3 (FFI): https://pub.dev/packages/sqlite3</li>
  </ul>
  <p><strong>Schutz und Zugriff</strong></p>
  <ul>
    <li>Speicherung erfolgt verschlüsselt in einer lokalen Datenbank (SQLCipher)</li>
    <li>Zugriff ausschließlich innerhalb der App</li>
  </ul>

  <h3>2) Keychain/Keystore</h3>
  <p><strong>Zweck</strong></p>
  <ul><li>Ablage von Sicherheits- und Konfigurationsdaten</li></ul>
  <p><strong>Welche Daten?</strong></p>
  <ul>
    <li>Technischer Schlüssel zur Entschlüsselung der lokalen Datenbank</li>
    <li>Einstellung, ob eine optionale App-Sperre aktiviert ist (ja/nein)</li>
  </ul>
  <p><strong>Technische Umsetzung (Package)</strong></p>
  <ul><li>flutter_secure_storage: https://pub.dev/packages/flutter_secure_storage</li></ul>
  <p><strong>Hinweis:</strong> Auf iOS können Keychain-Einträge eine Deinstallation ggf. überdauern; die App setzt Konfigurationswerte beim ersten Start nach Neuinstallation auf Standardwerte zurück.</p>

  <h3>3) Technischer Marker für Initialisierung</h3>
  <p><strong>Zweck</strong></p>
  <ul><li>Technische Initialisierung (Erkennen des ersten Starts nach Installation)</li></ul>
  <p><strong>Welche Daten?</strong></p>
  <ul><li>Ein einfacher Marker/Schalter (keine Inhaltsdaten, keine Notizen, keine Kontaktdaten)</li></ul>
  <p><strong>Technische Umsetzung (Package)</strong></p>
  <ul><li>shared_preferences: https://pub.dev/packages/shared_preferences</li></ul>

  <h3>4) Biometrische Authentifizierung</h3>
  <p><strong>Zweck</strong></p>
  <ul><li>Entsperren der App über die vom Betriebssystem bereitgestellte Authentifizierung</li></ul>
  <p><strong>Technische Umsetzung (Package)</strong></p>
  <ul><li>local_auth: https://pub.dev/packages/local_auth</li></ul>
  <p><strong>Wichtig</strong></p>
  <ul>
    <li>Die App erhebt oder speichert keine biometrischen Daten (z. B. Face ID/Fingerprint)</li>
    <li>Die biometrische Verarbeitung erfolgt ausschließlich im Betriebssystem innerhalb der jeweiligen Sicherheitsumgebung</li>
  </ul>

  <h2>Löschkonzept</h2>
  <p>In der App gibt es „Alle Daten löschen": entfernt die in Drift gespeicherten Inhalte (Kontaktdaten + Tipps/Notizen).</p>
  <p>Bei Deinstallation werden DB-Dateien in der App-Sandbox entfernt. Secure-Storage Einträge können auf iOS ggf. bestehen bleiben (wird durch First-run Reset auf Default zurückgeführt).</p>

  <h3>Kontaktdaten eines PSNV-Teams</h3>
  <p><strong>Beschreibung:</strong> Nutzende der App können Kontaktdaten zu ihrem zuständigen PSNV-Team eintragen. Die Angabe von Daten sind freiwillig.</p>
  <p><strong>Speicherung:</strong> Ausschließlich lokal auf dem Endgerät in einer verschlüsselten Datenbank.</p>
  <p><strong>Veränderung:</strong> Jederzeit durch den Nutzenden möglich.</p>
  <p><strong>Löschung:</strong> Die Daten bleiben gespeichert bis:</p>
  <ul>
    <li>sie durch die Nutzende oder den Nutzenden geändert werden</li>
    <li>alle Daten über den Button in den Einstellungen gelöscht werden</li>
    <li>die App deinstalliert wird</li>
  </ul>

  <h3>App-Einstellungen</h3>
  <p><strong>Beschreibung:</strong> Nutzende können Einstellungen nach ihren Wünschen anpassen. Die Angabe von Daten sind freiwillig.</p>
  <p><strong>Speicherung:</strong> Ausschließlich lokal auf dem Endgerät.</p>
  <p><strong>Veränderung:</strong> Jederzeit durch den Nutzenden möglich.</p>
  <p><strong>Löschung:</strong> Die Daten bleiben gespeichert bis:</p>
  <ul>
    <li>sie durch die Nutzende oder den Nutzenden geändert werden</li>
    <li>alle Daten über den Button in den Einstellungen gelöscht werden</li>
    <li>die App deinstalliert wird</li>
  </ul>

  <h2>Ihre Betroffenenrechte</h2>
  <p>Folgende Rechte stehen Ihnen als Betroffener gegenüber dem oben genannten Verantwortlichen zu:</p>
  <ul>
    <li>Recht auf Widerruf der Einwilligung nach Art. 7 Absatz 3 DSGVO</li>
    <li>Recht auf Auskunft nach Art. 15 DSGVO</li>
    <li>Recht auf Berichtigung nach Art. 16 DSGVO</li>
    <li>Recht auf Löschung nach Art. 17 DSGVO</li>
    <li>Recht auf Einschränkung der Verarbeitung nach Art. 18 DSGVO</li>
    <li>Recht auf Datenübertragbarkeit nach Art. 20 DSGVO</li>
    <li>Recht auf Widerspruch nach Art. 21 DSGVO</li>
    <li>Recht auf Beschwerde bei der Aufsichtsbehörde nach Art. 77 DSGVO</li>
  </ul>

  <h2>Automatisierte Entscheidungsfindung und Profiling</h2>
  <p>Es findet keine automatisierte Entscheidungsfindung einschließlich Profiling gemäß Art. 22 Abs. 1 und 4 DSGVO statt.</p>

  <h2>Drittlandtransfer</h2>
  <p>Eine Übermittlung Ihrer Daten an ein Drittland oder eine internationale Organisation findet nicht statt und ist auch nicht geplant.</p>
</body>
</html>
''';
