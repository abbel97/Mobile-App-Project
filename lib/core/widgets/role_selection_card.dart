import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radii.dart';
import '../theme/app_text_styles.dart';

class RoleSelectionCard extends StatelessWidget {
  const RoleSelectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.cta,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final String cta;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: AppColors.primary, size: 28),
          ),
          const SizedBox(height: 28),
          Text(
            title,
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textBody,
            ),
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppRadii.sm),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
              child: Text(
                '$cta ->',
                style: AppTextStyles.titleSmall.copyWith(
                  color: AppColors.success,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}