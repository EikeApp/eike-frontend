import 'package:flutter/material.dart';

import '../models/tip.dart';

class TipCard extends StatelessWidget {
	const TipCard({
		required this.tip,
		required this.position,
		super.key,
	});

	final Tip tip;
	final int position;

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
								_NumberBadge(position: position),
								const SizedBox(width: 12),
								Expanded(
									child: Text(
										tip.title,
										style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
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
										tip.imagePath,
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
										semanticLabel: tip.alt,
									),
								),
							),
						),
						const SizedBox(height: 16),
						Text(
							tip.description,
							style: textTheme.bodyMedium?.copyWith(
								color: theme.colorScheme.onSurfaceVariant,
								height: 1.35,
							),
						),
						const SizedBox(height: 16),
						Text(
							'Das mache ich:',
							style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
						),
						const SizedBox(height: 8),
						TextFormField(
							initialValue: '',
							maxLines: 2,
							decoration: InputDecoration(
								hintText: 'Schreib deine Idee hier auf...',
								suffixIcon: const Icon(Icons.edit_outlined),
								contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
