import 'package:flutter/material.dart';

/// A custom wide button widget that can be used throughout the app.
/// It is a stateless widget that takes a label, an icon, and an onPressed callback.
/// The button can be filled or not, depending on the value of the `fill` parameter.
/// The button is designed to be wide, filling the available width if `fill` is true.
/// The button uses the `FilledButton` widget from the Flutter Material library.
class WideButton extends StatelessWidget {
  const WideButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.fill = true,
    super.key,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool fill;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fill ? double.infinity : null,
      child: FilledButton.icon(
        icon: Icon(icon),
        iconAlignment: IconAlignment.end,
        label: Text(label),
        onPressed: onPressed,
      ),
    );
  }
}
