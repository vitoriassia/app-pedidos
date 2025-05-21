import 'package:flutter/material.dart';
import 'package:pedidos_app/core/design_system/styles/input_decorations.dart';

enum AppTextFieldStyle { outline, normal }

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final AppTextFieldStyle style;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.style = AppTextFieldStyle.outline,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator:
          validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Enter $label';
            }
            return null;
          },
      decoration:
          style == AppTextFieldStyle.outline
              ? InputDecorations.outline(
                label: label,
                context: context,
              ).copyWith(prefixIcon: prefixIcon, suffixIcon: suffixIcon)
              : InputDecoration(
                labelText: label,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
              ),
    );
  }
}
