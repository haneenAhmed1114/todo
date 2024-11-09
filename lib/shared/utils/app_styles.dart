import 'package:flutter/material.dart';
import 'package:todo_application/shared/utils/app_colors.dart';

abstract class AppStyles
{
  static const TextStyle appBarStyleLight       = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.whiteAppColor,
  );
  static const TextStyle appBarStyleDark        = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.bgColorDark,
  );
  static const TextStyle cardTitleLight         = TextStyle(
    fontSize: 18 ,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryColor,
  );
  static const TextStyle cardSubTitleLight      = TextStyle(
    fontSize: 12,
    color:  AppColors.kohliAppColor,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle cardSubTitleDark       = TextStyle(
    fontSize: 12,
    color:  AppColors.whiteAppColor,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle dateActiveStyleLight   = TextStyle(
    fontSize: 15 ,
    fontWeight: FontWeight.w700,
    color:  AppColors.primaryColor,
  );
  static const TextStyle dateInactiveStyleLight = TextStyle(
    fontSize: 14 ,
    fontWeight: FontWeight.w700,
    color:  AppColors.kohliAppColor,
  );
  static const TextStyle dateInactiveStyleDark  = TextStyle(
    fontSize: 14 ,
    fontWeight: FontWeight.w700,
    color:  AppColors.whiteAppColor,
  );
  static const TextStyle cardTitleDone          = TextStyle(
    fontSize: 18 ,
    fontWeight: FontWeight.w700,
    color: AppColors.greenAppColor,
  );
  static const TextStyle bottomSheetHeaderLight = TextStyle(
    fontSize: 18 ,
    fontWeight: FontWeight.w700,
    color:  AppColors.blackColorHeaderSheet,
  );
  static const TextStyle bottomSheetHeaderDark = TextStyle(
    fontSize: 18 ,
    fontWeight: FontWeight.w700,
    color:  AppColors.whiteAppColor,
  );


}