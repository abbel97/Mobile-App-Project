import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/professional_bottom_nav_bar.dart';

class ProfessionalSettingsScreen extends StatefulWidget {
	const ProfessionalSettingsScreen({super.key});

	@override
	State<ProfessionalSettingsScreen> createState() => _ProfessionalSettingsScreenState();
}

class _ProfessionalSettingsScreenState extends State<ProfessionalSettingsScreen> {
	bool darkMode = false;

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: AppColors.background,
			body: SafeArea(
				child: Column(
					children: [
						Expanded(
							child: SingleChildScrollView(
								padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
								child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primary)), Text('Settings', style: AppTextStyles.titleMedium.copyWith(fontSize: 24, color: AppColors.primary))]), const SizedBox(height: 18), Center(child: Column(children: [Container(width: 110, height: 110, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 14, offset: const Offset(0, 6))]), child: const Icon(Icons.person_outline_rounded, size: 68, color: AppColors.textPrimary)), const SizedBox(height: 16), Text('Abebe Kebede', style: AppTextStyles.titleLarge.copyWith(fontSize: 28, color: AppColors.primary)), const SizedBox(height: 6), Text('EDIT PROFILE >', style: AppTextStyles.titleSmall.copyWith(fontSize: 14, color: AppColors.primary))])), const SizedBox(height: 24), _sectionLabel('PREFERENCES'), const SizedBox(height: 12), const _SettingsCard(children: [_SettingsTile(icon: Icons.notifications_none_rounded, title: 'Notification Settings', subtitle: 'Push, Email, and SMS')]), _SettingsCard(children: [_SettingsSwitchTile(title: 'Dark Mode', subtitle: '', value: false, onChanged: _noop),]), const SizedBox(height: 24), _sectionLabel('ACCOUNT'), const SizedBox(height: 12), const _SettingsCard(children: [_SettingsTile(icon: Icons.lock_outline_rounded, title: 'Change Password', subtitle: 'Make sure you are secured'), _SettingsTile(icon: Icons.language_rounded, title: 'Language', subtitle: 'English(US)')]), const SizedBox(height: 24), _sectionLabel('LEGAL'), const SizedBox(height: 12), const _SettingsCard(children: [_SettingsTile(icon: Icons.help_outline_rounded, title: 'Help Center', subtitle: ''), _SettingsTile(icon: Icons.description_outlined, title: 'Terms of Service', subtitle: '')]), const SizedBox(height: 24), SizedBox(width: double.infinity, child: OutlinedButton.icon(onPressed: () {}, style: OutlinedButton.styleFrom(foregroundColor: AppColors.primary, backgroundColor: AppColors.surface, side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))), icon: const Icon(Icons.logout_rounded, size: 18), label: Text('LOGOUT', style: AppTextStyles.titleSmall.copyWith(fontSize: 14, color: AppColors.primary)))), const SizedBox(height: 14), SizedBox(width: double.infinity, child: OutlinedButton.icon(onPressed: () {}, style: OutlinedButton.styleFrom(foregroundColor: AppColors.danger, backgroundColor: AppColors.surface, side: const BorderSide(color: Color(0xFFF2B8B5)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))), icon: const Icon(Icons.delete_outline_rounded, size: 18), label: Text('DELETE ACCOUNT', style: AppTextStyles.titleSmall.copyWith(fontSize: 14, color: AppColors.danger)))),]),
							),
						),
						ProfessionalBottomNavBar(currentIndex: 3, onTap: (index) {
							switch (index) {
								case 0:
									context.go(AppRoutes.professionalDashboard);
									break;
								case 1:
									context.go(AppRoutes.jobs);
									break;
								case 2:
									context.go(AppRoutes.professionalsList);
									break;
							}
						}),
					],
				),
			),
		);
	}

	Widget _sectionLabel(String text) {
		return Row(children: [const Expanded(child: Divider(color: AppColors.border)), Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text(text, style: AppTextStyles.labelMedium.copyWith(color: AppColors.textMuted, fontSize: 12))), const Expanded(child: Divider(color: AppColors.border))]);
	}

	static void _noop(bool value) {}
}

class _SettingsCard extends StatelessWidget {
	const _SettingsCard({required this.children});

	final List<Widget> children;

	@override
	Widget build(BuildContext context) {
		return Container(decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(2), border: Border.all(color: AppColors.border.withValues(alpha: 0.5))), child: Column(children: children));
	}
}

class _SettingsTile extends StatelessWidget {
	const _SettingsTile({required this.icon, required this.title, required this.subtitle});

	final IconData icon;
	final String title;
	final String subtitle;

	@override
	Widget build(BuildContext context) {
		return Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16), child: Row(children: [Icon(icon, color: AppColors.primary, size: 22), const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: AppTextStyles.titleSmall.copyWith(fontSize: 16, color: AppColors.textPrimary)), if (subtitle.isNotEmpty) ...[const SizedBox(height: 4), Text(subtitle, style: AppTextStyles.bodySmall.copyWith(fontSize: 13))]])), const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted)]));
	}
}

class _SettingsSwitchTile extends StatelessWidget {
	const _SettingsSwitchTile({required this.title, required this.subtitle, required this.value, required this.onChanged});

	final String title;
	final String subtitle;
	final bool value;
	final ValueChanged<bool> onChanged;

	@override
	Widget build(BuildContext context) {
		return Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16), child: Row(children: [const Icon(Icons.dark_mode_outlined, color: AppColors.primary, size: 22), const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: AppTextStyles.titleSmall.copyWith(fontSize: 16, color: AppColors.textPrimary)), if (subtitle.isNotEmpty) ...[const SizedBox(height: 4), Text(subtitle, style: AppTextStyles.bodySmall.copyWith(fontSize: 13))]])), Switch(value: value, onChanged: onChanged)]));
	}
}
