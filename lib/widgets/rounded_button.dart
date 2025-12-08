// lib/src/widgets/primary_button.dart
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool disabled;
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    this.disabled = false,
  });
  @override
  Widget build(BuildContext ctx) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(label, style: Theme.of(ctx).textTheme.button),
        ),
      ),
    );
  }
}
