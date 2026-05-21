import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';

class ProfessionalsListScreen extends StatelessWidget {
  final bool showCta;
  final Widget? bottomNavigationBar;

  const ProfessionalsListScreen({
    super.key,
    this.showCta = true,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Inline header ────────────────────────────
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.neutral,
                      borderRadius: BorderRadius.circular(AppRadii.md),
                    ),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    'HOME-TWEAK',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ── Search bar ───────────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadii.md),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      color: AppColors.tertiary,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Search...',
                      style: AppTextStyles.bodyRegular.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // ── Filter pills ─────────────────────────────
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    _Pill(label: 'All Experts', selected: true),
                    SizedBox(width: 12),
                    _Pill(label: 'Plumbing'),
                    SizedBox(width: 12),
                    _Pill(label: 'Electrical'),
                    SizedBox(width: 12),
                    _Pill(label: 'Carpentry'),
                    SizedBox(width: 12),
                    _Pill(label: 'Painting'),
                    SizedBox(width: 12),
                    _Pill(label: 'Contractors'),
                  ],
                ),
              ),
              const SizedBox(height: 26),

              // ── Professional cards ───────────────────────
              _ProfessionalCard(
                name: 'Elphaz Jovani',
                title: 'Carpenter',
                experience: '12 years experience',
                rating: '4.9',
                onTap: () => context.go(
                  AppRoutes.professionalProfileDetailPath('elphaz-jovani'),
                ),
              ),
              _ProfessionalCard(
                name: 'Michael Ash',
                title: 'Interior Lighting Designer',
                experience: '8 years experience',
                rating: '5.0',
                onTap: () => context.go(
                  AppRoutes.professionalProfileDetailPath('michael-ash'),
                ),
              ),
              _ProfessionalCard(
                name: 'David James',
                title: 'Expert Plumber',
                experience: '15 years experience',
                rating: '4.8',
                onTap: () => context.go(
                  AppRoutes.professionalProfileDetailPath('david-james'),
                ),
              ),
              _ProfessionalCard(
                name: 'Abebe Kebedee',
                title: 'Custom Cabinetry & Carpentry',
                experience: '6 years experience',
                rating: '4.7',
                hasPhoto: false,
                onTap: () => context.go(
                  AppRoutes.professionalProfileDetailPath('abebe-kebedee'),
                ),
              ),
              const SizedBox(height: 8),

              // ── CTA promo — customer side only ───────────
              if (showCta) const _SupportPromo(),
            ],
          ),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : AppColors.card,
        borderRadius: BorderRadius.circular(AppRadii.sm),
      ),
      child: Text(
        label,
        style: AppTextStyles.titleSmall.copyWith(
          fontSize: 14,
          color: selected ? AppColors.surface : AppColors.textBody,
        ),
      ),
    );
  }
}

class _ProfessionalCard extends StatelessWidget {
  const _ProfessionalCard({
    required this.name,
    required this.title,
    required this.experience,
    required this.rating,
    required this.onTap,
    this.hasPhoto = true,
  });

  final String name;
  final String title;
  final String experience;
  final String rating;
  final VoidCallback onTap;
  final bool hasPhoto;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
        child: Row(
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: hasPhoto
                    ? const Color(0xFF1F2937)
                    : AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadii.md),
                border: Border.all(color: AppColors.border),
              ),
              child: hasPhoto
                  ? const Icon(Icons.person, color: AppColors.surface, size: 42)
                  : const SizedBox.shrink(),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.titleSmall.copyWith(
                      fontSize: 18,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: AppTextStyles.titleSmall.copyWith(
                      fontSize: 14,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    experience,
                    style: AppTextStyles.bodyRegular.copyWith(
                      fontSize: 13,
                      color: AppColors.textBody,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 16,
                        color: Color(0xFFF59E0B),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style: AppTextStyles.titleSmall.copyWith(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.tertiary,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}

class _SupportPromo extends StatelessWidget {
  const _SupportPromo();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppRadii.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Can't find the right\nexpert?",
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColors.neutral.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            "Tell us about your project and we'll match you with the best available professional in our network.",
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.neutral.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.surface,
                foregroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadii.md),
                ),
                elevation: 0,
              ),
              child: Text(
                'Submit your issue',
                style: AppTextStyles.titleSmall.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}