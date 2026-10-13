import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/data_entities/tables/tip_table.dart';
import 'package:eike_app/feat_tip_detail/data/daos/tip_detail_dao.dart';
import 'package:eike_app/feat_tip_detail/data/repositories/tip_detail_repository_impl.dart';
import 'package:eike_app/service_design/components/eike_app_bar.dart';
import 'package:eike_app/service_design/theming/eike_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/tip_detail_bloc.dart';

class TipDetailScreen extends StatelessWidget {
  const TipDetailScreen({required this.tipId, super.key});

  final TipId tipId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return TipDetailBloc(
          tipId,
          TipDetailRepositoryImpl(
            TipDetailDao(RepositoryProvider.of(context)),
          ),
          RepositoryProvider.of(context),
        )..add(const TipDetailEvent.onSetup());
      },
      child: BlocBuilder<TipDetailBloc, TipDetailState>(
        builder: (context, state) {
          final tip = state.tip;

          return Scaffold(
            appBar: EikeAppBar(
              leading: const CloseButton(),
              title: tip == null ? 'Meine 7 Sachen' : 'Tipp ${tip.position}',
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              behavior: HitTestBehavior.opaque,
              child: Builder(
                builder: (context) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (tip == null) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Dieser Tipp konnte nicht geladen werden.',
                          style: TextTheme.of(context).bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  return ListView(
                    keyboardDismissBehavior: .onDrag,
                    padding: EikeTheme.pagePadding,
                    children: [
                      _TipDetailContent(key: ValueKey(tip.id), tip: tip),
                      SizedBox(height: MediaQuery.paddingOf(context).bottom),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TipDetailContent extends StatefulWidget {
  const _TipDetailContent({required this.tip, super.key});

  final TipEntity tip;

  @override
  State<_TipDetailContent> createState() => _TipDetailContentState();
}

class _TipDetailContentState extends State<_TipDetailContent> {
  late final textController = TextEditingController(text: tip.userNote)
    ..addListener(_onChangeListener);

  TipEntity get tip => widget.tip;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void _onChangeListener() {
    BlocProvider.of<TipDetailBloc>(context).add(
      TipDetailEvent.onUserNoteChanged(TipUserNote(textController.text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: EikeTheme.verticalComponentSpacingMedium,
      crossAxisAlignment: .start,
      children: [
        Row(
          spacing: EikeTheme.horizontalComponentSpacingSmall,
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
            Expanded(
              child: Text(
                tip.title,
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
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
                      'assets/content/${tip.imagePath}',
                      fit: BoxFit.contain,
                      semanticLabel: tip.imageDescription,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Text(tip.description),
        if (tip.question case TipQuestion question)
          Column(
            spacing: EikeTheme.verticalComponentSpacingSmall,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question,
                style: TextTheme.of(context).titleSmall,
              ),
              TextFormField(
                controller: textController,
                minLines: 2,
                maxLines: null,
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
      ],
    );
  }
}
