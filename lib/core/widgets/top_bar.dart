import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
	const TopBar({
		super.key,
		required this.title,
		this.onBack,
		this.showBack = true,
    this.actions,
	});

	final String title;
	final VoidCallback? onBack;
	final bool showBack;
	final List<Widget>? actions;
	@override
	Widget build(BuildContext context) {
		return AppBar(
      actions: actions,
			backgroundColor: AppColors.background,
			automaticallyImplyLeading: false,
			leadingWidth: 44,
			leading: showBack
					? IconButton(
							onPressed: onBack ?? () => context.pop(),
							icon: const Icon(Icons.arrow_back, color: AppColors.primary),
						)
					: null,
			titleSpacing: showBack ? 0 : 24,
			title: Text(
				title,
				style: AppTextStyles.titleMedium,
			),
		);
	}

	@override
	Size get preferredSize => const Size.fromHeight(kToolbarHeight + 6);
}
