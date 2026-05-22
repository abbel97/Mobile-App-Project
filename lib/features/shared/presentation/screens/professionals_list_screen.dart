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
             
              Row(
                children: [
                  Container(
                    width: 20,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.neutral,
                      borderRadius: BorderRadius.circular(AppRadii.md),
                    ),
                  ),
                  Text(
                    'Home-Tweak',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

             TextField(
              decoration: InputDecoration(
                hintText: 'Search individuals...',
                prefixIcon: const Icon(Icons.search_rounded),

                filled: true,
                fillColor: AppColors.surface,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadii.md),
                  borderSide: const BorderSide(
                    color: AppColors.border,
                  ),
                ),
              ),
            ),
              const SizedBox(height: 20),

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
                    SizedBox(width: 12),
                    _Pill(label: 'Interior Designer'),
                  ],
                ),
              ),
              const SizedBox(height: 26),

              _ProfessionalCard(
                name: 'Elphaz Jovani',
                title: 'Carpenter',
                experience: '12 years experience',
                onTap: () => context.push(
                  AppRoutes.professionalProfileDetailPath('elphaz-jovani'),
                ),
              ),
              _ProfessionalCard(
                name: 'Michael Ash',
                title: 'Interior Designer',
                experience: '8 years experience',
                onTap: () => context.push(
                  AppRoutes.professionalProfileDetailPath('michael-ash'),
                ),
              ),
              _ProfessionalCard(
                name: 'David James',
                title: 'Plumber',
                experience: '15 years experience',
                onTap: () => context.push(
                  AppRoutes.professionalProfileDetailPath('david-james'),
                ),
              ),
              _ProfessionalCard(
                name: 'Abebe Kebedee',
                title: 'Custom Cabinetry & Carpentry',
                experience: '6 years experience',
                hasPhoto: false,
                onTap: () => context.push(
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
    required this.onTap,
    this.hasPhoto = true,
  });

  final String name;
  final String title;
  final String experience;
  final VoidCallback onTap;
  final bool hasPhoto;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: hasPhoto
                    ? const Color.fromARGB(255, 28, 37, 48)
                    : AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadii.md),
                border: Border.all(color: AppColors.border),
              ),
              child: hasPhoto
                  ? const Icon(Icons.person, color: AppColors.surface, size: 38)
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
                      const SizedBox(width: 4),
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
              child:
               Text(
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