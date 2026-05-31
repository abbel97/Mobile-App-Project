import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/presentation/providers/auth_notifier.dart';
import '../../../professional/presentation/providers/professional_notifier.dart';

class ProfessionalsListScreen extends ConsumerStatefulWidget {
  final bool showCta;
  final Widget? bottomNavigationBar;

  const ProfessionalsListScreen({
    super.key,
    this.showCta = true,
    this.bottomNavigationBar,
  });

  @override
  ConsumerState<ProfessionalsListScreen> createState() => _ProfessionalsListScreenState();
}

class _ProfessionalsListScreenState extends ConsumerState<ProfessionalsListScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(professionalProvider.notifier).refreshProfessionals();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(professionalProvider);
    final auth = ref.watch(authProvider);
    final filteredProfessionals = state.professionals.where((p) {
      final query = _searchQuery.trim().toLowerCase();
      if (query.isEmpty) return true;
      return [p.name, p.profession, p.location ?? '']
          .any((value) => value.toLowerCase().contains(query));
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: widget.bottomNavigationBar,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.neutral,
                      borderRadius: BorderRadius.circular(AppRadii.md),
                    ),
                    child: IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back_rounded,
                          color: AppColors.primary),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text('Professionals',
                      style: AppTextStyles.titleMedium
                          .copyWith(color: AppColors.primary, fontSize: 18)),
                ],
              ),
              const SizedBox(height: 22),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadii.md),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded,
                        color: AppColors.tertiary, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) => setState(() => _searchQuery = value),
                        decoration: InputDecoration(
                          hintText: 'Search name, trade, or location',
                          hintStyle: AppTextStyles.bodyRegular
                              .copyWith(color: AppColors.textMuted),
                          border: InputBorder.none,
                          isDense: true,
                          suffixIcon: _searchQuery.isEmpty
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() => _searchQuery = '');
                                  },
                                  icon: const Icon(Icons.close_rounded,
                                      color: AppColors.textMuted, size: 18),
                                ),
                        ),
                        style: AppTextStyles.bodyRegular
                            .copyWith(color: AppColors.textPrimary),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              if (state.isLoading && state.professionals.isEmpty)
                const Center(child: CircularProgressIndicator())
              else if (filteredProfessionals.isEmpty)
                Center(
                  child: Text(
                    _searchQuery.trim().isEmpty
                        ? 'No professionals registered yet'
                        : 'No professionals match your search',
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.textMuted),
                  ),
                )
              else
                ...filteredProfessionals.map((p) => _ProfessionalCard(
                      name: p.name,
                      title: p.profession,
                      experience: '${p.experienceYears} years experience',
                      photoBase64: p.photoBase64,
                      onTap: () => context.push(
                          AppRoutes.professionalProfileDetailPath(p.id)),
                    )),

              if (widget.showCta && auth.isCustomer) ...[
                const SizedBox(height: 8),
                const _SupportPromo(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfessionalCard extends StatelessWidget {
  const _ProfessionalCard({
    required this.name,
    required this.title,
    required this.experience,
    required this.photoBase64,
    required this.onTap,
  });

  final String       name;
  final String       title;
  final String       experience;
  final String?      photoBase64;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
        child: Row(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFF1F2937),
                borderRadius: BorderRadius.circular(AppRadii.md),
                image: (photoBase64 != null && photoBase64!.isNotEmpty)
                    ? DecorationImage(
                        image: MemoryImage(base64Decode(photoBase64!)),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: (photoBase64 != null && photoBase64!.isNotEmpty)
                  ? null
                  : const Icon(Icons.person, color: AppColors.surface, size: 42),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: AppTextStyles.titleSmall.copyWith(
                          fontSize: 18, color: AppColors.primary)),
                  const SizedBox(height: 4),
                  Text(title,
                      style: AppTextStyles.titleSmall.copyWith(
                          fontSize: 14, color: AppColors.secondary)),
                  const SizedBox(height: 4),
                  Text(experience,
                      style: AppTextStyles.bodyRegular.copyWith(
                          fontSize: 13, color: AppColors.textBody)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: AppColors.tertiary, size: 28),
          ],
        ),
      ),
    );
  }
}


class _SupportPromo extends StatelessWidget {  
  const _SupportPromo();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppRadii.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Can't find the right\nexpert?",
              style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.neutral.withValues(alpha: 0.9))),
          const SizedBox(height: 18),
          Text(
            "Tell us about your project and we'll match you with the best available professional.",
            style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.neutral.withValues(alpha: 0.6)),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity, height: 52,
            child: ElevatedButton(
              onPressed: () => context.push(AppRoutes.customerRequestSubmit),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.surface,
                foregroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadii.md)),
                elevation: 0,
              ),
              child: Text(
                'Submit your issue',
                style: AppTextStyles.titleSmall
                    .copyWith(color: AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}