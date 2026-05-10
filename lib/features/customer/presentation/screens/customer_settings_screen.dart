import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/customer_bottom_nav_bar.dart';

class CustomerSettingsScreen extends StatefulWidget {
	const CustomerSettingsScreen({super.key});

	@override
	State<CustomerSettingsScreen> createState() => _CustomerSettingsScreenState();
}

class _CustomerSettingsScreenState extends State<CustomerSettingsScreen> {
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
								child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primary)), Text('Settings', style: AppTextStyles.titleMedium.copyWith(fontSize: 24, color: AppColors.primary))]), const SizedBox(height: 22), Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadii.md)), child: Row(children: [Container(width: 84, height: 84, decoration: BoxDecoration(color: AppColors.neutral, borderRadius: BorderRadius.circular(2)), child: const Icon(Icons.person_outline_rounded, size: 52, color: AppColors.textPrimary)), const SizedBox(width: 18), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Your Name', style: AppTextStyles.titleSmall.copyWith(fontSize: 22, color: AppColors.primary)), const SizedBox(height: 6), Text('youremail@gmail.com', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textBody))])])), const SizedBox(height: 28), _sectionLabel('Account & Security'), const SizedBox(height: 12), const _SettingsCard(children: [_SettingsTile(icon: Icons.person_outline_rounded, title: 'Profile Information', subtitle: 'Update your name, phone, and address'), _SettingsTile(icon: Icons.lock_outline_rounded, title: 'Change Password', subtitle: '')]), const SizedBox(height: 24), _sectionLabel('Preferences'), const SizedBox(height: 12), _SettingsCard(children: [_SettingsSwitchTile(title: 'Dark Mode', subtitle: 'Switch to a darker theme', value: darkMode, onChanged: (value) => setState(() => darkMode = value)), const _SettingsTile(icon: Icons.notifications_none_rounded, title: 'Notification Settings', subtitle: 'Manage email and push alerts')]), const SizedBox(height: 24), _sectionLabel('Legal & Support'), const SizedBox(height: 12), const _SettingsCard(children: [_SettingsTile(icon: Icons.help_outline_rounded, title: 'Help Center', subtitle: ''), _SettingsTile(icon: Icons.description_outlined, title: 'Terms of Service', subtitle: '')]), const SizedBox(height: 28), SizedBox(width: double.infinity, child: OutlinedButton.icon(onPressed: () {}, style: OutlinedButton.styleFrom(foregroundColor: AppColors.primary, backgroundColor: AppColors.surface, side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))), icon: const Icon(Icons.logout_rounded, size: 18), label: Text('LOGOUT', style: AppTextStyles.titleSmall.copyWith(fontSize: 14, color: AppColors.primary)))), const SizedBox(height: 14), SizedBox(width: double.infinity, child: OutlinedButton.icon(onPressed: () {}, style: OutlinedButton.styleFrom(foregroundColor: AppColors.danger, backgroundColor: AppColors.surface, side: const BorderSide(color: Color(0xFFF2B8B5)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))), icon: const Icon(Icons.delete_outline_rounded, size: 18), label: Text('DELETE ACCOUNT', style: AppTextStyles.titleSmall.copyWith(fontSize: 14, color: AppColors.danger)))),]),
							),
						),
						CustomerBottomNavBar(currentIndex: 3, onTap: (index) {
							switch (index) {
								case 0:
									context.go(AppRoutes.customerDashboard);
									break;
								case 1:
									context.go(AppRoutes.customerRequests);
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
