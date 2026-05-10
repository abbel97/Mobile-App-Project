import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';

class NotificationScreen extends StatelessWidget {
	const NotificationScreen({super.key});

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
							Text('Notifications', style: AppTextStyles.titleMedium.copyWith(fontSize: 24, color: AppColors.primary)),
							const SizedBox(height: 14),
							const _NotificationCard(
								title: 'Your request has been reviewed',
								subtitle: 'A professional has responded to your new project request.',
								time: '2 hours ago',
								icon: Icons.check_circle_outline_rounded,
								color: AppColors.success,
							),
							const _NotificationCard(
								title: 'Job update available',
								subtitle: 'A job you accepted has a new message from the customer.',
								time: 'Today',
								icon: Icons.work_outline_rounded,
								color: AppColors.primary,
							),
							const _NotificationCard(
								title: 'Support team replied',
								subtitle: 'We have answered your ticket and added next steps.',
								time: 'Yesterday',
								icon: Icons.support_agent_rounded,
								color: AppColors.secondary,
							),
						],
					),
				),
			),
		);
	}
}

class _NotificationCard extends StatelessWidget {
	const _NotificationCard({required this.title, required this.subtitle, required this.time, required this.icon, required this.color});

	final String title;
	final String subtitle;
	final String time;
	final IconData icon;
	final Color color;

	@override
	Widget build(BuildContext context) {
		return Container(
			margin: const EdgeInsets.only(bottom: 12),
			padding: const EdgeInsets.all(16),
			decoration: BoxDecoration(
				color: AppColors.surface,
				borderRadius: BorderRadius.circular(AppRadii.md),
				border: Border.all(color: AppColors.border),
			),
			child: Row(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Container(
						padding: const EdgeInsets.all(12),
						decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(14)),
						child: Icon(icon, color: color),
					),
					const SizedBox(width: 14),
					Expanded(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Text(title, style: AppTextStyles.titleSmall.copyWith(fontSize: 16, color: AppColors.textPrimary)),
								const SizedBox(height: 4),
								Text(subtitle, style: AppTextStyles.bodySmall.copyWith(fontSize: 13, color: AppColors.textBody)),
								const SizedBox(height: 10),
								Text(time, style: AppTextStyles.bodySmall.copyWith(fontSize: 12, color: AppColors.textMuted)),
							],
						),
					),
				],
			),
		);
	}
}