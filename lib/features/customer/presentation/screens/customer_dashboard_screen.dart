import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/customer_bottom_nav_bar.dart';

class CustomerDashboardScreen extends StatelessWidget {
	const CustomerDashboardScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: AppColors.background,
			body: SafeArea(
				child: Column(
					children: [
						Expanded(
							child: SingleChildScrollView(
								padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										const _Header(),
										const SizedBox(height: 28),
										Text('Hello, xyz', style: AppTextStyles.headline2),
										const SizedBox(height: 10),
										Text(
											'Your Home is in Good hands. Need\nsomething fixed today?',
											style: AppTextStyles.bodyMedium,
										),

										const SizedBox(height: 28),
										const _EmergencyCard(),
										const SizedBox(height: 28),
										Text('Recent Requests', style: AppTextStyles.titleLarge.copyWith(fontSize: 24)),
										const SizedBox(height: 16),
										const _RequestPreviewCard(
											accentColor: AppColors.success,
											icon: Icons.handyman_rounded,
											title: 'Kitchen Sink Leakage',
											subtitle: 'Technician In Route',
										),

										const SizedBox(height: 16),
										const _RequestPreviewCard(
											accentColor: Color(0xFFC9C9DA),
											icon: Icons.lightbulb_rounded,
											title: 'Smart Light Installation',
											subtitle: 'Scheduled for June 24',
										),
                    
										const SizedBox(height: 28),
										Text('Explore Services', style: AppTextStyles.titleLarge.copyWith(fontSize: 24)),
										const SizedBox(height: 16),
										const _ServicePanel(
											icon: Icons.warning_amber_rounded,
											title: 'Emergency Repair',
											description: 'Emergency repairs are immediate, unplanned actions taken to fix failures that pose an urgent threat to safety, security, or critical operations. Our professionals are aloways here to give you an instantaneous response to stop further damage or harm',
											isExpanded: false,
										),

										const SizedBox(height: 12),
										const _ServicePanel(
											icon: Icons.phonelink_setup_rounded,
											title: 'Smart Installation',
											description:
												'Upgrade your home with intelligent lighting, security cameras, and climate control systems installed by certified experts.',
											isExpanded: true,
										),

										const SizedBox(height: 12),
										const _ServicePanel(
											icon: Icons.water_drop_outlined,
											title: 'Water Leakage',
											description: 'Water leakage often goes unnoticed, with a typical household wasting nearly 3,000 gallons of water annually from small leaks. Common indicators include sudden spikes in water bills, mold growth, or soft spots on floors, and the most common causes are faulty toilet flappers, dripping faucets, or burst underground',
											isExpanded: false,
										),
										const SizedBox(height: 24),
										const _SupportCard(),
									],
								),
							),
						),

						CustomerBottomNavBar(
							currentIndex: 0,
							onTap: (index) {
								switch (index) {
									case 1:
										context.go(AppRoutes.customerRequests);
										break;
									case 2:
										context.go(AppRoutes.professionalsList);
										break;
									case 3:
										context.go(AppRoutes.customerSettings);
										break;
								}
							},
						),
					],
				),
			),
		);
	}
}

class _Header extends StatelessWidget {
	const _Header();

	@override
	Widget build(BuildContext context) {
		return Row(
			children: [
				Container(
					width: 30,
					height: 30,
					decoration: BoxDecoration(color: AppColors.neutral, borderRadius: BorderRadius.circular(9)),
					child: const Icon(Icons.architecture_rounded, color: AppColors.primary, size: 18),
				),
				const SizedBox(width: 12),
				Text('HOME-TWEAK', style: AppTextStyles.titleMedium.copyWith(fontSize: 22, color: AppColors.primary)),
			],
		);
	}
}

class _EmergencyCard extends StatelessWidget {
	const _EmergencyCard();

