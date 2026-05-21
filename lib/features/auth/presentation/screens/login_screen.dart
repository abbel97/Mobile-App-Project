import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/auth_social_button.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/top_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(title: 'HOME-TWEAK'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding.copyWith(top: 22, bottom: 28),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: AppSpacing.cardPadding,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign In',
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Enter your professional credentials to continue.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textBody,
                      ),
                    ),
                    const SizedBox(height: 34),
                    const CustomTextField(
                      label: 'EMAIL ADDRESS',
                      hintText: 'youremail@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'PASSWORD',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.go(AppRoutes.forgotPassword),
                          child: Text(
                            'FORGOT PASSWORD?',
                            style: AppTextStyles.labelMedium.copyWith(
                              color: AppColors.success,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const CustomTextField(
                      hintText: '••••••••',
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    PrimaryButton(
                      label: 'LOG IN',
                      trailing: const Icon(Icons.arrow_forward, size: 20, color: Colors.white),
                      onPressed: () => context.go(AppRoutes.professionalDashboard),
                    ),
                    const SizedBox(height: 52),
                    const Divider(color: AppColors.border),
                    const SizedBox(height: 28),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textBody,
                          ),
                          children: [
                            const TextSpan(text: 'New to HOME-TWEAK?  '),
                            TextSpan(
                              text: 'Create account',
                              style: AppTextStyles.titleSmall.copyWith(
                                color: AppColors.primary,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => context.go(AppRoutes.home),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 34),
                    Row(
                      children: [
                        const Expanded(child: Divider(color: AppColors.border)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            'OR SIGN IN WITH',
                            style: AppTextStyles.labelMedium.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                        const Expanded(child: Divider(color: AppColors.border)),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: AuthSocialButton(
                            label: 'GOOGLE',
                            icon: Icons.g_mobiledata,
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AuthSocialButton(
                            label: 'APPLE',
                            icon: Icons.apple,
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 42),
              Text(
                '© 2026 HOME-TWEAK PROJECT MGMT.',
                style: AppTextStyles.labelMedium.copyWith(
                  fontSize: 9,
                  color: AppColors.tertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}