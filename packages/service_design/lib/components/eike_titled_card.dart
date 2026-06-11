import 'package:flutter/material.dart';
import 'package:service_design/theming/eike_theme.dart';

class EikeTitledCard extends StatelessWidget {
  const EikeTitledCard({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.child,
  });

  final String title;
  final Widget? leading;
  final Widget? trailing;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: EikeTheme.cardPadding,
        child: Column(
          children: [
            Theme(
              data: theme.copyWith(
                iconTheme: theme.iconTheme.copyWith(
                  color: context.colors.primary,
                ),
              ),
              child: SizedBox(
                height: 48.0,
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        spacing: EikeTheme.horizontalComponentSpacingSmall,
                        children: [
                          ?leading,
                          Text(
                            title,
                            style: context.textTheme.titleMedium?.copyWith(
                              color: context.colors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ?trailing,
                  ],
                ),
              ),
            ),
            if (child != null) ...[
              Divider(color: context.colors.primary),
              const SizedBox(
                height: EikeTheme.verticalComponentSpacingMedium,
              ),
              ?child,
            ],
          ],
        ),
      ),
    );
  }
}
