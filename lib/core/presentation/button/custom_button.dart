import 'package:flutter/material.dart';
import 'package:flutter_web_app/core/theme/theme_extensions.dart';

/// A custom primary button widget that can be used throughout the app.
/// It is a stateless widget that takes an onPressed callback, a title, and a loading state.
/// The button can be enabled or disabled, and it can show a loading indicator when isLoading is true.
/// The button uses the `ElevatedButton` widget from the Flutter Material library.
class CustonPrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final bool enabled;
  final bool isLoading;
  final Color? customColor;
  const CustonPrimaryButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.enabled = true,
    this.isLoading = false,
    this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final buttonColor = customColor ?? colors.primary;
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          enabled ? buttonColor : buttonColor.withValues(alpha: 0.35),
        ),
        side: enabled
            ? WidgetStatePropertyAll(BorderSide(
                color: colors.background,
                width: 1.5,
              ))
            : WidgetStatePropertyAll(BorderSide(
                color: colors.background.withValues(alpha: 0.35),
                width: 1.5,
              )),
      ),
      onPressed: enabled ? onPressed : null,
      child: isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Text(
              title,
            ),
    );
  }
}
