import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/top_bar.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(title: 'Forgot Password'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding.copyWith(top: 26),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: AppSpacing.cardPadding,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Forgot Password',
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColors.primary,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Enter your email to receive a\npassword reset link.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textBody,
                      ),
                    ),
                    const SizedBox(height: 34),
                    const CustomTextField(
                      label: 'Email Address',
                      hintText: 'youremail@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 34),
                    PrimaryButton(
                      label: 'Send Reset Link',
                      trailing: const Icon(
                        Icons.send_outlined,
                        size: 18,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // TODO: handle password reset
                      },
                    ),
                    const SizedBox(height: 34),
                    Row(
                      children: [
                        const Expanded(child: Divider(color: AppColors.border)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Text(
                            'OR',
                            style: AppTextStyles.labelMedium.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                        const Expanded(child: Divider(color: AppColors.border)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: InkWell(
                        onTap: () => context.go(AppRoutes.login),
                        borderRadius: BorderRadius.circular(AppRadii.sm),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: Text(
                            '↩ Return to Login',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 180),
              Text(
                '© 2026 HOME-TWEAK MANAGEMENT SYSTEM.\nALL RIGHTS RESERVED.',
                style: AppTextStyles.labelMedium.copyWith(
                  fontSize: 8,
                  color: AppColors.tertiary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}