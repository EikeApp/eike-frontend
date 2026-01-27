import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

import '../db/app_database.dart';

import '../models/tip.dart';
import '../widgets/app_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<List<Tip>> _tipsFuture;

  @override
  void initState() {
    super.initState();
    _tipsFuture = _loadTips();
  }

  Future<List<Tip>> _loadTips() async {
    final jsonString = await rootBundle.loadString('assets/content/data.json');
    final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
    final tips = (jsonData['data']?['flyer']?['tips'] as List?) ?? <dynamic>[];

    return tips
        .whereType<Map>()
        .map((tip) => Tip.fromJson(tip.cast<String, dynamic>()))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const AppHeader(title: 'Meine 7 Sachen'),
      body: SafeArea(
        child: FutureBuilder<List<Tip>>(
          future: _tipsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Die Inhalte konnten nicht geladen werden. Bitte versuche es später erneut.',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            final tips = snapshot.data ?? <Tip>[];
            if (tips.isEmpty) {
              return Center(
                child: Text(
                  'Keine Inhalte gefunden.',
                  style: theme.textTheme.bodyMedium,
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              itemCount: tips.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) =>
                  _TipCard(tip: tips[index], position: index + 1),
            );
          },
        ),
      ),
    );
  }
}

class _TipCard extends StatefulWidget {
  const _TipCard({required this.tip, required this.position});

  final Tip tip;
  final int position;

  @override
  State<_TipCard> createState() => _TipCardState();
}

class _TipCardState extends State<_TipCard> {
  late final TextEditingController _controller;
  StreamSubscription<String>? _sub;
  Timer? _debounce;
  bool _updatingFromDb = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    // DB-Stream abonnieren und Controller initial (und bei Änderungen) setzen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final db = context.read<AppDatabase>();
      _sub = db.watchUserTipNote(widget.position).listen((note) {
        // Wenn der User gerade tippt und gespeichert wird,
        // nicht mit DB-Update "dazwischenfunken".
        if (_updatingFromDb) return;

        if (_controller.text != note) {
          _controller.text = note;
        }
      });
    });

    _controller.addListener(_onChanged);
  }

  void _onChanged() {
    // debounce, damit nicht bei jedem Keypress in DB geschrieben wird
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      final db = context.read<AppDatabase>();
      final text = _controller.text;

      // Markieren, dass das nächste Stream-Update kommen kann
      _updatingFromDb = true;
      try {
        await db.upsertUserTipNote(widget.position, text);
      } finally {
        _updatingFromDb = false;
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _sub?.cancel();
    _controller.removeListener(_onChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _NumberBadge(position: widget.position),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.tip.title,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    widget.tip.imagePath,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: theme.colorScheme.surfaceContainerHighest,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: theme.colorScheme.onSurfaceVariant,
                        size: 32,
                      ),
                    ),
                    semanticLabel: widget.tip.alt,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.tip.description,
              style: textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Das mache ich:',
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),

            // ✅ Persistentes Feld
            TextFormField(
              controller: _controller,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'Schreib deine Idee hier auf...',
                suffixIcon: const Icon(Icons.edit_outlined),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: theme.colorScheme.outlineVariant,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: theme.colorScheme.outlineVariant,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: theme.colorScheme.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NumberBadge extends StatelessWidget {
  const _NumberBadge({required this.position});

  final int position;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.primary.withValues(alpha: 0.1),
      ),
      alignment: Alignment.center,
      child: Text(
        position.toString(),
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
