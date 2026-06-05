import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../auth/presentation/providers/auth_notifier.dart';
import '../providers/professional_notifier.dart';
import '../../../../core/widgets/profile_image_picker.dart';

class ProfessionalEditScreen extends ConsumerStatefulWidget {
  const ProfessionalEditScreen({super.key});

  @override
  ConsumerState<ProfessionalEditScreen> createState() =>
      _ProfessionalEditScreenState();
}

class _ProfessionalEditScreenState
    extends ConsumerState<ProfessionalEditScreen> {
  final _bioController        = TextEditingController();
  final _locationController   = TextEditingController();
  final _experienceController = TextEditingController();
  double  _serviceRate        = 0;
  String? _selectedProfession;
  String? _selectedEducation;
  String? _photoBase64;

  final List<String> _skills = [];
 

  final _professions = [
    'General Handyman', 'Electrician', 'Plumber', 'Carpenter',
    'Mechanic', 'Painter', 'Home Inspector', 'Home Organizer',
    'HVAC Technician', 'Roofer','Flooring Specialist', 'Pool Technician', 'Pest Control Expert',
    'Grass Cutter', 'Landscaper', 'General Contractor',
    'Interior Designer', 'Architect','Structural Engineer',  'Other Home Pro',
  ];
  final _educationLevels = [
    'High School', 'Vocational / Trade School',
    'Associate Degree', "Bachelor's Degree", "Master's Degree",
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(professionalProvider.notifier).loadMyProfile();
      final profile = ref.read(professionalProvider).myProfile;
      if (profile != null && mounted) {
        _bioController.text      = profile.bio      ?? '';
        _locationController.text = profile.location ?? '';
        _experienceController.text =
            profile.experienceYears.toString();
        setState(() {
          _photoBase64 = profile.photoBase64;
          _serviceRate = profile.serviceRate;
          _selectedProfession = _professions.contains(profile.profession)
              ? profile.profession
              : null;
          _selectedEducation  = profile.educationLevel != null &&
                  _educationLevels.contains(profile.educationLevel)
              ? profile.educationLevel
              : null;
        });
      }
    });
  }

  @override
  void dispose() {
    _bioController.dispose();
    _locationController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  void _showAddSkillDialog() {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Add Skill',
            style: AppTextStyles.titleMedium
                .copyWith(color: AppColors.textPrimary)),
        content: TextField(
          controller: ctrl, autofocus: true,
          decoration: const InputDecoration(hintText: 'e.g. Solar Panels'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              if (ctrl.text.trim().isNotEmpty) {
                setState(() => _skills.add(ctrl.text.trim()));
              }
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  InputDecoration _dropDecoration() => InputDecoration(
        filled: true,
        fillColor: AppColors.inputFill,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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

  @override
  Widget build(BuildContext context) {
    final profState = ref.watch(professionalProvider);
    final auth      = ref.watch(authProvider);

    ref.listen<ProfessionalState>(professionalProvider, (_, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(next.error!),
            backgroundColor: AppColors.danger));
        ref.read(professionalProvider.notifier).clearError();
      }
      if (next.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: AppColors.success));
        ref.read(professionalProvider.notifier).clearSuccess();
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
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Header
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
                    const SizedBox(height: 20),

                    ProfileImagePicker(
                      base64Image: _photoBase64,
                      size:  100,
                      onPickImage: () async {
                        final b64 = await pickImageAsBase64();
                        if (b64 != null) setState(() => _photoBase64 = b64);
                      },
                    ),
                    const SizedBox(height: 14),
                    Text(auth.user?.name ?? '',
                        style: AppTextStyles.headline2.copyWith(
                            fontSize: 28, color: AppColors.textPrimary)),
                    const SizedBox(height: 28),

                    //Profession
                    Text('PROFESSION',
                        style: AppTextStyles.labelLarge
                            .copyWith(color: AppColors.textPrimary)),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedProfession,
                      decoration: _dropDecoration(),
                      hint: Text('Select profession',
                          style: AppTextStyles.bodyRegular
                              .copyWith(color: AppColors.textMuted)),
                      items: _professions
                          .map((p) => DropdownMenuItem(
                              value: p,
                              child: Text(p,
                                  style: AppTextStyles.bodyRegular.copyWith(
                                      color: AppColors.textPrimary))))
                          .toList(),
                      onChanged: (v) =>
                          setState(() => _selectedProfession = v),
                    ),
                    const SizedBox(height: 18),

                    //Bio
                    Text('PROFESSIONAL OVERVIEW',
                        style: AppTextStyles.labelLarge
                            .copyWith(color: AppColors.textPrimary)),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _bioController,
                      maxLines: 5,
                      style: AppTextStyles.bodyRegular
                          .copyWith(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        hintText: 'Describe your experience...',
                        hintStyle: AppTextStyles.bodyRegular
                            .copyWith(color: AppColors.textMuted),
                        filled: true,
                        fillColor: AppColors.inputFill,
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadii.sm),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadii.sm),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    //Location
                    Text('PRIMARY LOCATION',
                        style: AppTextStyles.labelLarge
                            .copyWith(color: AppColors.textPrimary)),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _locationController,
                      style: AppTextStyles.bodyRegular
                          .copyWith(color: AppColors.textPrimary),
                      decoration: _dropDecoration().copyWith(
                        hintText: 'City, Country',
                        prefixIcon: const Icon(Icons.place_outlined,
                            color: AppColors.tertiary),
                      ),
                    ),
                    const SizedBox(height: 18),

                    //Experience
                    Text('EXPERIENCE (YEARS)',
                        style: AppTextStyles.labelLarge
                            .copyWith(color: AppColors.textPrimary)),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _experienceController,
                      keyboardType: TextInputType.number,
                      style: AppTextStyles.bodyRegular
                          .copyWith(color: AppColors.textPrimary),
                      decoration: _dropDecoration()
                          .copyWith(hintText: 'e.g. 5'),
                    ),
                    const SizedBox(height: 18),

                    //Education
                    Text('EDUCATION LEVEL',
                        style: AppTextStyles.labelLarge
                            .copyWith(color: AppColors.textPrimary)),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedEducation,
                      decoration: _dropDecoration(),
                      hint: Text('Select level',
                          style: AppTextStyles.bodyRegular
                              .copyWith(color: AppColors.textMuted)),
                      items: _educationLevels
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e,
                                  style: AppTextStyles.bodyRegular.copyWith(
                                      color: AppColors.textPrimary))))
                          .toList(),
                      onChanged: (v) =>
                          setState(() => _selectedEducation = v),
                    ),
                    const SizedBox(height: 18),

                    //Money Rate
                    Text('SERVICE RATE (\$/hr)',
                        style: AppTextStyles.labelLarge
                            .copyWith(color: AppColors.textPrimary)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text('\$${_serviceRate.toStringAsFixed(0)}',
                            style: AppTextStyles.titleLarge.copyWith(
                                color: AppColors.primary, fontSize: 28)),
                        const SizedBox(width: 8),
                        Text('/hr',
                            style: AppTextStyles.bodyMedium
                                .copyWith(color: AppColors.textMuted)),
                      ],
                    ),
                    Slider(
                      value: _serviceRate,
                      min: 0, max: 200,
                      divisions: 40,
                      activeColor: AppColors.primary,
                      onChanged: (v) => setState(() => _serviceRate = v),
                    ),
                    const SizedBox(height: 18),

                    //Skills
                    Text('SPECIALIZED SKILLS',
                        style: AppTextStyles.labelLarge
                            .copyWith(color: AppColors.textPrimary)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10, runSpacing: 10,
                      children: [
                        ..._skills.map((skill) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.card,
                                borderRadius:
                                    BorderRadius.circular(AppRadii.sm),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(skill,
                                      style: AppTextStyles.bodySmall.copyWith(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w500)),
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () => setState(
                                        () => _skills.remove(skill)),
                                    child: const Icon(Icons.close,
                                        size: 14, color: AppColors.textMuted),
                                  ),
                                ],
                              ),
                            )),
                        GestureDetector(
                          onTap: _showAddSkillDialog,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primary),
                              borderRadius:
                                  BorderRadius.circular(AppRadii.sm),
                            ),
                            child: Text('+ Add Skill',
                                style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => context.pop(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppRadii.sm)),
                        padding:
                            const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text('Discard',
                          style: AppTextStyles.buttonSmall.copyWith(
                              color: AppColors.textPrimary)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      label: 'Save Changes',
                      height: 52,
                      trailing: profState.isLoading
                          ? const SizedBox(
                              width: 18, height: 18,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2)
                                  )
                          : null,
                      onPressed: profState.isLoading
                          ? null
                          : () {
                              ref.read(professionalProvider.notifier).updateProfessional(
                                    id:              auth.user!.id,
                                    profession:      _selectedProfession,
                                    bio:             _bioController.text.trim(),
                                    location:        _locationController.text.trim(),
                                    experienceYears: int.tryParse( _experienceController.text),
                                    serviceRate:     _serviceRate,
                                    educationLevel:  _selectedEducation,
                                    skills:          _skills.join(','),
                                    photoBase64:     _photoBase64,
                                  );
                            },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}