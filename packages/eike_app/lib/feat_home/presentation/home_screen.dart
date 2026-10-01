import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/data_entities/tables/tip_table.dart';
import 'package:eike_app/feat_home/data/daos/home_dao.dart';
import 'package:eike_app/feat_home/data/datasources/asset_home_datasource.dart';
import 'package:eike_app/feat_home/data/repositories/home_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eike_app/service_design/components/eike_app_bar.dart';
import 'package:eike_app/service_design/components/eike_titled_card.dart';
import 'package:eike_app/service_design/theming/eike_theme.dart';

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
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              behavior: HitTestBehavior.opaque,
              child: Builder(
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
                    keyboardDismissBehavior: .onDrag,
                    padding: EikeTheme.pagePadding,
                    itemCount: state.tips.length + 1,
                    itemBuilder: (context, index) {
                      if (index == state.tips.length) {
                        return SizedBox(
                          height: MediaQuery.paddingOf(context).bottom,
                        );
                      }

                      return _TipCard2(
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
            ),
          );
        },
      ),
    );
  }
}

// TODO(Felix): Refactor BlockSemantics on this tip card so it does not get read entirely
// as soon as the focus is on the card. Instead, only the title should be read and the rest
// of the content should be read when the user navigates through the card with a screen reader.
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
    return EikeTitledCard(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: context.colors.secondaryContainer,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          '${widget.tip.position}',
          style: context.textTheme.titleMedium?.copyWith(
            color: context.colors.onSecondaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: widget.tip.title,
      child: Column(
        spacing: EikeTheme.verticalComponentSpacingMedium,
        children: [
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
          if (widget.tip.question case TipQuestion question)
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
      ),
    );
  }
}

class const _TipCard2({required final TipEntity tip}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
      crossAxisAlignment: .start,
        children: [
          SizedBox(
            width: 100,
            child: Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: .only(
                      topLeft: .circular(10),
                      topRight: .circular(50),
                      bottomLeft: .circular(50),
                      bottomRight: .circular(50),
                    ),
                    color: context.colors.primary,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/tip-icon-bg-x2.png',
                      fit: .cover,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(
                      'assets/content/${tip.imagePath}',
                      fit: .contain,
                      semanticLabel: tip.imageDescription,
                    ),
                  ),
                ),
                Positioned(
                  left: 5,
                  top: 5,
                  child: Text(
                    tip.position.toString(),
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.colors.onPrimary,
                      fontWeight: .w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: EikeTheme.cardPadding,
              child: Row(
                spacing: EikeTheme.horizontalComponentSpacingMedium,
                children: [
                  // Container(
                  //   alignment: .center,
                  //   width: 40,
                  //   height: 40,
                  //   decoration: BoxDecoration(
                  //     shape: .circle,
                  //     color: context.colors.tertiaryContainer,
                  //   ),
                  //   child: Text(
                  //     tip.position.toString(),
                  //     style: context.textTheme.titleMedium?.copyWith(
                  //       color: context.colors.onTertiaryContainer,
                  //     ),
                  //   ),
                  // ),
                  Flexible(
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: .start,
                      children: [
                        Text(tip.title, style: context.textTheme.titleMedium),
                        Text(
                          tip.description,
                          maxLines: 2,
                          overflow: .ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
