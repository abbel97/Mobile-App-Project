import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/professional_bottom_nav_bar.dart';

class AcceptedJobsScreen extends StatelessWidget {
	const AcceptedJobsScreen({super.key});

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
								child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primary)), Text('Recent Jobs', style: AppTextStyles.titleMedium.copyWith(fontSize: 24, color: AppColors.primary)), Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.neutral, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.person_outline_rounded, color: AppColors.primary, size: 20))]), const SizedBox(height: 30), Text('My Recent Jobs', style: AppTextStyles.headline2.copyWith(fontSize: 36, color: AppColors.textPrimary)), const SizedBox(height: 20), const _RecentJobCard(accentColor: Color(0xFF0A6C5B), title: 'Master Ensuite HVAC Integration', status: 'IN PROGRESS', customer: 'Customer Name', schedule: 'Today, 2:30 PM', location: '6Kilo, Addis.A', serviceType: 'System Install'), const _RecentJobCard(accentColor: Color(0xFFCFCFF5), title: 'Smart Lighting Commissioning', status: 'ASSIGNED', customer: 'Abebe Kebede', schedule: 'Tomorrow, 09:00 AM', location: 'Brooklyn, NY', serviceType: 'Automation Tech'), const _RecentJobCard(accentColor: Color(0xFFCFCFF5), title: 'Polished Concrete Surface Seal', status: 'ASSIGNED', customer: 'Abebe Kebede', schedule: 'Friday, 1:00 PM', location: 'Bole, Addis.A', serviceType: 'Finishing')]),
							),
						),
						ProfessionalBottomNavBar(currentIndex: 1, onTap: (index) {
							switch (index) {
								case 0:
									context.go(AppRoutes.professionalDashboard);
									break;
								case 2:
									context.go(AppRoutes.professionalsList);
									break;
								case 3:
									context.go(AppRoutes.professionalSettings);
									break;
							}
						}),
					],
				),
			),
		);
	}
}

class _RecentJobCard extends StatelessWidget {
	const _RecentJobCard({required this.accentColor, required this.title, required this.status, required this.customer, required this.schedule, required this.location, required this.serviceType});

	final Color accentColor;
	final String title;
	final String status;
	final String customer;
	final String schedule;
	final String location;
	final String serviceType;

	@override
	Widget build(BuildContext context) {
		return Container(margin: const EdgeInsets.only(bottom: 18), padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppRadii.md), border: Border(left: BorderSide(color: accentColor, width: 4))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Expanded(child: Text(title, style: AppTextStyles.titleSmall.copyWith(fontSize: 18, color: AppColors.textPrimary))), Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: accentColor.withValues(alpha: 0.16), borderRadius: BorderRadius.circular(4)), child: Text(status, style: AppTextStyles.labelMedium.copyWith(color: accentColor, fontSize: 11)))]), const SizedBox(height: 8), Row(children: [const Icon(Icons.person_outline_rounded, size: 16, color: AppColors.tertiary), const SizedBox(width: 6), Text(customer, style: AppTextStyles.bodySmall)]), const SizedBox(height: 16), Row(children: [Expanded(child: _LabelValue(label: 'SCHEDULE', value: schedule)), Expanded(child: _LabelValue(label: 'LOCATION', value: location))]), const SizedBox(height: 20), Row(children: [Expanded(child: _LabelValue(label: 'SERVICE TYPE', value: serviceType)), SizedBox(width: 96, height: 40, child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(foregroundColor: AppColors.primary, side: const BorderSide(color: Color(0xFFD0D5DD)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))), child: const Text('Details')))])]));
	}
}

class _LabelValue extends StatelessWidget {
	const _LabelValue({required this.label, required this.value});

	final String label;
	final String value;

	@override
	Widget build(BuildContext context) {
		return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: AppTextStyles.labelMedium.copyWith(fontSize: 10)), const SizedBox(height: 4), Text(value, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary))]);
	}
}
