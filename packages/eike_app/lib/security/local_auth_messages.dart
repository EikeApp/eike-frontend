import 'package:local_auth/local_auth.dart';

String localAuthMessage(LocalAuthExceptionCode code) {
  switch (code) {
    case LocalAuthExceptionCode.noCredentialsSet:
      return 'Bitte richte eine Geräte-PIN/Passcode/Pattern ein, um die App-Sperre zu nutzen.';

    case LocalAuthExceptionCode.noBiometricHardware:
      return 'Dieses Gerät unterstützt keine Biometrie (Fingerprint/Face ID). Du kannst ggf. die Geräte-PIN nutzen.';

    case LocalAuthExceptionCode.noBiometricsEnrolled:
      return 'Bitte richte Fingerprint/Face ID ein oder nutze die Geräte-PIN.';

    case LocalAuthExceptionCode.biometricHardwareTemporarilyUnavailable:
      return 'Biometrie ist aktuell nicht verfügbar. Bitte später erneut versuchen.';

    case LocalAuthExceptionCode.biometricLockout:
      return 'Biometrie ist vorübergehend gesperrt (zu viele Versuche). Bitte nutze die Geräte-PIN oder warte kurz.';

    case LocalAuthExceptionCode.temporaryLockout:
      return 'Zu viele Fehlversuche. Bitte warte kurz und versuche es erneut.';

    case LocalAuthExceptionCode.timeout:
      return 'Zeitüberschreitung bei der Authentifizierung.';

    case LocalAuthExceptionCode.userCanceled:
    case LocalAuthExceptionCode.systemCanceled:
      return 'Authentifizierung abgebrochen.';

    case LocalAuthExceptionCode.uiUnavailable:
      return 'Die Authentifizierungs-UI konnte nicht angezeigt werden.';

    case LocalAuthExceptionCode.authInProgress:
      return 'Authentifizierung läuft bereits.';

    case LocalAuthExceptionCode.userRequestedFallback:
      return 'Bitte nutze die alternative Entsperrmethode.';

    case LocalAuthExceptionCode.deviceError:
    case LocalAuthExceptionCode.unknownError:
      return 'Authentifizierung fehlgeschlagen.';
  }
}
