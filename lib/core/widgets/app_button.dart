import 'package:flutter/material.dart';

import 'primary_button.dart';

class AppButton extends StatelessWidget {
	const AppButton({
		super.key,
		required this.label,
		this.onPressed,
		this.trailing,
	});

	final String label;
	final VoidCallback? onPressed;
	final Widget? trailing;

	@override
	Widget build(BuildContext context) {
		return PrimaryButton(
			label: label,
			onPressed: onPressed,
			trailing: trailing,
		);
	}
}
