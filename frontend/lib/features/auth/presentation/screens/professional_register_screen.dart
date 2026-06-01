import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/top_bar.dart';
import '../providers/auth_notifier.dart';
import '../../../../core/widgets/profile_image_picker.dart';

class ProfessionalRegisterScreen extends ConsumerStatefulWidget {
  const ProfessionalRegisterScreen({super.key});

  @override
  ConsumerState<ProfessionalRegisterScreen> createState() =>
      _ProfessionalRegisterScreenState();
}

class _ProfessionalRegisterScreenState
    extends ConsumerState<ProfessionalRegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _experienceController = TextEditingController();
  final _bioController = TextEditingController();

  String? _selectedProfession;
  String? _selectedEducation;
  bool _agreedToTerms = false;
  String? _photoBase64;

  final List<String> _professions = [
    'General Handyman',
    'Electrician',
    'Plumber',
    'Carpenter',
    'Mechanic',
    'Painter',
    'Home Inspector',
    'Home Organizer',
    'HVAC Technician',
    'Roofer',
    'Flooring Specialist',
    'Pool Technician',
    'Pest Control Expert',
    'Grass Cutter',
    'Landscaper',
    'General Contractor',
    'Interior Designer',
    'Architect',
    'Structural Engineer',  
    'Other Home Pro', 
  ];

  final List<String> _educationLevels = [
    'Middle School',
    'High School',
    'Vocational / Trade School',
    'Associate Degree',
    'Bachelor\'s Degree',
    'Master\'s Degree',
    'No Formal Education',
    'Other',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _experienceController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      filled: true,
      fillColor: AppColors.inputFill,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadii.sm),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadii.sm),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadii.sm),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
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
      backgroundColor: AppColors.background,
      appBar: TopBar(
        title: 'Home-tweak',
        onBack: () => context.pop(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding.copyWith(top: 28, bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Become a\nHome Architect.',
                style: AppTextStyles.headline2.copyWith(
                  color: AppColors.primary,
                  fontSize: 36,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Join our curated network of professionals redefining how premium homes are managed and maintained.',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textBody),
              ),
              const SizedBox(height: 36),

              Text(
                'Identity & Contact',
                style: AppTextStyles.titleMedium.copyWith(color: AppColors.primary),
              ),
              const SizedBox(height: 20),

              Text(
                'Profile Photo',
                style: AppTextStyles.labelLarge.copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileImagePicker(
                    base64Image: _photoBase64,
                    size: 80,
                    isRound: true,
                    onPickImage: () async {
                      final b64 = await pickImageAsBase64();
                      if (b64 != null) setState(() => _photoBase64 = b64);
                    },
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upload a professional headshot.',
                          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textBody),
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: () async {
                            final b64 = await pickImageAsBase64();
                            if (b64 != null) setState(() => _photoBase64 = b64);
                          },
                          child: Text(
                            _photoBase64 == null ? 'Choose File' : 'Change Photo',
                            style: AppTextStyles.titleSmall
                                .copyWith(color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: 'Full Name',
                hintText: 'e.g. Abebe Kebede',
                controller: _nameController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Email Address',
                hintText: 'abebe@gmail.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Password',
                hintText: '••••••••••••',
                controller: _passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Confirm Password',
                hintText: '••••••••••••',
                controller: _confirmPasswordController,
                obscureText: true,
              ),
              const SizedBox(height: 36),

              Text(
                'Professional Expertise',
                style: AppTextStyles.titleMedium.copyWith(color: AppColors.primary),
              ),
              const SizedBox(height: 20),

              Text(
                'Profession',
                style: AppTextStyles.labelLarge.copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                initialValue: _selectedProfession,
                decoration: _dropdownDecoration(),
                hint: Text(
                  'Select specialized field',
                  style: AppTextStyles.bodyRegular.copyWith(color: AppColors.textMuted),
                ),
                items: _professions
                    .map((p) => DropdownMenuItem(
                          value: p,
                          child: Text(
                            p,
                            style: AppTextStyles.bodyRegular.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => _selectedProfession = val),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Experience (Years)',
                hintText: 'Years of experience',
                controller: _experienceController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              Text(
                'Education Level',
                style: AppTextStyles.labelLarge.copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                initialValue: _selectedEducation,
                decoration: _dropdownDecoration(),
                hint: Text(
                  'Highest academic achievement?',
                  style: AppTextStyles.bodyRegular.copyWith(color: AppColors.textMuted),
                ),
                items: _educationLevels
                    .map((e) => DropdownMenuItem( 
                          value: e,
                          child: Text(
                            e,
                            style: AppTextStyles.bodyRegular.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => _selectedEducation = val),
              ),
              const SizedBox(height: 16),

              Text(
                'Professional Bio',
                style: AppTextStyles.labelLarge.copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _bioController,
                maxLines: 4,
                style: AppTextStyles.bodyRegular.copyWith(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Tell us about your signature style and key projects...',
                  hintStyle: AppTextStyles.bodyRegular.copyWith(color: AppColors.textMuted),
                  contentPadding: const EdgeInsets.all(16),
                  filled: true,
                  fillColor: AppColors.inputFill,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.sm),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.sm),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.sm),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    'MINIMUM 50 CHARACTERS',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.textMuted,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _agreedToTerms,
                      onChanged: (val) =>
                          setState(() => _agreedToTerms = val ?? false),
                      activeColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textBody,
                        ),
                        children: [
                          const TextSpan(text: 'I agree to the '),
                          TextSpan(
                            text: 'Professional Terms of Agreement and Service',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => context.push(AppRoutes.termsAndPolicy),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              PrimaryButton(
              label: 'Complete Registration',
              trailing: auth.isLoading
                  ? const SizedBox(
                      width: 18, height: 18,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : null,
              onPressed: auth.isLoading ? null : () async {
                if (_passwordController.text.isEmpty ||
                    _confirmPasswordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Password fields are required'),
                    backgroundColor: AppColors.danger,
                  ));
                  return;
                }
                if (_passwordController.text != _confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Passwords do not match'),
                    backgroundColor: AppColors.danger,
                  ));
                  return;
                }
                final success = await ref.read(authProvider.notifier).registerProfessional(
                  name:            _nameController.text.trim(),
                  email:           _emailController.text.trim(),
                  password:        _passwordController.text,
                  confirmPassword: _confirmPasswordController.text,
                  profession:      _selectedProfession ?? '',
                  bio:             _bioController.text,
                  educationLevel:  _selectedEducation,
                  experienceYears: int.tryParse(_experienceController.text),
                  photoBase64:    _photoBase64,
                );
                if (!context.mounted || !success) return;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Registered successfully, login now'),
                  backgroundColor: AppColors.success,
                ));
                context.go(AppRoutes.login);
              },
            ),
              const SizedBox(height: 20),
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