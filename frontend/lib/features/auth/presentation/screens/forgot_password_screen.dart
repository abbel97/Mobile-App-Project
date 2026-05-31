import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../data/repositories/auth_repositories_impl.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends ConsumerState<ForgotPasswordScreen> {
  final _emailController       = TextEditingController();
  final _newPassController     = TextEditingController();
  final _confirmPassController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  Future<void> _reset() async {
    final email    = _emailController.text.trim();
    final newPass  = _newPassController.text;
    final confirm  = _confirmPassController.text;

    if (email.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      setState(() => _error = 'Please fill in all fields');
      return;
    }
    if (newPass != confirm) {
      setState(() => _error = 'Passwords do not match');
      return;
    }
    if (newPass.length < 6) {
      setState(() => _error = 'Password must be at least 6 characters');
      return;
    }

    setState(() { _isLoading = true; _error = null; });
    try {
      await AuthRepositoryImpl().resetPassword(
        email:           email,
        newPassword:     newPass,
        confirmPassword: confirm,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password reset successfully — please log in'),
        backgroundColor: AppColors.success,
      ));
      context.go(AppRoutes.login);
    } on Failure catch (e) {
      setState(() => _error = e.message);
    } catch (_) {
      setState(() => _error = 'Something went wrong');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding.copyWith(top: 34, bottom: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back_rounded,
                    color: AppColors.primary),
              ),
              const SizedBox(height: 16),
              Text('Reset Password',
                  style: AppTextStyles.titleLarge
                      .copyWith(color: AppColors.textPrimary, fontSize: 30)),
              const SizedBox(height: 10),
              Text(
                'Enter your registered email and choose a new password.',
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textBody),
              ),
              const SizedBox(height: 36),

              CustomTextField(
                label: 'EMAIL ADDRESS',
                hintText: 'youremail@gmail.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 22),
              CustomTextField(
                label: 'NEW PASSWORD',
                hintText: '••••••••',
                obscureText: true,
                controller: _newPassController,
              ),
              const SizedBox(height: 22),
              CustomTextField(
                label: 'CONFIRM NEW PASSWORD',
                hintText: '••••••••',
                obscureText: true,
                controller: _confirmPassController,
              ),

              if (_error != null) ...[
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.danger.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: AppColors.danger.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline,
                          color: AppColors.danger, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(_error!,
                            style: AppTextStyles.bodySmall
                                .copyWith(color: AppColors.danger)),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 32),

              PrimaryButton(
                label: 'Reset Password',
                trailing: _isLoading
                    ? const SizedBox(
                        width: 18, height: 18,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.lock_reset_rounded,
                        size: 18, color: Colors.white),
                onPressed: _isLoading ? null : _reset,
              ),
              const SizedBox(height: 24),
              Center(
                child: TextButton(
                  onPressed: () => context.go(AppRoutes.login),
                  child: Text('Back to Login',
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.primary)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}