import 'package:data_database/eike_database.dart';
import 'package:data_entities/tables/tip_table.dart';
import 'package:feat_home/data/daos/home_dao.dart';
import 'package:feat_home/data/datasources/asset_home_datasource.dart';
import 'package:feat_home/data/repositories/home_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_design/components/eike_app_bar.dart';
import 'package:service_design/components/eike_titled_card.dart';
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
                      index: index + 1,
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
  const _TipCard({required this.tip, required this.index});

  final TipEntity tip;
  final int index;

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
          '${widget.index}',
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
    );
  }
}
