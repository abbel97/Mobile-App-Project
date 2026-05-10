import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_bottom_navbar.dart';

class ProfessionalBottomNavBar extends StatelessWidget {
	const ProfessionalBottomNavBar({
		super.key,
		required this.currentIndex,
		this.onTap,
	});

	final int currentIndex;
	final ValueChanged<int>? onTap;

	@override
	Widget build(BuildContext context) {
		return CustomBottomNavbar(
			items: const [
				BottomNavItemData(label: 'DASHBOARD', icon: Icons.grid_view_rounded),
				BottomNavItemData(label: 'JOBS', icon: Icons.assignment_rounded),
				BottomNavItemData(label: 'COLLEAGUES', icon: Icons.groups_rounded),
				BottomNavItemData(label: 'SETTINGS', icon: Icons.settings_rounded),
			],
			currentIndex: currentIndex,
			onTap: onTap,
		);
	}
}
