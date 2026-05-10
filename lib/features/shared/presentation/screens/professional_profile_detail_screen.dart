import 'package:flutter/material.dart';

import '../../../../core/widgets/placeholder_screen.dart';

class ProfessionalProfileDetailScreen extends StatelessWidget {
	const ProfessionalProfileDetailScreen({super.key, required this.professionalId});

	final String professionalId;

	@override
	Widget build(BuildContext context) {
		return PlaceholderScreen(title: 'Professional Profile Detail\nID: $professionalId');
	}
}
