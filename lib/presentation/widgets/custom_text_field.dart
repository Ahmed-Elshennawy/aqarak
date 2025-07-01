// lib/presentation/widgets/custom_text_field.dart
import 'package:aqarak/core/constants/app_colors.dart';
import 'package:aqarak/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final String? Function(String?) validator;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryGreen, AppColors.primaryBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(prefixIcon, color: AppColors.accentBlue),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          //   borderSide: BorderSide.none,
          // ),
          filled: true,
          // fillColor: Colors.white,
          // contentPadding: const EdgeInsets.all(AppSizes.padding / 2),
        ),
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }
}
