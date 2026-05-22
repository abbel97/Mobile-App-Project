import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                              'Recent Jobs',
                              style: AppTextStyles.titleMedium.copyWith(
                                fontSize: 20,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.neutral,
                            borderRadius: BorderRadius.circular(AppRadii.sm),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Text(
                      'My Recent Jobs',
                      style: AppTextStyles.headline2.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 24),

                    //Job cards
                    _AcceptedJobCard(
                      title: 'Master Ensuite HVAC Integration',
                      customerName: 'Customer Name',
                      schedule: 'Today, 2:30 PM',
                      location: '6Kilo, Addis.A',
                      status: 'IN PROGRESS',
                      accentColor: AppColors.secondary,
                      onDetails: () => context.push(
                        AppRoutes.jobDetailsPath('hvac-ensuite'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _AcceptedJobCard(
                      title: 'Smart Lighting Commissioning',
                      customerName: 'Abebe Kebede',
                      schedule: 'Tomorrow, 09:00 AM',
                      location: 'Brooklyn, NY',
                      status: 'ASSIGNED',
                      accentColor: AppColors.border,
                      onDetails: () => context.push(
                        AppRoutes.jobDetailsPath('smart-lighting-comm'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _AcceptedJobCard(
                      title: 'Polished Concrete Surface Seal',
                      customerName: 'Abebe Kebede',
                      schedule: 'Friday, 1:00 PM',
                      location: 'Bole, Addis.A',
                      status: 'ASSIGNED',
                      accentColor: AppColors.border,
                      onDetails: () => context.push(
                        AppRoutes.jobDetailsPath('concrete-seal'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AcceptedJobCard extends StatelessWidget {
  const _AcceptedJobCard({
    required this.title,
    required this.customerName,
    required this.schedule,
    required this.location,
    required this.status,
    required this.accentColor,
    this.onDetails,
  });

  final String title;
  final String customerName;
  final String schedule;
  final String location;
  final String status;
  final Color accentColor;
  final VoidCallback? onDetails;

  bool get _isInProgress => status == 'IN PROGRESS';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border(left: BorderSide(color: accentColor, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Title + Status badge ─────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.titleLarge.copyWith(
                    fontSize: 22,
                    color: AppColors.primary,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _isInProgress
                      ? AppColors.secondary
                      : const Color(0xFFE8E8F5),
                  borderRadius: BorderRadius.circular(AppRadii.sm),
                ),
                child: Text(
                  status,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: _isInProgress
                        ? AppColors.surface
                        : AppColors.tertiary,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // ── Customer name ────────────────────────
          Row(
            children: [
              const Icon(
                Icons.person_outline_rounded,
                size: 14,
                color: AppColors.tertiary,
              ),
              const SizedBox(width: 6),
              Text(
                customerName,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textBody,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 14),

          //schedule + location
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SCHEDULE',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.textMuted,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      schedule,
                      style: AppTextStyles.titleSmall.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOCATION',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.textMuted,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      location,
                      style: AppTextStyles.titleSmall.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // service type + details button
          Row(
            children: [
              OutlinedButton(
                onPressed: onDetails,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: const BorderSide(color: AppColors.border),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadii.sm),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                child: Text(
                  'Details',
                  style: AppTextStyles.buttonSmall.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}