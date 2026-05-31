import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
//import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/profile_image_picker.dart';
import 'package:home_tweak/features/auth/presentation/providers/auth_notifier.dart';

class CustomerEditProfileScreen extends ConsumerStatefulWidget {
  const CustomerEditProfileScreen({super.key});

  @override
  ConsumerState<CustomerEditProfileScreen> createState() =>
      _CustomerEditProfileScreenState();
}

class _CustomerEditProfileScreenState
    extends ConsumerState<CustomerEditProfileScreen> {
  final _nameController     = TextEditingController();
  final _emailController    = TextEditingController();
  final _locationController = TextEditingController();
  String? _photoBase64;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(authProvider).user;
      if (user != null) {
        _nameController.text     = user.name;
        _emailController.text    = user.email;
        _locationController.text = user.location ?? '';
        setState(() => _photoBase64 = user.photoBase64);
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (_, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(next.error!),
            backgroundColor: AppColors.danger));
        ref.read(authProvider.notifier).clearError();
      }
      if (next.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Profile updated'),
            backgroundColor: AppColors.success));
        ref.read(authProvider.notifier).clearSuccess();
        context.pop();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
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
                        Text('Edit Profile',
                            style: AppTextStyles.titleMedium
                                .copyWith(color: AppColors.primary)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // ── Profile photo ────────────────────
                    Center(
                      child: ProfileImagePicker(
                        base64Image: _photoBase64,
                        size: 100, isRound: true,
                        onPickImage: () async {
                          final b64 = await pickImageAsBase64();
                          if (b64 != null) setState(() => _photoBase64 = b64);
                        },
                      ),
                    ),
                    const SizedBox(height: 28),

                    CustomTextField(
                      label: 'FULL NAME',
                      controller: _nameController,
                    ),
                    const SizedBox(height: 18),
                    CustomTextField(
                      label: 'EMAIL ADDRESS',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 18),
                    CustomTextField(
                      label: 'LOCATION',
                      hintText: 'City, Country',
                      controller: _locationController,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: PrimaryButton(
                label: 'Save Changes',
                height: 52,
                trailing: auth.isLoading
                    ? const SizedBox(
                        width: 18, height: 18,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : null,
                onPressed: auth.isLoading
                    ? null
                    : () {
                        final name  = _nameController.text.trim();
                        final email = _emailController.text.trim();
                        if (name.isEmpty || email.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Name and email are required')));
                          return;
                        }
                        ref.read(authProvider.notifier).updateProfile(
                          name:        name,
                          email:       email,
                          location:    _locationController.text.trim(),
                          photoBase64: _photoBase64,
                        );
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}