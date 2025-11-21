# eike-frontend

## Produkt-Vision

Unsere Vision ist es, Einsatzkräften Informationen und Unterstützung bei der Vorbereitung und Verarbeitung von
belastenden Einsätzen zu geben.

## Legal information

[LICENSE](LICENSE.md)

[CONTRIBUTOR-AGREEMENT](docs/CONTRIBUTOR-AGREEMENT.md)

## Releases

Es werden automatisiert Releases erstellt, wenn der main-Branch aktualisiert wird.

Damit [breaking changes als SemVer](https://semver.org/) korrekt erkannt werden, sollten
[conventional commits](https://www.conventionalcommits.org) verwendet werden.

## Entwicklung

Dieses Projekt verwendet ein `Makefile`, um den Entwicklungsprozess zu vereinfachen und externe Content-Assets zu verwalten.

### Voraussetzungen

*   Flutter SDK
*   Dart SDK
*   Make (auf macOS/Linux meist vorinstalliert. Unter Windows kann es z.B. via [Chocolatey](https://chocolatey.org/) mit `choco install make` installiert werden.)

### Befehle

| Befehl               | Beschreibung                                                                |
|:---------------------|:----------------------------------------------------------------------------|
| `make run`           | Lädt Content-Assets und startet die App im Debug-Modus.                     |
| `make fetch-content` | Lädt nur die Content-Assets herunter (basierend auf `VERSION` in Makefile). |
| `make build-apk`     | Baut die Android APK (inkl. Content-Assets).                                |
| `make build-ios`     | Baut die iOS App (inkl. Content-Assets).                                    |
| `make clean`         | Bereinigt Build-Artefakte und den Content-Cache.                            |

### Content-Versionierung

Die Version der Content-Assets wird in der Makefile unter `VERSION` definiert.

**Temporäres Überschreiben der Version:**
Für Tests (z.B. Pull Requests oder spezifische Versionen) kann die Version beim Aufruf überschrieben werden:

```bash
# Teste einen spezifischen Pull Request (z.B. PR #8)
make run VERSION=pr-8

# Teste eine spezifische Version/Tag
make run VERSION=1.0.0
```
