import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';

class JobDetailsScreen extends StatelessWidget {
  final String jobId;
	const JobDetailsScreen({super.key, required this.jobId});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: AppColors.background,
			body: SafeArea(
				child: SingleChildScrollView(
					padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Row(
								children: [
									IconButton(
										onPressed: () => context.pop(),
										icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primary),
									),
									Text('Job Details', style: AppTextStyles.titleMedium.copyWith(fontSize: 24, color: AppColors.primary)),
								],
							),
							const SizedBox(height: 14),
							Container(
								padding: const EdgeInsets.all(20),
								decoration: BoxDecoration(
									color: AppColors.surface,
									borderRadius: BorderRadius.circular(AppRadii.md),
									border: Border.all(color: AppColors.border),
								),
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Text('Residential Electrical Panel Upgrade', style: AppTextStyles.titleLarge.copyWith(fontSize: 26, color: AppColors.textPrimary)),
										const SizedBox(height: 8),
										Text('Paris, France', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted)),
										const SizedBox(height: 18),
										Text('Project Overview', style: AppTextStyles.titleSmall.copyWith(fontSize: 18, color: AppColors.primary)),
										const SizedBox(height: 8),
										Text('Looking for a licensed electrician to upgrade a 100-amp service to 200-amp in a brownstone. Permits required. Urgent start preferred.', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textBody)),
										const SizedBox(height: 18),
										Wrap(
											spacing: 10,
											runSpacing: 10,
											children: const [
												_Tag(label: 'Licensed'),
												_Tag(label: 'Permits'),
												_Tag(label: 'Urgent'),
											],
										),
									],
								),
							),
							const SizedBox(height: 24),
							PrimaryButton(label: 'Accept Job', onPressed: () {}, height: 56),
							const SizedBox(height: 12),
							SizedBox(
								width: double.infinity,
								height: 56,
								child: OutlinedButton(
									onPressed: () => context.pop(),
									style: OutlinedButton.styleFrom(
										backgroundColor: AppColors.surface,
										foregroundColor: AppColors.primary,
										side: const BorderSide(color: AppColors.border),
										shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
									),
									child: const Text('Back'),
								),
							),
						],
					),
				),
			),
		);
	}
}

class _Tag extends StatelessWidget {
	const _Tag({required this.label});

	final String label;

	@override
	Widget build(BuildContext context) {
		return Container(
			padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
			decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(20)),
			child: Text(label, style: AppTextStyles.labelMedium.copyWith(fontSize: 12, color: AppColors.primary)),
		);
	}
}