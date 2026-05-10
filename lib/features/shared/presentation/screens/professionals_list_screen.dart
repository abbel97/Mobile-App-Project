import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../customer/presentation/widgets/customer_bottom_nav_bar.dart';

class ProfessionalsListScreen extends StatelessWidget {
	const ProfessionalsListScreen({super.key});

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
								child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Container(width: 44, height: 44, decoration: BoxDecoration(color: AppColors.neutral, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.person_outline_rounded, color: AppColors.primary)), const SizedBox(width: 14), Text('HOME-TWEAK', style: AppTextStyles.titleMedium.copyWith(fontSize: 26, color: AppColors.primary))]), const SizedBox(height: 24), Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppRadii.md), border: Border.all(color: AppColors.border)), child: Row(children: const [Icon(Icons.search_rounded, color: AppColors.tertiary, size: 28), SizedBox(width: 12), Expanded(child: Text('Search...', style: TextStyle(fontSize: 18, color: AppColors.textMuted)))])), const SizedBox(height: 22), SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: const [_Pill(label: 'All Experts', selected: true), SizedBox(width: 12), _Pill(label: 'Plumbing'), SizedBox(width: 12), _Pill(label: 'Electrical'), SizedBox(width: 12), _Pill(label: 'Carpentry')])), const SizedBox(height: 26), const _ProfessionalCard(name: 'Elphaz Jovani', title: 'Carpenter', experience: '12 years experience', rating: '4.9'), const _ProfessionalCard(name: 'Michael Ash', title: 'Interior Lighting Designer', experience: '8 years experience', rating: '5.0'), const _ProfessionalCard(name: 'David James', title: 'Expert Plumber', experience: '15 years experience', rating: '4.8'), const _ProfessionalCard(name: 'Abebe Kebedee', title: 'Custom Cabinetry & Carpentry', experience: '6 years experience', rating: '4.7', hasPhoto: false), const SizedBox(height: 8), const _SupportPromo()]),
							),
						),
						CustomerBottomNavBar(currentIndex: 2, onTap: (index) {
							switch (index) {
								case 0:
									context.go(AppRoutes.customerDashboard);
									break;
								case 1:
									context.go(AppRoutes.customerRequests);
									break;
								case 3:
									context.go(AppRoutes.customerSettings);
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
		return Container(padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12), decoration: BoxDecoration(color: selected ? AppColors.primary : AppColors.card, borderRadius: BorderRadius.circular(8)), child: Text(label, style: AppTextStyles.titleSmall.copyWith(fontSize: 16, color: selected ? AppColors.surface : AppColors.textBody)));
	}
}

class _ProfessionalCard extends StatelessWidget {
	const _ProfessionalCard({required this.name, required this.title, required this.experience, required this.rating, this.hasPhoto = true});

	final String name;
	final String title;
	final String experience;
	final String rating;
	final bool hasPhoto;

	@override
	Widget build(BuildContext context) {
		return Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadii.md)), child: Row(children: [Container(width: 84, height: 84, decoration: BoxDecoration(color: hasPhoto ? const Color(0xFF1F2937) : AppColors.surface, borderRadius: BorderRadius.circular(16)), child: hasPhoto ? const Icon(Icons.person, color: AppColors.surface, size: 42) : const SizedBox.shrink()), const SizedBox(width: 18), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: AppTextStyles.titleSmall.copyWith(fontSize: 20, color: AppColors.primary)), const SizedBox(height: 6), Text(title, style: AppTextStyles.titleSmall.copyWith(fontSize: 16, color: AppColors.secondary)), const SizedBox(height: 4), Text(experience, style: AppTextStyles.bodyRegular.copyWith(fontSize: 14)), const SizedBox(height: 10), Row(children: [const Icon(Icons.star_rounded, size: 18, color: Color(0xFFF59E0B)), const SizedBox(width: 4), Text(rating, style: AppTextStyles.titleSmall.copyWith(fontSize: 16, color: AppColors.textPrimary))])])), const Icon(Icons.chevron_right_rounded, color: AppColors.tertiary, size: 30)]));
	}
}

class _SupportPromo extends StatelessWidget {
	const _SupportPromo();

	@override
	Widget build(BuildContext context) {
		return Container(padding: const EdgeInsets.all(28), decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(24)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Can't find the right\nexpert?", style: AppTextStyles.titleLarge.copyWith(fontSize: 28, color: AppColors.neutral.withValues(alpha: 0.72))), const SizedBox(height: 18), Text("Tell us about your project and we'll match\nyou with the best available professional in\nour network.", style: AppTextStyles.bodyMedium.copyWith(color: AppColors.neutral.withValues(alpha: 0.55), fontSize: 14)), const SizedBox(height: 24), SizedBox(width: 232, height: 58, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppColors.surface, foregroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0), child: Text('Submit your issue', style: AppTextStyles.titleSmall.copyWith(fontSize: 18, color: AppColors.primary))))]));
	}
}
