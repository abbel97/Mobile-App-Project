import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radii.dart';
import '../theme/app_text_styles.dart';

class AppLogo extends StatelessWidget {
	const AppLogo({
		super.key,
		this.showWordmark = true,
		this.wordmarkColor = AppColors.surface,
		this.iconSize = 96,
	});

	final bool showWordmark;
	final Color wordmarkColor;
	final double iconSize;

	@override
	Widget build(BuildContext context) {
		return Column(
			mainAxisSize: MainAxisSize.min,
			children: [
				Container(
					width: iconSize,
					height: iconSize,
					decoration: BoxDecoration(
						color: AppColors.surface,
						borderRadius: BorderRadius.circular(AppRadii.md),
						boxShadow: [
							BoxShadow(
								color: Colors.black.withValues(alpha: 0.16),
								blurRadius: 28,
								offset: const Offset(0, 12),
							),
						],
					),
					alignment: Alignment.center,
					child: Icon(
						Icons.architecture_rounded,
						color: AppColors.primary,
						size: iconSize * 0.44,
					),
				),
				if (showWordmark) ...[
					const SizedBox(height: 26),
					Text(
						'HOME-TWEAK',
						style: AppTextStyles.headline2.copyWith(color: wordmarkColor),
					),
				],
			],
		);
	}
}