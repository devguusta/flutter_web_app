import 'package:flutter/material.dart';
import 'package:flutter_web_app/core/theme/theme_extensions.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    required this.labelText,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.onChanged,
    this.focusNode,
    this.textInputAction,
    super.key,
  });

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      controller: controller,
      keyboardType: keyboardType,
      style: context.textStyles.body.copyWith(
        color: context.colors.white,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: context.colors.black,
        labelText: labelText,
        labelStyle: context.textStyles.body.copyWith(
          color: (context.colors).secondary,
        ),
        hintStyle: context.textStyles.body.copyWith(
          color: (context.colors).secondary,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(
            width: 2.5,
            color: context.colors.borderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(
            width: 2.5,
            color: context.colors.borderColor,
          ),
        ),
      ),
      focusNode: focusNode,
      textInputAction: textInputAction,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
