import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/role_selection_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding.copyWith(top: 54, bottom: 42),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to\nHome-Tweak',
                style: AppTextStyles.headline2.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Choose your path to professional home\nmanagement. Precise, structured and reliable.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textBody,
                ),
              ),
              const SizedBox(height: 52),
              RoleSelectionCard(
                icon: Icons.house_outlined,
                title: 'I need a fix',
                description:
                    'Find certified experts for your home repairs, maintenance, and emergency tweaks.',
                cta: 'GET STARTED',
                onTap: () => context.push(AppRoutes.customerRegister),
              ),
              const SizedBox(height: 30),
              RoleSelectionCard(
                icon: Icons.manage_accounts_outlined,
                title: "I'm a professional",
                description:
                    'Access professional requests, manage your schedule, and power up your career on our marketplace.',
                cta: 'REGISTER AND START WORKING',
                onTap: () => context.push(AppRoutes.professionalRegister),
              ),
              const SizedBox(height: 110),
              Center(
                child: Text(
                  'Already have an account?',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textBody,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: SizedBox(
                  width: 140,
                  child: PrimaryButton(
                    label: 'Sign In',
                    height: 50,
                    onPressed: () => context.push(AppRoutes.login),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}