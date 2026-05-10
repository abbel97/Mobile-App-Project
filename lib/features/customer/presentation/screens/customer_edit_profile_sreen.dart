import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';

class CustomerEditProfileScreen extends StatelessWidget {
	const CustomerEditProfileScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: AppColors.background,
			body: SafeArea(
				child: SingleChildScrollView(
					padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Row(
								children: [
									IconButton(
										onPressed: () => context.pop(),
										icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primary),
									),
									Text('Profile Information', style: AppTextStyles.titleMedium.copyWith(fontSize: 24, color: AppColors.primary)),
								],
							),
							const SizedBox(height: 24),
							Center(
								child: Column(
									children: [
										Stack(
											clipBehavior: Clip.none,
											children: [
												Container(
													width: 112,
													height: 112,
													decoration: BoxDecoration(
														color: AppColors.neutral,
														borderRadius: BorderRadius.circular(8),
													),
													child: const Icon(Icons.person_outline_rounded, size: 72, color: AppColors.textPrimary),
												),
												Positioned(
													right: -4,
													bottom: -4,
													child: Container(
														width: 28,
														height: 28,
														decoration: BoxDecoration(
															color: AppColors.surface,
															borderRadius: BorderRadius.circular(6),
															boxShadow: [
																BoxShadow(color: Colors.black.withValues(alpha: 0.12), blurRadius: 8),
															],
														),
														child: const Icon(Icons.photo_camera_outlined, size: 14, color: AppColors.primary),
													),
												),
											],
										),
										const SizedBox(height: 18),
										Text('Your Name', style: AppTextStyles.titleLarge.copyWith(fontSize: 30, color: AppColors.textPrimary)),
									],
								),
							),
							const SizedBox(height: 26),
							Container(
								decoration: BoxDecoration(
									color: AppColors.surface,
									borderRadius: BorderRadius.circular(10),
									border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
								),
								child: Column(
									children: const [
										_ProfileField(label: 'FULL NAME', value: 'Your Name', icon: Icons.edit_outlined),
										_DividerLine(),
										_ProfileField(label: 'EMAIL ADDRESS', value: 'youremail@gmail.com', icon: Icons.edit_outlined),
										_DividerLine(),
										_ProfileField(label: 'PRIMARY LOCATION', value: '123 Bole Street', icon: Icons.place_outlined),
									],
								),
							),
							const SizedBox(height: 32),
							PrimaryButton(label: 'Save Changes', onPressed: () {}, height: 54),
						],
					),
				),
			),
		);
	}
}

class _DividerLine extends StatelessWidget {
	const _DividerLine();

	@override
	Widget build(BuildContext context) {
		return const Divider(height: 1, color: AppColors.border);
	}
}

class _ProfileField extends StatelessWidget {
	const _ProfileField({required this.label, required this.value, required this.icon});

	final String label;
	final String value;
	final IconData icon;

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
			child: Row(
				children: [
					Expanded(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Text(label, style: AppTextStyles.labelMedium.copyWith(fontSize: 12)),
								const SizedBox(height: 10),
								Text(value, style: AppTextStyles.bodyRegular.copyWith(fontSize: 18, color: AppColors.textPrimary)),
							],
						),
					),
					Icon(icon, color: AppColors.textMuted, size: 18),
				],
			),
		);
	}
}
