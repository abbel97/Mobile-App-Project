import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/green_buttons.dart';
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Inline header ──────────────────────
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => context.pop(),
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          'Jobs',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.primary,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Check recent posted\njobs',
                      style: AppTextStyles.headline2.copyWith(
                        fontSize: 32,
                        height: 1.05,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 22),
                   
                    // ── Job cards ──────────────────────────
                    _JobCard(
                      category: 'CARPENTER',
                      location: 'Paris, France',
                      title: 'Residential Electrical Panel Upgrade',
                      description:
                          'Looking for a licensed electrician to upgrade a 100-amp service to 200-amp in a brownstone. Permits required. Urgent start preferred.',
                      onAccept: () => context.go(
                        AppRoutes.jobDetailsPath('electrical-panel'),
                      ),
                    ),
                    _JobCard(
                      category: 'MAINTENANCE',
                      location: 'Hawassa, Eth',
                      title: 'Commercial HVAC Seasonal Inspection',
                      description:
                          'Quarterly inspection for a 5,000 sq ft office space. Focus on filter replacement, refrigerant checks, and thermostat calibration.',
                      subLabel: 'Estimated',
                      onAccept: () => context.go(
                        AppRoutes.jobDetailsPath('hvac-inspection'),
                      ),
                    ),
                    _JobCard(
                      category: 'ELECTRICIAN',
                      location: 'DC, USA',
                      title: 'Smart Home Lighting Design & Install',
                      description:
                          'New construction requiring full Lutron integration across 4 zones. Design consult needed before final installation phase.',
                      subLabel: 'Project Budget',
                      onAccept: () => context.go(
                        AppRoutes.jobDetailsPath('smart-lighting'),
                      ),
                    ),
                    _JobCard(
                      category: 'PLUMBING',
                      location: '4Kilo, A.A',
                      title: 'Gourmet Kitchen Faucet Replacement',
                      description:
                          'Installation of a high-end touchless faucet. Under-sink filter also needs reconnection. Easy 1-hour job for a skilled Pro.',
                      onAccept: () => context.go(
                        AppRoutes.jobDetailsPath('kitchen-faucet'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ProfessionalBottomNavBar(
              currentIndex: 1,
              onTap: (index) {
                switch (index) {
                  case 0:
                    context.push(AppRoutes.professionalDashboard);
                    break;
                  case 2:
                    context.push(AppRoutes.professionalsList);
                    break;
                  case 3:
                    context.push(AppRoutes.professionalSettings);
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

class _JobCard extends StatelessWidget {
  const _JobCard({
    required this.category,
    required this.location,
    required this.title,
    required this.description,
    this.subLabel,
    this.onAccept,
  });

  final String category;
  final String location;
  final String title;
  final String description;
  final String? subLabel;
  final VoidCallback? onAccept;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                category,
                style: AppTextStyles.labelMedium.copyWith(
                  letterSpacing: 2.2,
                  fontSize: 10,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(width: 10),
              const Text('•', style: TextStyle(color: AppColors.tertiary)),
              const SizedBox(width: 10),
              const Icon(
                Icons.place_outlined,
                size: 14,
                color: AppColors.tertiary,
              ),
              const SizedBox(width: 4),
              Text(
                location,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textBody,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTextStyles.titleLarge.copyWith(
              fontSize: 22,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 14,
              color: AppColors.textBody,
            ),
          ),
          const SizedBox(height: 22),
          if (subLabel != null) ...[
            Text(
              subLabel!,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 10),
          ],
          GreenButton(label: 'Accept Job', onPressed: onAccept),
        ],
      ),
    );
  }
}