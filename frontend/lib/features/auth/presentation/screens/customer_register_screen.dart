import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/auth_social_button.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/primary_button.dart';
import '../providers/auth_notifier.dart';

class CustomerRegisterScreen extends ConsumerStatefulWidget {
  const CustomerRegisterScreen({super.key});

  @override
  ConsumerState<CustomerRegisterScreen> createState() =>
      _CustomerRegisterScreenState();
}

class _CustomerRegisterScreenState
    extends ConsumerState<CustomerRegisterScreen> {
  final _nameController  = TextEditingController();
  final _emailController = TextEditingController();
  final _passController  = TextEditingController();
  final _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _register() {
    final name     = _nameController.text.trim();
    final email    = _emailController.text.trim();
    final password = _passController.text;
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')));
      return;
    }
    if (password != _confirmPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')));
      return;
    }
    ref.read(authProvider.notifier).registerCustomer(
      name: name, email: email, password: password,
    );
  }

  @override
  Widget build(BuildContext context) {
     final auth = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (_, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(next.error!),
          backgroundColor: AppColors.danger,
        ));
        ref.read(authProvider.notifier).clearError();
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding.copyWith(top: 34, bottom: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    
                    Text(
                      'HOME-TWEAK',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 84,
                      height: 5,
                      color: AppColors.success,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 42),
              Text(
                'Welcome!',
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Create your account to start managing your home transformations.',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textBody),
              ),
              const SizedBox(height: 36),
              CustomTextField(
                label: 'Full Name',
                 hintText: 'Your Name',
                 controller: _nameController,
                 ),
              const SizedBox(height: 24),
              CustomTextField(
                label: 'Email Address',
                hintText: 'youremail@gmail.com',
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                label: 'Password',
                hintText: '••••••••',
                obscureText: true,
                controller: _passController,
              ),
              const SizedBox(height: 22),
              CustomTextField(
                label: 'Confirm Password',
                hintText: '••••••••',
                obscureText: true,
                controller: _confirmPassController,
              ),
              const SizedBox(height: 30),
              PrimaryButton(
                label: 'Sign Up',
              trailing: auth.isLoading
                    ? const SizedBox(
                        width: 18, height: 18,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.arrow_forward,
                        size: 18, color: Colors.white),
                onPressed: auth.isLoading ? null : _register,
              ),
              const SizedBox(height: 48),
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.border)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      'OR SIGN UP WITH',
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
                      label: 'Google',
                      icon: Icons.g_mobiledata,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AuthSocialButton(
                      label: 'Apple',
                      icon: Icons.apple,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.textBody),
                    children: [
                      const TextSpan(text: 'Already have an account?  '),
                      TextSpan(
                        text: 'Sign In',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.push(AppRoutes.login),
                      ),
                    ],
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