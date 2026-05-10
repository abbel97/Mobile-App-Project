import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
	const SplashScreen({super.key});
	@override
	State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
	@override
	void initState() {
		super.initState();

		Future.delayed(
			const Duration(seconds: 5),() {
				if (mounted) {
					context.go('/home');
				}
			},
		);
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: AppColors.primary,
			body: SafeArea(
				child: Center(
					child: Column(
						mainAxisSize: MainAxisSize.min,
						children: [
							Container(
								width: 112,
								height: 112,
								decoration: BoxDecoration(
									color: AppColors.surface,
									borderRadius: BorderRadius.circular(24),
								),
								child: const Icon(
									Icons.architecture_rounded,
									color: AppColors.primary,
									size: 62,
								),
							),

							const SizedBox(height: 28),
							Text('HOME-TWEAK',
								style: AppTextStyles.headline2.copyWith(
									color: AppColors.surface,
								),
							),

							const SizedBox(height: 10),

							Text(
								'Home service management',
								style: AppTextStyles.bodyMedium.copyWith(
									color: AppColors.neutral.withOpacity(0.8),
								),
							),

							const SizedBox(height: 40),
							const CircularProgressIndicator(
								color: AppColors.surface,
								strokeWidth: 3,
							),
						],
					),
				),
			),
		);
	}
}