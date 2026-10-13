import 'package:eike_app/data_database/eike_database.dart';
import 'package:eike_app/feat_home/data/daos/home_dao.dart';
import 'package:eike_app/feat_home/data/datasources/asset_home_datasource.dart';
import 'package:eike_app/feat_home/data/repositories/home_repository_impl.dart';
import 'package:eike_app/feat_tip_detail/presentation/tip_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eike_app/service_design/components/eike_app_bar.dart';
import 'package:eike_app/service_design/theming/eike_theme.dart';

import 'bloc/home_bloc.dart';

enum _TipDetailPresentation {
  fullscreenDialog,
  bottomSheet,
}

const _tipDetailPresentation = _TipDetailPresentation.bottomSheet;

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
            ),
          );
        },
      ),
    );
  }
}

class const _TipCard({
  required final TipEntity tip,
}) extends StatelessWidget {
  void _openTip(BuildContext context) {
    final detail = TipDetailScreen(tipId: tip.id);

    switch (_tipDetailPresentation) {
      case .fullscreenDialog:
        showDialog<void>(
          context: context,
          builder: (context) => Dialog.fullscreen(child: detail),
        );
      case .bottomSheet:
        showModalBottomSheet<void>(
          context: context,
          // Cover the bottom navigation bar, just like the dialog does.
          useRootNavigator: true,
          isScrollControlled: true,
          useSafeArea: true,
          clipBehavior: .antiAlias,
          builder: (context) {
            return FractionallySizedBox(heightFactor: 0.9, child: detail);
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: .antiAlias,
      child: InkWell(
        onTap: () => _openTip(context),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: .stretch,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EikeTheme.cardPadding,
                  child: Row(
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
                        child: Column(
                          crossAxisAlignment: .start,
                          mainAxisAlignment: .center,
                          children: [
                            Text(
                              tip.title,
                              style: context.textTheme.titleSmall?.copyWith(
                                color: context.colors.primary,
                              ),
                            ),
                            Text(
                              tip.description,
                              style: context.textTheme.bodySmall,
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
              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRect(
                        child: Transform.scale(
                          scale: 1.5,
                          child: Image.asset(
                            'assets/images/tip-icon-bg-x2.png',
                            fit: .cover,
                            excludeFromSemantics: true,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(
                          'assets/content/${tip.imagePath}',
                          fit: .contain,
                          // The figure is described on the detail screen.
                          excludeFromSemantics: true,
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
