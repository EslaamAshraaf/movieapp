import 'package:flutter/material.dart';
import 'package:movieapp/src/core/theme/app_color.dart';

class AppTextFormField extends StatelessWidget {
  final String label;
  final String? hintText;
  final String? iconPath;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;

  const AppTextFormField({
    super.key,
    required this.label,
    this.hintText,
    this.iconPath,
    this.suffixIcon,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white), // text color
      decoration: InputDecoration(
        prefixIcon: iconPath != null
            ? ImageIcon(AssetImage(iconPath!),color: AppColors.yellow,)
            : null,
        suffixIcon: suffixIcon,
        labelText: label,
        hintText: hintText,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color(0xff282A28),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
