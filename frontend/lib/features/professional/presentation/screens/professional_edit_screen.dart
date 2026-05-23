import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';

class ProfessionalEditScreen extends StatefulWidget {
  const ProfessionalEditScreen({super.key});

  @override
  State<ProfessionalEditScreen> createState() => _ProfessionalEditScreenState();
}

class _ProfessionalEditScreenState extends State<ProfessionalEditScreen> {
  final _bioController = TextEditingController(
    text:
        'With over 12 years of specialized experience in residential electrical systems and cutting-edge smart home integrations, I provide homeowners with meticulous, future-proof solutions. My approach combines architectural precision with modern technological excellence.',
  );
  final _locationController = TextEditingController(text: 'Ethiopia, A.A');
  final _rateController = TextEditingController(text: '12.00');


  int _bioCharCount = 0;
  static const int _maxBioChars = 5000;

  List<String> _skills = [
    'Electrical Panels',
    'Smart Lighting',
    'EV Charging',
    'Whole Home Audio',
    'Surge Protection',
  ];

  @override
  void initState() {
    super.initState();
    _bioCharCount = _bioController.text.length;
    _bioController.addListener(() {
      setState(() => _bioCharCount = _bioController.text.length);
    });
  }

  @override
  void dispose() {
    _bioController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _showAddSkillDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Add Skill',
          style: AppTextStyles.titleMedium.copyWith(color: AppColors.textPrimary),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'e.g. Solar Panels'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() => _skills.add(controller.text.trim()));
              }
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
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
                              Positioned(
                                right: -4,
                                bottom: -4,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  child: const Icon(
                                    Icons.edit_outlined,
                                    size: 14,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Text(
                            'Abebe Kebede',
                            style: AppTextStyles.headline2.copyWith(
                              fontSize: 30,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Master Electrical & Smart Home Specialist',
                            style: AppTextStyles.titleSmall.copyWith(
                              color: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
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
                        Positioned(
                          right: -4,
                          bottom: -4,
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: const Icon(
                              Icons.edit_outlined,
                              size: 14,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Abebe Kebede',
                      style: AppTextStyles.headline2.copyWith(
                        fontSize: 24,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Master Electrical & Smart Home Specialist',
                      style: AppTextStyles.titleSmall.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // ── Professional Overview ──────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'PROFESSIONAL OVERVIEW',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          '$_bioCharCount / $_maxBioChars characters',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textMuted,
                            fontSize: 12,
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
                      decoration: InputDecoration(
                        hintText: 'Describe your professional experience...',
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
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                    const SizedBox(height: 28),

                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'CERTIFICATIONS & LICENSES',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO: add certification
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.add_circle_outline_rounded,
                                size: 16,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Add New',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const _CertCard(
                      title: 'Master Electrician License',
                      issuer: 'AAU Union of Contractors',
                      year: '2026',
                    ),
                    const SizedBox(height: 10),
                    const _CertCard(
                      title: 'Uranium Platinum Certified Pro',
                      issuer: 'AAU Electronics',
                      year: '2025',
                    ),
                    const SizedBox(height: 28),

                    Text(
                      'PRIMARY LOCATION',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                   TextField(
                    controller: _locationController,
                    style: AppTextStyles.bodyRegular.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Location',
                      prefixIcon: const Icon(Icons.place_outlined),

                      filled: true,
                      fillColor: AppColors.inputFill,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadii.sm),
                      ),
                    ),
                  ),
                    const SizedBox(height: 28),

                    Text(
                      'SPECIALIZED SKILLS',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        ..._skills.map(
                          (skill) => _RemovableSkillChip(
                            label: skill,
                            onRemove: () =>
                                setState(() => _skills.remove(skill)),
                          ),
                        ),
                        GestureDetector(
                          onTap: _showAddSkillDialog,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primary,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(AppRadii.sm),
                            ),
                            child: Text(
                              '+ Add Skill',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadii.md),
                        border: const Border(
                          left: BorderSide(color: AppColors.primary, width: 4),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SERVICE RATE',
                            style: AppTextStyles.labelLarge.copyWith(
                              color: AppColors.textMuted,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(height: 8),
                      Row(
                      children: [
                        const Text(
                          '\$',
                          style: TextStyle(fontSize: 28),
                        ),

                        const SizedBox(width: 6),

                        Expanded(
                          child: TextField(
                            controller: _rateController,
                            keyboardType: TextInputType.number,
                            style: AppTextStyles.headline2.copyWith(
                              fontSize: 28,
                              color: AppColors.textPrimary,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '0.00',
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
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              // TODO: change hourly rate
                            },
                            child: Text(
                              'Change hourly rate',
                              style: AppTextStyles.titleSmall.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // ── Persistent bottom buttons ──────────────────
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
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      label: 'Save Changes',
                      height: 52,
                      onPressed: () {
                        // TODO: handle save
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

class _CertCard extends StatelessWidget {
  const _CertCard({
    required this.title,
    required this.issuer,
    required this.year,
  });

  final String title;
  final String issuer;
  final String year;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.sm),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.verified_outlined,
            color: AppColors.secondary,
            size: 28,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$issuer • Issued $year',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textBody,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RemovableSkillChip extends StatelessWidget {
  const _RemovableSkillChip({required this.label, required this.onRemove});
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
            child: const Icon(
              Icons.close,
              size: 14,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}