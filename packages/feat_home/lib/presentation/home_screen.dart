import 'package:data_database/eike_database.dart';
import 'package:data_entities/tables/tip_table.dart';
import 'package:feat_home/data/daos/home_dao.dart';
import 'package:feat_home/data/datasources/asset_home_datasource.dart';
import 'package:feat_home/data/repositories/home_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_design/components/eike_app_bar.dart';
import 'package:service_design/theming/eike_theme.dart';

import 'bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HomeBloc(
          HomeRepositoryImpl(
            HomeDao(RepositoryProvider.of(context)),
            const AssetHomeDatasource(),
          ),
          RepositoryProvider.of(context),
        )..add(const HomeEvent.onSetup());
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: EikeAppBar(title: 'Meine 7 Sachen'),
            body: Builder(
              builder: (context) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Die Inhalte konnten nicht geladen werden. Bitte versuche es später erneut.',
                        style: TextTheme.of(context).bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: EikeTheme.pagePadding,
                  itemCount: state.tips.length,
                  itemBuilder: (context, index) {
                    return _TipCard(
                      tip: state.tips[index],
                    );
                  },
                  separatorBuilder: (_, _) {
                    return SizedBox(
                      height: EikeTheme.verticalComponentSpacingMedium,
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _TipCard extends StatefulWidget {
  const _TipCard({required this.tip});

  final TipEntity tip;

  @override
  State<_TipCard> createState() => _TipCardState();
}

class _TipCardState extends State<_TipCard> {
  late final textController = TextEditingController(text: tip.userNote)
    ..addListener(_onChangeListener);

  TipEntity get tip => widget.tip;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void _onChangeListener() {
    BlocProvider.of<HomeBloc>(context).add(
      HomeEvent.onUserNoteChanged(
        tip.id,
        TipUserNote(textController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EikeTheme.cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: EikeTheme.verticalComponentSpacingMedium,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: EikeTheme.horizontalComponentSpacingMedium,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: context.colors.secondaryContainer,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${tip.position}',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colors.onSecondaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    widget.tip.title,
                    style: TextTheme.of(context).titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox.shrink(),
              ],
            ),
            Divider(),
            Center(
              child: SizedBox.square(
                dimension: 250,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/tip-icon-bg-x2.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Image.asset(
                          'assets/content/${widget.tip.imagePath}',
                          fit: BoxFit.contain,
                          semanticLabel: widget.tip.imageDescription,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(widget.tip.description),
            Text(
              'Das mache ich:',
              style: TextTheme.of(context).titleSmall,
            ),
            TextFormField(
              controller: textController,
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
                    color: ColorScheme.of(context).outlineVariant,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: ColorScheme.of(context).outlineVariant,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: ColorScheme.of(context).primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _TipCard extends StatefulWidget {
//   const _TipCard({required this.tip, required this.position});
//
//   final Tip tip;
//   final int position;
//
//   @override
//   State<_TipCard> createState() => _TipCardState();
// }
//
// class _TipCardState extends State<_TipCard> {
//   late final TextEditingController _controller;
//   StreamSubscription<String>? _sub;
//   Timer? _debounce;
//   bool _updatingFromDb = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController();
//
//     // DB-Stream abonnieren und Controller initial (und bei Änderungen) setzen
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   final db = context.read<EikeDatabase>();
//     //   _sub = db.watchUserTipNote(widget.position).listen((note) {
//     //     // Wenn der User gerade tippt und gespeichert wird,
//     //     // nicht mit DB-Update "dazwischenfunken".
//     //     if (_updatingFromDb) return;
//     //
//     //     if (_controller.text != note) {
//     //       _controller.text = note;
//     //     }
//     //   });
//     // });
//     //
//     // _controller.addListener(_onChanged);
//   }
//
//   void _onChanged() {
//     // debounce, damit nicht bei jedem Keypress in DB geschrieben wird
//     // _debounce?.cancel();
//     // _debounce = Timer(const Duration(milliseconds: 1000), () async {
//     //   final db = context.read<AppDatabase>();
//     //   final text = _controller.text;
//     //
//     //   // Markieren, dass das nächste Stream-Update kommen kann
//     //   _updatingFromDb = true;
//     //   try {
//     //     await db.upsertUserTipNote(widget.position, text);
//     //   } finally {
//     //     _updatingFromDb = false;
//     //   }
//     // });
//   }
//
//   @override
//   void dispose() {
//     _debounce?.cancel();
//     _sub?.cancel();
//     _controller.removeListener(_onChanged);
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final textTheme = theme.textTheme;
//
//     return Container(
//       decoration: BoxDecoration(
//         color: theme.colorScheme.surfaceContainerLow,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: theme.colorScheme.outlineVariant),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.04),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 _NumberBadge(position: widget.position),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Text(
//                     widget.tip.title,
//                     style: textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Center(
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   final width = (constraints.maxWidth * 0.7).clamp(0.0, 200.0);
//                   return SizedBox(
//                     width: width,
//                     height: width,
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         Image.asset(
//                           'assets/images/tip-icon-bg-x2.png',
//                           fit: BoxFit.contain,
//                         ),
//                         Transform.scale(
//                           scale: 0.8,
//                           child: Image.asset(
//                             widget.tip.imagePath,
//                             fit: BoxFit.contain,
//                             alignment: Alignment.center,
//                             errorBuilder: (context, error, stackTrace) =>
//                                 Container(
//                                   color:
//                                       theme.colorScheme.surfaceContainerHighest,
//                                   alignment: Alignment.center,
//                                   child: Icon(
//                                     Icons.image_not_supported_outlined,
//                                     color: theme.colorScheme.onSurfaceVariant,
//                                     size: 32,
//                                   ),
//                                 ),
//                             semanticLabel: widget.tip.alt,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               widget.tip.description,
//               style: textTheme.bodyMedium?.copyWith(
//                 color: theme.colorScheme.onSurfaceVariant,
//                 height: 1.35,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Das mache ich:',
//               style: textTheme.titleSmall?.copyWith(
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             const SizedBox(height: 8),
//
//             // ✅ Persistentes Feld
//             TextFormField(
//               controller: _controller,
//               maxLines: 2,
//               decoration: InputDecoration(
//                 hintText: 'Schreib deine Idee hier auf...',
//                 suffixIcon: const Icon(Icons.edit_outlined),
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 12,
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(
//                     color: theme.colorScheme.outlineVariant,
//                   ),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(
//                     color: theme.colorScheme.outlineVariant,
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: theme.colorScheme.primary),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _NumberBadge extends StatelessWidget {
//   const _NumberBadge({required this.position});
//
//   final int position;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Container(
//       height: 36,
//       width: 36,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: theme.colorScheme.primary.withValues(alpha: 0.1),
//       ),
//       alignment: Alignment.center,
//       child: Text(
//         position.toString(),
//         style: theme.textTheme.titleMedium?.copyWith(
//           color: theme.colorScheme.primary,
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//     );
//   }
// }
