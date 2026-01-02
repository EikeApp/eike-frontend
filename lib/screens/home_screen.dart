import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/tip.dart';
import '../widgets/tip_card.dart';

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
    final background = const Color(0xFFF5F6FA);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: Text(
          'Meine 7 Sachen',
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(height: 1, color: theme.colorScheme.outlineVariant),
          ),
        ),
      ),
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
              itemBuilder: (context, index) => TipCard(
                tip: tips[index],
                position: index + 1,
              ),
            );
          },
        ),
      ),
    );
  }
}
