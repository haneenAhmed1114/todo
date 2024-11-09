import 'package:flutter/material.dart';
import 'package:todo_application/shared/utils/app_colors.dart';

class CustomAuthTextfield extends StatelessWidget {
  const CustomAuthTextfield({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    required this.keyboardType,
    this.suffixIcon,
    this.isPassword = false,
    required this.validator,
    this.suffixPressed,
  });

  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool isPassword;
  final Function? suffixPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 15.0,
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              if (suffixPressed != null) suffixPressed!();
            },
            icon: Icon(
              suffixIcon,
              size: 20.0,
              color: Colors.black54,
            ),
          ),
          filled: true,
          fillColor: AppColors.textFieldLightColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.greyAppColor,
            fontSize: 18.0,
          ),
          prefixIcon: Icon(
            prefixIcon,
            size: 20.0,
            color: Colors.black54,
          ),
        ),
        validator: validator,
        obscureText: isPassword,
      ),
    );
  }
}