	@override
	Widget build(BuildContext context) {
		return Container(
			width: double.infinity,
			padding: const EdgeInsets.all(24),
			decoration: BoxDecoration(
				color: AppColors.primary,
				borderRadius: BorderRadius.circular(28),
				boxShadow: [
					BoxShadow(
						color: AppColors.primary.withValues(alpha: 0.25),
						blurRadius: 30,
						offset: const Offset(0, 12),
					),
				],
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Container(
						width: 54,
						height: 54,
						decoration: BoxDecoration(
							color: AppColors.surface.withValues(alpha: 0.22),
							shape: BoxShape.circle,
						),
						child: const Icon(Icons.warning_amber_rounded, color: AppColors.surface),
					),
					const SizedBox(height: 26),
					Text(
						"Something not\nworking?\nWe're here to help.",
						style: AppTextStyles.titleLarge.copyWith(color: AppColors.surface),
					),
					const SizedBox(height: 22),
					SizedBox(
						width: 214,
						height: 56,
						child: ElevatedButton(
							onPressed: () {},
							style: ElevatedButton.styleFrom(
								backgroundColor: AppColors.neutral,
								foregroundColor: AppColors.primary,
								elevation: 0,
								shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
							),
							child: Text('Report an Issue', style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary)),
						),
					),
				],
			),
		);
	}
}

class _RequestPreviewCard extends StatelessWidget {
	const _RequestPreviewCard({
		required this.accentColor,
		required this.icon,
		required this.title,
		required this.subtitle,
	});

	final Color accentColor;
	final IconData icon;
	final String title;
	final String subtitle;

	@override
	Widget build(BuildContext context) {
		return Container(
			padding: const EdgeInsets.all(16),
			decoration: BoxDecoration(
				color: AppColors.card,
				borderRadius: BorderRadius.circular(AppRadii.md),
				border: Border(left: BorderSide(color: accentColor, width: 4)),
			),
			child: Row(
				children: [
					Container(
						width: 56,
						height: 56,
						decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppRadii.sm)),
						child: Icon(icon, color: AppColors.primary, size: 28),
					),
					const SizedBox(width: 14),
					Expanded(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Text(title, style: AppTextStyles.titleSmall.copyWith(fontSize: 17)),
								const SizedBox(height: 4),
								Text(subtitle, style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondary)),
							],
						),
					),
					const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 30),
				],
			),
		);
	}
}

class _ServicePanel extends StatelessWidget {
	const _ServicePanel({
		required this.icon,
		required this.title,
		required this.description,
		required this.isExpanded,
	});

	final IconData icon;
	final String title;
	final String description;
	final bool isExpanded;

	@override
	Widget build(BuildContext context) {
		return Container(
			decoration: BoxDecoration(
				color: AppColors.card,
				borderRadius: BorderRadius.circular(AppRadii.md),
			),
			child: Theme(
				data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
				child: ExpansionTile(
					initiallyExpanded: isExpanded,
					tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
					childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
					leading: Icon(icon, color: AppColors.primary, size: 26),
					title: Text(title, style: AppTextStyles.titleSmall.copyWith(fontSize: 18, color: AppColors.textPrimary)),
					iconColor: AppColors.tertiary,
					collapsedIconColor: AppColors.tertiary,
					children: [
						if (description.isNotEmpty)
							Padding(
								padding: const EdgeInsets.only(left: 2, top: 2),
								child: Text(description, style: AppTextStyles.bodyMedium.copyWith(fontSize: 15)),
							),
					],
				),
			),
		);
	}
}

class _SupportCard extends StatelessWidget {
	const _SupportCard();

	@override
	Widget build(BuildContext context) {
		return Container(
			width: double.infinity,
			padding: const EdgeInsets.all(22),
			decoration: BoxDecoration(
				color: const Color(0xFF334158),
				borderRadius: BorderRadius.circular(18),
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Text(
						'Need Help Immediately?',
						style: AppTextStyles.titleLarge.copyWith(color: AppColors.surface, fontSize: 22),
					),
					const SizedBox(height: 12),
					Text(
						'Our premium support line is open 24/7 for\nHome-Tweak Pro members.',
						style: AppTextStyles.bodyMedium.copyWith(color: AppColors.neutral.withValues(alpha: 0.7), fontSize: 14),
					),
					const SizedBox(height: 20),
					SizedBox(
						width: 210,
						height: 52,
						child: OutlinedButton.icon(
							onPressed: () {},
							style: OutlinedButton.styleFrom(
								foregroundColor: AppColors.surface,
								shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
								backgroundColor: AppColors.surface.withValues(alpha: 0.1),
							),
							icon: const Icon(Icons.call_outlined, size: 18),
							label: const Text('Call Support'),
						),
					),
				],
			),
		);
	}
}
