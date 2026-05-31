import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/presentation/providers/auth_notifier.dart';
import '../../../professional/presentation/providers/professional_notifier.dart';

class ProfessionalProfileDetailScreen extends ConsumerWidget {
  final String  professionalId;
  final Widget? bottomNavigationBar;

  const ProfessionalProfileDetailScreen({
    super.key,
    required this.professionalId,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state   = ref.watch(professionalProvider);
    final auth = ref.watch(authProvider);
    final matches = state.professionals
        .where((p) => p.id == professionalId)
        .toList();

    if (state.isLoading && matches.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (matches.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text('Professional not found',
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textMuted)),
        ),
      );
    }

    final p = matches.first;

    return Scaffold(
      backgroundColor:     AppColors.background,
      bottomNavigationBar: bottomNavigationBar,
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
                    icon: const Icon(Icons.arrow_back_rounded,
                        color: AppColors.primary),
                  ),
                  Text('Back',
                      style: AppTextStyles.titleMedium
                          .copyWith(color: AppColors.primary)),
                ],
              ),
              const SizedBox(height: 18),

              //Profile card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 16,
                        offset: const Offset(0, 6)),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      height: 68,
                      decoration: const BoxDecoration(
                        color: Color(0xFF40589B),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(14)),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -36),
                      child: Container(
                        width: 110, height: 110,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.surface, width: 4),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 16,
                                offset: const Offset(0, 6)),
                          ],
                        ),
                        child: const Icon(Icons.person,
                            size: 58, color: AppColors.tertiary),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(p.name,
                        style: AppTextStyles.titleLarge
                            .copyWith(fontSize: 28, color: AppColors.textPrimary)),
                    const SizedBox(height: 6),
                    Text(p.profession,
                        style: AppTextStyles.titleSmall
                            .copyWith(color: AppColors.secondary)),
                    const SizedBox(height: 18),
                    if (auth.isCustomer)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.surface,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppRadii.sm)),
                            ),
                            icon: const Icon(Icons.handshake_outlined, size: 18),
                            label: const Text('Hire'), 
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              //stats
              _InfoStat(
                  title: '${p.experienceYears}+',
                  subtitle: 'YEARS EXPERIENCE'),
              const SizedBox(height: 12),
              _InfoStat(
                  title: '\$${p.serviceRate.toStringAsFixed(2)}',
                  subtitle: 'HOURLY RATE'),
              const SizedBox(height: 24),

              //Bio
              if (p.bio != null && p.bio!.isNotEmpty) ...[
                Text('BIOGRAPHY',
                    style: AppTextStyles.labelMedium
                        .copyWith(color: AppColors.primary, fontSize: 12)),
                const SizedBox(height: 12),
                Text(p.bio!,
                    style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textBody, fontSize: 16, height: 1.6)),
                const SizedBox(height: 26),
              ],

              //location
              if (p.location != null && p.location!.isNotEmpty) ...[
                Text('LOCATION',
                    style: AppTextStyles.labelMedium
                        .copyWith(color: AppColors.primary, fontSize: 12)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.place_outlined,
                        size: 16, color: AppColors.tertiary),
                    const SizedBox(width: 6),
                    Text(p.location!,
                        style: AppTextStyles.bodyMedium
                            .copyWith(color: AppColors.textBody)),
                  ],
                ),
                const SizedBox(height: 26),
              ],

              //Education
              if (p.educationLevel != null &&
                  p.educationLevel!.isNotEmpty) ...[
                Text('EDUCATION',
                    style: AppTextStyles.labelMedium
                        .copyWith(color: AppColors.primary, fontSize: 12)),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadii.sm),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(p.educationLevel!,
                      style: AppTextStyles.titleSmall
                          .copyWith(color: AppColors.textPrimary)),
                ),
                const SizedBox(height: 26),
              ],
              if (p.skills.isNotEmpty) ...[
                const SizedBox(height: 26),
                Text('SKILLS',
                    style: AppTextStyles.labelMedium
                        .copyWith(color: AppColors.primary, fontSize: 12)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8, runSpacing: 8,
                  children: p.skills.map((skill) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(AppRadii.sm),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(skill,
                        style: AppTextStyles.bodySmall
                            .copyWith(color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w500)),
                  )).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
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
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: AppTextStyles.titleLarge
                  .copyWith(fontSize: 24, color: AppColors.primary)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: AppTextStyles.labelMedium
                  .copyWith(fontSize: 11, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}