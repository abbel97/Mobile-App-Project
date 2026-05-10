import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/professional_bottom_nav_bar.dart';

class JobsScreen extends StatelessWidget {
	const JobsScreen({super.key});

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
								child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Container(width: 34, height: 34, decoration: BoxDecoration(color: AppColors.neutral, borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.person, color: AppColors.primary, size: 20)), const SizedBox(width: 14), Text('HOME-TWEAK', style: AppTextStyles.titleMedium.copyWith(fontSize: 22, color: AppColors.primary))]), const SizedBox(height: 30), Text('Check recent posted\njobs', style: AppTextStyles.headline2.copyWith(fontSize: 38, height: 1.05, color: AppColors.textPrimary)), const SizedBox(height: 18), SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: const [_Pill(label: 'All Jobs', selected: true), SizedBox(width: 14), _Pill(label: 'Electrical'), SizedBox(width: 14), _Pill(label: 'Plumbing'), SizedBox(width: 14), _Pill(label: 'Landscaping')])), const SizedBox(height: 24), const _JobCard(category: 'CARPENTER', location: 'Paris, France', title: 'Residential Electrical Panel Upgrade', description: 'Looking for a licensed electrician to upgrade a 100-amp service to 200-amp in a brownstone. Permits required. Urgent start preferred.'), const _JobCard(category: 'MAINTENANCE', location: 'Hawassa, Eth', title: 'Commercial HVAC Seasonal Inspection', description: 'Quarterly inspection for a 5,000 sq ft office space. Focus on filter replacement, refrigerant checks, and thermostat calibration.', subLabel: 'Estimated'), const _JobCard(category: 'ELECTRICIAN', location: 'DC, USA', title: 'Smart Home Lighting Design & Install', description: 'New construction requiring full Lutron integration across 4 zones. Design consult needed before final installation phase.', subLabel: 'Project Budget'), const _JobCard(category: 'PLUMBING', location: '4Kilo, A.A', title: 'Gourmet Kitchen Faucet Replacement', description: 'Installation of a high-end touchless faucet. Under-sink filter also needs reconnection. Easy 1-hour job for a skilled Pro.')]),
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

class _Pill extends StatelessWidget {
	const _Pill({required this.label, this.selected = false});

	final String label;
	final bool selected;

	@override
	Widget build(BuildContext context) {
		return Container(padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12), decoration: BoxDecoration(color: selected ? AppColors.primary : AppColors.card, borderRadius: BorderRadius.circular(6)), child: Text(label, style: AppTextStyles.titleSmall.copyWith(fontSize: 16, color: selected ? AppColors.surface : AppColors.textBody)));
	}
}

class _JobCard extends StatelessWidget {
	const _JobCard({required this.category, required this.location, required this.title, required this.description, this.subLabel});

	final String category;
	final String location;
	final String title;
	final String description;
	final String? subLabel;

	@override
	Widget build(BuildContext context) {
		return Container(margin: const EdgeInsets.only(bottom: 16), padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadii.md)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Text(category, style: AppTextStyles.labelMedium.copyWith(letterSpacing: 2.2, fontSize: 10)), const SizedBox(width: 10), const Text('•', style: TextStyle(color: AppColors.tertiary)), const SizedBox(width: 10), Text(location, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textBody))]), const SizedBox(height: 12), Text(title, style: AppTextStyles.titleLarge.copyWith(fontSize: 22, color: AppColors.textPrimary)), const SizedBox(height: 10), Text(description, style: AppTextStyles.bodySmall.copyWith(fontSize: 14)), const SizedBox(height: 22), if (subLabel != null) ...[Text(subLabel!, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted)), const SizedBox(height: 10)], SizedBox(width: double.infinity, height: 42, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0A7A55), foregroundColor: AppColors.surface, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))), child: const Text('Accept Job')))]));
	}
}
