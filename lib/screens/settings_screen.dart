import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

import '../db/app_database.dart';
import '../security/app_lock_storage.dart';
import '../security/local_auth_messages.dart';

import '../widgets/app_header.dart';
import '../widgets/section_title.dart';
import '../widgets/button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final TextEditingController _teamController;
  late final TextEditingController _phoneController;
  late final TextEditingController _mailController;

  final _auth = LocalAuthentication();
  late final AppLockStorage _lockStorage;
  bool _lockLoading = true;
  bool _appLockEnabled = false;

  bool _loading = true;

  Future<void> _loadContacts() async {
    final db = context.read<AppDatabase>();
    final row = await db.getTeamContact();

    if (!mounted) return;

    _teamController.text = row?.teamName ?? '';
    _phoneController.text = row?.phone ?? '';
    _mailController.text = row?.email ?? '';

    setState(() => _loading = false);
  }

  Future<void> _persistContacts() async {
    final db = context.read<AppDatabase>();

    await db.upsertTeamContact(
      teamName: _teamController.text,
      phone: _phoneController.text,
      email: _mailController.text,
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Gespeichert.')));
  }

  Future<void> onToggleAppLock(bool value) async {
    if (!value) {
      await _lockStorage.writeEnabled(false);
      if (!mounted) return;
      setState(() => _appLockEnabled = false);
      return;
    }

    final supported = await _auth.isDeviceSupported();
    final canBio = await _auth.canCheckBiometrics;

    if (!supported && !canBio) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Auf diesem Gerät ist keine sichere Entsperrung eingerichtet.',
          ),
        ),
      );
      return;
    }

    try {
      final ok = await _auth.authenticate(
        localizedReason: 'App-Sperre aktivieren – bitte bestätigen.',
        biometricOnly: false,
        persistAcrossBackgrounding: true,
      );

      if (!ok) return;

      await _lockStorage.writeEnabled(true);
      if (!mounted) return;
      setState(() => _appLockEnabled = true);
    } on LocalAuthException catch (e) {
      if (!mounted) return;

      final msg = localAuthMessage(e.code);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

      await _lockStorage.writeEnabled(false);
      setState(() => _appLockEnabled = false);
    }
  }

  Future<void> _resetData() async {
    final db = context.read<AppDatabase>();

    // Safety-Abfrage
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alle Daten löschen?'),
        content: const Text(
          'Möchtest du alle Daten endgültig vom Gerät entfernen? Diese Aktion ist unwiderruflich.',
        ),
        actions: [
          TextButton(
            child: const Text('Abbrechen'),
            onPressed: () => Navigator.pop(context, false),
          ),
          Button(
            label: 'Daten Löschen',
            variant: ButtonVariant.alert,
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await db.deleteAllData();

    if (!mounted) return;

    _teamController.clear();
    _phoneController.clear();
    _mailController.clear();

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Alle Daten wurden gelöscht.')),
    );
  }

  @override
  void initState() {
    super.initState();
    _teamController = TextEditingController();
    _phoneController = TextEditingController();
    _mailController = TextEditingController();

    _lockStorage = AppLockStorage(const FlutterSecureStorage());

    // initState kann context.read nutzen, aber erst nach dem ersten Frame ist es
    // am robustesten (falls Provider später umgebaut wird).
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final enabled = await _lockStorage.readEnabled();
      if (!mounted) return;
      setState(() {
        _appLockEnabled = enabled;
        _lockLoading = false;
      });
      _loadContacts();
    });
  }

  @override
  void dispose() {
    _teamController.dispose();
    _phoneController.dispose();
    _mailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Ladeanzeige, bis Daten geladen sind
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: const AppHeader(title: 'Einstellungen'),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle('Einsatznachsorgeteam', topPadding: 16),
                _CardContainer(
                  child: Column(
                    children: [
                      _LabeledField(
                        label: 'Teamname',
                        controller: _teamController,
                        hint: 'z.B. PSNV Kreis Musterhausen',
                      ),
                      const SizedBox(height: 20),
                      _LabeledField(
                        label: 'Telefonnummer',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        hint: 'z.B. 0150 11211211',
                      ),
                      const SizedBox(height: 20),
                      _LabeledField(
                        label: 'E-mail',
                        controller: _mailController,
                        keyboardType: TextInputType.emailAddress,
                        hint: 'z.B. PSNV@musterwehr.de',
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Button(
                          icon: Icons.save,
                          label: 'Speichern',
                          variant: ButtonVariant.secondary,
                          onPressed: () => _persistContacts(),
                          textStyle: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SectionTitle('Datenschutz & Sicherheit'),
                _CardContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock_outline_rounded,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'App-Sperre',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Geräteeigene Authentifizierung',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.outline,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: _appLockEnabled,
                            onChanged: _lockLoading
                                ? null
                                : (v) => onToggleAppLock(v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Alle Daten werden lokal auf deinem Gerät gespeichert und verlassen das Smartphone nicht.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
                const SectionTitle('Daten verwalten'),
                _CardContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lösche alle gespeicherten Vorsätze und Einstellungen unwiederuflich.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Button(
                          icon: Icons.delete_outline,
                          label: 'Alle Daten löschen',
                          variant: ButtonVariant.alert,
                          onPressed: () => _resetData(),
                          textStyle: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardContainer extends StatelessWidget {
  const _CardContainer({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.controller,
    this.keyboardType,
    required this.hint,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hint,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.outline,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
      ),
    );
  }
}
