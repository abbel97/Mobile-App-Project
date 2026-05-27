import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../auth/presentation/providers/auth_notifier.dart';
import '../../domain/entities/professional_entity.dart';
import '../providers/professional_notifier.dart';

class ProfessionalEditScreen extends ConsumerStatefulWidget {
  const ProfessionalEditScreen({super.key});

  @override
  ConsumerState<ProfessionalEditScreen> createState() =>
      _ProfessionalEditScreenState();
}

class _ProfessionalEditScreenState extends ConsumerState<ProfessionalEditScreen> {
  final _bioController = TextEditingController();
  final _locationController = TextEditingController();
  final _professionController = TextEditingController();
  final _experienceController = TextEditingController();
  final _educationController = TextEditingController();
  final _rateController = TextEditingController();

  int _bioCharCount = 0;
  static const int _maxBioChars = 5000;

  List<String> _skills = [];
  List<String> _certifications = [];
  bool _seededFromProfile = false;

  @override
  void initState() {
    super.initState();
    _bioController.addListener(() {
      if (!mounted) return;
      setState(() => _bioCharCount = _bioController.text.length);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(professionalProvider.notifier).loadMyProfile();
    });
  }

  @override
  void dispose() {
    _bioController.dispose();
    _locationController.dispose();
    _professionController.dispose();
    _experienceController.dispose();
    _educationController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  void _seedFields(ProfessionalEntity profile) {
    _professionController.text = profile.profession;
    _bioController.text = profile.bio;
    _locationController.text = profile.location;
    _experienceController.text = profile.experienceYears.toString();
    _educationController.text = profile.educationLevel;
    _rateController.text = profile.serviceRate.toStringAsFixed(2);

    _skills = _splitCsv(profile.bio).take(0).toList();
    _certifications = [];
    _bioCharCount = _bioController.text.length;
  }

  List<String> _splitCsv(String value) {
    return value
        .split(',')
        .map((part) => part.trim())
        .where((part) => part.isNotEmpty)
        .toList();
  }

  Future<void> _showAddItemDialog({
    required String title,
    required void Function(String) onAdd,
  }) async {
    final controller = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          title,
          style: AppTextStyles.titleMedium.copyWith(color: AppColors.textPrimary),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Type and tap Add'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                onAdd(text);
              }
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveProfile() async {
    final auth = ref.read(authProvider).user;
    final profession = _professionController.text.trim();
    final bio = _bioController.text.trim();
    final location = _locationController.text.trim();
    final experienceYears = int.tryParse(_experienceController.text.trim()) ?? 0;
    final serviceRate = double.tryParse(_rateController.text.trim()) ?? 0;
    final educationLevel = _educationController.text.trim();

    if (profession.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profession is required')),
      );
      return;
    }

    await ref.read(professionalProvider.notifier).updateMyProfile(
          name: auth?.name ?? '',
          email: auth?.email ?? '',
          profession: profession,
          bio: bio,
          location: location,
          experienceYears: experienceYears,
          serviceRate: serviceRate,
          educationLevel: educationLevel,
        );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final state = ref.watch(professionalProvider);

    ref.listen<ProfessionalState>(professionalProvider, (_, next) {
      if (!mounted) return;
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!), backgroundColor: AppColors.danger),
        );
        ref.read(professionalProvider.notifier).clearError();
      }
      if (next.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
        ref.read(professionalProvider.notifier).clearSuccess();
      }
    });

    final profile = state.profile;
    if (!_seededFromProfile && profile != null) {
      _seedFields(profile);
      _seededFromProfile = true;
    }

    final name = authState.user?.name.trim().isNotEmpty == true
        ? authState.user!.name.trim()
        : 'Professional User';
    final email = authState.user?.email.trim().isNotEmpty == true
        ? authState.user!.email.trim()
        : 'No email';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: state.isLoading && profile == null
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => context.pop(),
                                icon: const Icon(
                                  Icons.arrow_back_rounded,
                                  color: AppColors.primary,
                                ),
                              ),
                              Text(
                                'Edit Profile',
                                style: AppTextStyles.titleMedium.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  width: 96,
                                  height: 96,
                                  decoration: BoxDecoration(
                                    color: AppColors.neutral,
                                    borderRadius: BorderRadius.circular(AppRadii.md),
                                  ),
                                  child: const Icon(
                                    Icons.person_outline_rounded,
                                    size: 58,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  name,
                                  style: AppTextStyles.titleLarge.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  email,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.textBody,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          _label('PROFESSION'),
                          const SizedBox(height: 10),
                          _input(controller: _professionController, hint: 'Profession'),
                          const SizedBox(height: 16),
                          _label('EXPERIENCE (YEARS)'),
                          const SizedBox(height: 10),
                          _input(
                            controller: _experienceController,
                            hint: 'Years of experience',
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16),
                          _label('EDUCATION LEVEL'),
                          const SizedBox(height: 10),
                          _input(controller: _educationController, hint: 'Education level'),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _label('PROFESSIONAL OVERVIEW'),
                              Text(
                                '$_bioCharCount / $_maxBioChars',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _bioController,
                            maxLines: 6,
                            style: AppTextStyles.bodyRegular.copyWith(
                              color: AppColors.textPrimary,
                            ),
                            decoration: _fieldDecoration('Describe your experience...'),
                          ),
                          const SizedBox(height: 24),
                          _label('PRIMARY LOCATION'),
                          const SizedBox(height: 10),
                          _input(
                            controller: _locationController,
                            hint: 'Location',
                            prefixIcon: const Icon(Icons.place_outlined),
                          ),
                          const SizedBox(height: 24),
                          _sectionHeader(
                            title: 'CERTIFICATIONS',
                            onAdd: () => _showAddItemDialog(
                              title: 'Add Certificate',
                              onAdd: (value) {
                                setState(() => _certifications.add(value));
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          _tagWrap(
                            values: _certifications,
                            emptyText: 'No certificates added yet',
                            onRemove: (item) {
                              setState(() => _certifications.remove(item));
                            },
                          ),
                          const SizedBox(height: 24),
                          _sectionHeader(
                            title: 'SPECIALIZED SKILLS',
                            onAdd: () => _showAddItemDialog(
                              title: 'Add Skill',
                              onAdd: (value) {
                                setState(() => _skills.add(value));
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          _tagWrap(
                            values: _skills,
                            emptyText: 'No skills added yet',
                            onRemove: (item) {
                              setState(() => _skills.remove(item));
                            },
                          ),
                          const SizedBox(height: 24),
                          _label('HOURLY RATE'),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.inputFill,
                              borderRadius: BorderRadius.circular(AppRadii.sm),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '\$',
                                  style: AppTextStyles.titleLarge.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    controller: _rateController,
                                    keyboardType: const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '0.00',
                                    ),
                                    style: AppTextStyles.titleLarge.copyWith(
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                Text(
                                  '/hr',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
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
                          borderRadius: BorderRadius.circular(AppRadii.sm),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        'Discard Changes',
                        style: AppTextStyles.buttonSmall.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      label: state.isSaving ? 'Saving...' : 'Save Changes',
                      height: 52,
                      onPressed: state.isSaving ? null : _saveProfile,
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

  Widget _label(String value) {
    return Text(
      value,
      style: AppTextStyles.labelLarge.copyWith(color: AppColors.textPrimary),
    );
  }

  Widget _input({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    Widget? prefixIcon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: AppTextStyles.bodyRegular.copyWith(color: AppColors.textPrimary),
      decoration: _fieldDecoration(hint, prefixIcon: prefixIcon),
    );
  }

  InputDecoration _fieldDecoration(String hint, {Widget? prefixIcon}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: prefixIcon,
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
      contentPadding: const EdgeInsets.all(14),
    );
  }

  Widget _sectionHeader({required String title, required VoidCallback onAdd}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _label(title),
        TextButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add_circle_outline_rounded, size: 16),
          label: const Text('Add'),
        ),
      ],
    );
  }

  Widget _tagWrap({
    required List<String> values,
    required String emptyText,
    required void Function(String) onRemove,
  }) {
    if (values.isEmpty) {
      return Text(
        emptyText,
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
      );
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: values
          .map(
            (item) => _RemovableTag(
              label: item,
              onRemove: () => onRemove(item),
            ),
          )
          .toList(),
    );
  }
}

class _RemovableTag extends StatelessWidget {
  const _RemovableTag({required this.label, required this.onRemove});

  final String label;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadii.sm),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close, size: 14, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
