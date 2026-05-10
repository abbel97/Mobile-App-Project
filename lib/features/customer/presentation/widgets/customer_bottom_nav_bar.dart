import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_bottom_navbar.dart';

class CustomerBottomNavBar extends StatelessWidget {
	const CustomerBottomNavBar({
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
				BottomNavItemData(label: 'HOME', icon: Icons.home_rounded),
				BottomNavItemData(label: 'REQUESTS', icon: Icons.assignment_rounded),
				BottomNavItemData(label: 'PROS', icon: Icons.groups_rounded),
				BottomNavItemData(label: 'SETTINGS', icon: Icons.settings_rounded),
			],
			currentIndex: currentIndex,
			onTap: onTap,
		);
	}
}
