import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../customer/presentation/widgets/customer_bottom_nav_bar.dart';

class ProfessionalProfileDetailScreen extends StatelessWidget {
  final String professionalId;
  
  const ProfessionalProfileDetailScreen({super.key, required this.professionalId});

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
                  Text('HOME-TWEAK', style: AppTextStyles.titleMedium.copyWith(fontSize: 28, color: AppColors.primary)),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 16, offset: const Offset(0, 6)),
                  ],
                ),
                child: Column(
                  children: [
                    Container(height: 68, decoration: const BoxDecoration(color: Color(0xFF40589B), borderRadius: BorderRadius.vertical(top: Radius.circular(14)))),
                    Transform.translate(offset: const Offset(0, -36), child: const _ProfileAvatar()),
                    const SizedBox(height: 6),
                    Text('Elphaz Jovani', style: AppTextStyles.titleLarge.copyWith(fontSize: 28, color: AppColors.textPrimary)),
                    const SizedBox(height: 6),
                    Text('Carpenter', style: AppTextStyles.titleSmall.copyWith(color: AppColors.secondary)),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: 220,
                      height: 46,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.surface,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        icon: const Icon(Icons.handshake_outlined, size: 18),
                        label: const Text('Hire'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: const [
                  Expanded(child: _InfoStat(title: '12+', subtitle: 'YEARS EXPERIENCE')),
                  SizedBox(width: 12),
                  Expanded(child: _InfoStat(title: '14', subtitle: 'JOBS DONE')),
                ],
              ),
              const SizedBox(height: 24),
              Text('BIOGRAPHY', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary, fontSize: 12)),
              const SizedBox(height: 12),
              Text(
                'Specializing in structural integrity and modern interior workflows, Elphaz brings a meticulous architectural lens to home improvement. His approach balances high-end aesthetic value with practical, long-term durability. Formerly a lead designer at Studio Vertex, he now focuses on premium residential transformations.',
                style: AppTextStyles.bodyMedium.copyWith(fontSize: 16, height: 1.6),
              ),
              const SizedBox(height: 26),
              Text('PROFESSIONAL JOURNEY', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary, fontSize: 12)),
              const SizedBox(height: 12),
              const _JourneyItem(year: '2018 — PRESENT', title: 'Principal Architect', subtitle: 'Vane & Associates Residential', active: true),
              const _JourneyItem(year: '2014 — 2018', title: 'Senior Structural Designer', subtitle: 'Metropolis Urban Planning'),
              const _JourneyItem(year: '2012 — 2014', title: 'Junior Consultant', subtitle: 'Greenway Home Solutions'),
              const SizedBox(height: 26),
              Text('ACADEMIC GROUNDING', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary, fontSize: 12)),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppRadii.sm), border: Border.all(color: AppColors.border)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('MASTERS DEGREE', style: AppTextStyles.labelMedium.copyWith(color: AppColors.textMuted, fontSize: 10)),
                    const SizedBox(height: 6),
                    Text('Msc in Electrical Engineering', style: AppTextStyles.titleSmall.copyWith(fontSize: 16, color: AppColors.textPrimary)),
                    const SizedBox(height: 4),
                    Text('Addis Ababa University', style: AppTextStyles.bodySmall),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Text('Specialized Skills', style: AppTextStyles.titleLarge.copyWith(fontSize: 22, color: AppColors.textPrimary)),
              const SizedBox(height: 14),
              const Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _SkillChip(label: 'Electrical Solution'),
                  _SkillChip(label: 'EV Charger setup nd\nInstallation'),
                  _SkillChip(label: 'Installation'),
                  _SkillChip(label: 'Solar Grid\nTie-in'),
                  _SkillChip(label: 'Framing'),
                ],
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomerBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
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
        },
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.surface, width: 4),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, 6)),
        ],
      ),
      child: const Icon(Icons.person, size: 58, color: AppColors.tertiary),
    );
  }
}

class _InfoStat extends StatelessWidget {
  const _InfoStat({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppRadii.md), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.titleLarge.copyWith(fontSize: 24, color: AppColors.primary)),
          Text(subtitle, style: AppTextStyles.labelMedium.copyWith(fontSize: 11)),
        ],
      ),
    );
  }
}

class _JourneyItem extends StatelessWidget {
  const _JourneyItem({required this.year, required this.title, required this.subtitle, this.active = false});

  final String year;
  final String title;
  final String subtitle;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 4, height: 52, color: active ? AppColors.primary : AppColors.border),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(year, style: AppTextStyles.labelMedium.copyWith(color: active ? AppColors.secondary : AppColors.textMuted, fontSize: 10)),
                const SizedBox(height: 4),
                Text(title, style: AppTextStyles.titleSmall.copyWith(fontSize: 16, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text(subtitle, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  const _SkillChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(4)),
      child: Text(label, style: AppTextStyles.titleSmall.copyWith(fontSize: 14, color: AppColors.surface)),
    );
  }
}