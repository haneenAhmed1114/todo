import 'package:flutter/material.dart';
import 'package:todo_application/shared/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
   const CustomTextField({super.key, this.hint , required this.controller, this.type, this.maxLines, this.validator});


  final String? hint ;
  final TextEditingController controller ;
  final TextInputType? type ;
  final int? maxLines  ;
  final String? Function(String?)? validator ;

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      maxLines: maxLines,
      keyboardType: type,
      cursorColor: AppColors.kohliAppColor,
      controller: controller,
      style: const TextStyle(
        fontSize: 20.0 ,
        color: AppColors.kohliAppColor,
      ),
      validator: validator ,
      decoration:  InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 20 ,
          fontWeight: FontWeight.w400,
          color: AppColors.greyAppColor,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.kohliAppColor,
          ),
        ),
        focusedBorder:  const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.kohliAppColor,
          ),
        ),
      ),
    );
  }
}
