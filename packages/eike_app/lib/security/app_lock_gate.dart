import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'app_lock_storage.dart';
import 'local_auth_messages.dart';

class AppLockGate extends StatefulWidget {
  final Widget child;
  final AppLockStorage storage;

  const AppLockGate({super.key, required this.child, required this.storage});

  @override
  State<AppLockGate> createState() => _AppLockGateState();
}

class _AppLockGateState extends State<AppLockGate> with WidgetsBindingObserver {
  final _auth = LocalAuthentication();

  bool _enabled = false;
  bool _unlocked = true;
  bool _loading = true;
  bool _authInProgress = false;
  bool _lockOnNextResume = false;
  String? _error;

  // --- UX: Cooldown / soft-fail handling ---
  int _softFails = 0;
  DateTime? _lastSoftFailAt;

  // Tuning:
  static const int _maxSoftFailsBeforeNoAutoPrompt = 2;
  static const Duration _cooldown = Duration(seconds: 20);

  bool get _inCooldown {
    final t = _lastSoftFailAt;
    if (t == null) return false;
    return DateTime.now().difference(t) < _cooldown;
  }

  bool get _allowAutoPrompt =>
      !_inCooldown && _softFails < _maxSoftFailsBeforeNoAutoPrompt;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  Future<void> _init() async {
    _enabled = await widget.storage.readEnabled();
    _unlocked = !_enabled;
    if (!mounted) return;
    setState(() => _loading = false);

    // Optional: beim Kaltstart direkt entsperren, aber nur wenn Auto-Prompt erlaubt
    if (_enabled && !_unlocked && _allowAutoPrompt) {
      await _unlock(trigger: _UnlockTrigger.auto);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (_authInProgress) return;

    // iOS: inactive kommt auch bei Overlays. Wir merken uns nur: "beim nächsten Resume sperren".
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      final enabledNow = await widget.storage.readEnabled();
      if (!mounted) return;

      _enabled = enabledNow;

      if (_enabled) {
        _lockOnNextResume = true;
      }
      return;
    }

    if (state == AppLifecycleState.resumed) {
      final enabledNow = await widget.storage.readEnabled();
      if (!mounted) return;

      _enabled = enabledNow;

      if (!_enabled) {
        _lockOnNextResume = false;
        setState(() {
          _unlocked = true;
          _error = null;
        });
        return;
      }

      // Nur beim echten "zurück in die App"-Fall sperren + prompten
      if (_lockOnNextResume) {
        _lockOnNextResume = false;

        // sichtbar sperren
        setState(() {
          _unlocked = false;
          _error = null;
        });

        // iOS: prompt leicht verzögert starten
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (!mounted) return;
          await Future.delayed(const Duration(milliseconds: 250));
          if (!mounted || _authInProgress || !_enabled) return;

          if (_allowAutoPrompt) {
            await _unlock(trigger: _UnlockTrigger.auto);
          }
        });
      }
    }
  }

  Future<void> _unlock({_UnlockTrigger trigger = _UnlockTrigger.manual}) async {
    if (_authInProgress) return;

    if (!mounted) return;
    setState(() {
      _authInProgress = true;
      // Bei manuellem Versuch: Fehlertext behalten? -> ich setze ihn zurück
      _error = null;
    });

    try {
      final supported = await _auth.isDeviceSupported();
      final canCheck = await _auth.canCheckBiometrics;

      if (!supported && !canCheck) {
        if (!mounted) return;
        setState(() {
          _unlocked = true;
          _error = 'Dieses Gerät unterstützt keine sichere Entsperrung.';
        });
        return;
      }

      final ok = await _auth.authenticate(
        localizedReason: 'Bitte entsperren, um die App zu öffnen.',
        biometricOnly: false,
        persistAcrossBackgrounding: true,
      );

      if (!mounted) return;

      if (ok) {
        setState(() {
          _unlocked = true;
          _error = null;
          _softFails = 0;
          _lastSoftFailAt = null;
        });
      } else {
        // "false" ist meistens: user cancelled / fail ohne Exception.
        // Wenn es ein Auto-Prompt war, werten wir das als soft-fail.
        if (trigger == _UnlockTrigger.auto) {
          _registerSoftFail();
        }
        setState(() {
          _unlocked = false;
          // Keine "rote" Fehlermeldung bei Cancel – optional:
          _error = null;
        });
      }
    } on LocalAuthException catch (e) {
      if (!mounted) return;

      final msg = localAuthMessage(e.code);

      // Einige Codes behandeln wir als soft-fail (führt zu cooldown / kein auto prompt)
      final isSoft =
          e.code == LocalAuthExceptionCode.userCanceled ||
          e.code == LocalAuthExceptionCode.systemCanceled ||
          e.code == LocalAuthExceptionCode.timeout ||
          e.code == LocalAuthExceptionCode.uiUnavailable ||
          e.code == LocalAuthExceptionCode.authInProgress;

      if (trigger == _UnlockTrigger.auto && isSoft) {
        _registerSoftFail();
      }

      setState(() {
        _unlocked = false;
        _error = msg;
      });
    } finally {
      if (mounted) {
        setState(() => _authInProgress = false);
      }
    }
  }

  void _registerSoftFail() {
    _softFails += 1;
    _lastSoftFailAt = DateTime.now();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return widget.child;
    if (!_enabled || _unlocked) return widget.child;

    final theme = Theme.of(context);

    final showCooldownHint =
        !_allowAutoPrompt &&
        (_inCooldown || _softFails >= _maxSoftFailsBeforeNoAutoPrompt);
    final cooldownSecondsLeft = _inCooldown
        ? (_cooldown.inSeconds -
                  DateTime.now().difference(_lastSoftFailAt!).inSeconds)
              .clamp(0, _cooldown.inSeconds)
        : 0;

    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: ColoredBox(
            color: theme.colorScheme.surface,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 320),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.lock,
                      size: 44,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 12),
                    Text('App gesperrt', style: theme.textTheme.titleLarge),
                    const SizedBox(height: 8),

                    if (_error != null) ...[
                      Text(
                        _error!,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],

                    if (showCooldownHint) ...[
                      Text(
                        _inCooldown
                            ? 'Automatische Abfrage pausiert. Bitte tippe auf „Entsperren“ (in $cooldownSecondsLeft s erneut automatisch).'
                            : 'Automatische Abfrage pausiert. Bitte tippe auf „Entsperren“.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                    ],

                    ElevatedButton.icon(
                      onPressed: _authInProgress
                          ? null
                          : () => _unlock(trigger: _UnlockTrigger.manual),
                      icon: const Icon(Icons.lock_open),
                      label: Text(_authInProgress ? '…' : 'Entsperren'),
                    ),

                    const SizedBox(height: 8),

                    // Optional: "No Auto Prompt" zurücksetzen, damit Auto wieder funktioniert
                    if (_softFails > 0)
                      TextButton(
                        onPressed: _authInProgress
                            ? null
                            : () {
                                setState(() {
                                  _softFails = 0;
                                  _lastSoftFailAt = null;
                                });
                              },
                        child: const Text(
                          'Automatische Abfrage wieder aktivieren',
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

enum _UnlockTrigger { auto, manual }
