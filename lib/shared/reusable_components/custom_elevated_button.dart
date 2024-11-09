import 'package:flutter/material.dart';
import 'package:todo_application/shared/utils/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
   const CustomElevatedButton({super.key,required this.onPressed,required this.text,this.backgroundColor});
  final void Function()? onPressed ;
  final String text ;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        ),
        onPressed:onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize:  20 ,
            color: AppColors.whiteAppColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
