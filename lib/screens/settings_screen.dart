import 'package:flutter/material.dart';

import '../widgets/app_header.dart';
import '../widgets/section_title.dart';
import '../widgets/pill.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final TextEditingController _teamController;
  late final TextEditingController _phoneController;
  late final TextEditingController _mailController;
  bool _appLockEnabled = false;

  void _persistContacts() {
    // TODO: persist contact data
  }

  void _resetData() {
    // TODO: implement data reset
  }

  @override
  void initState() {
    super.initState();
    _teamController = TextEditingController();
    _phoneController = TextEditingController();
    _mailController = TextEditingController();
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

    return Scaffold(
      appBar: const AppHeader(title: 'Einstellungen'),
      body: SafeArea(
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
                      child: Pill(
                        icon: Icons.save_outlined,
                        label: 'speichern',
                        onPressed: _persistContacts,
                        backgroundColor: theme.colorScheme.secondaryContainer,
                        foregroundColor: theme.colorScheme.onSecondaryContainer,
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
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Biometrische Authentifizierung',
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
                          onChanged: (value) {
                            setState(() => _appLockEnabled = value);
                            // TODO: persist app lock preference
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Alle Daten werden lokal auf deinem Gerät gespeichert und verlassen die Smartphone nicht.',
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
                      child: Pill(
                        icon: Icons.delete_outline,
                        label: 'alle Daten löschen',
                        alert: true,
                        onPressed: _resetData,
                        backgroundColor: theme.colorScheme.errorContainer,
                        foregroundColor: theme.colorScheme.onErrorContainer,
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
        color: theme.colorScheme.surface,
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
