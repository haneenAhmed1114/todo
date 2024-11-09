import 'package:flutter/material.dart';
import 'package:todo_application/shared/utils/app_colors.dart';
import 'package:todo_application/shared/utils/app_styles.dart';

abstract class AppTheme
{
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.bgColorLight,
    primaryColor: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(
      titleTextStyle: AppStyles.appBarStyleLight,
      color: AppColors.transparentColor,
      foregroundColor: AppColors.whiteAppColor,
      centerTitle: false,
      elevation: 0.0,
    ),
    textTheme:const TextTheme(
      titleLarge: AppStyles.appBarStyleLight,
      titleMedium: AppStyles.cardTitleLight,
      headlineMedium: AppStyles.cardTitleDone,
      labelSmall: AppStyles.cardSubTitleLight,
      labelLarge: AppStyles.dateActiveStyleLight,
      labelMedium: AppStyles.dateInactiveStyleLight,
      headlineLarge: AppStyles.bottomSheetHeaderLight,
    ),
    //useMaterial3: true,
    colorScheme:const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.whiteAppColor,
      secondary: AppColors.whiteAppColor,
      onSecondary: AppColors.blackAppColor,
      error: AppColors.redAppColor,
      onError: AppColors.kohliAppColor,
      surface: AppColors.whiteAppColor,
      onSurface: AppColors.primaryColor,
    ),
    cardTheme:const CardTheme(
      color: AppColors.whiteAppColor,
      margin: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 5.0,
      )
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0.0,
      backgroundColor: AppColors.whiteAppColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.greColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        color: AppColors.primaryColor,
        size: 25.0,
      ),
    ),
    floatingActionButtonTheme:const  FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.whiteAppColor,
      shape: CircleBorder(side: BorderSide(width: 4.0,color: AppColors.whiteAppColor,),),
      iconSize: 30.0
    ),
    datePickerTheme: const DatePickerThemeData(
      headerBackgroundColor: AppColors.primaryColor,
      headerForegroundColor: AppColors.whiteAppColor,
      backgroundColor: AppColors.whiteAppColor,
    ),

  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.kohliAppColor,
    primaryColor: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(
      titleTextStyle: AppStyles.appBarStyleDark,
      color: AppColors.transparentColor,
      foregroundColor: AppColors.bgColorDark,
      centerTitle: false,
      elevation: 0.0,
    ),
    textTheme: const TextTheme(
      titleLarge: AppStyles.appBarStyleDark,
      headlineMedium: AppStyles.cardTitleDone,
      titleMedium: AppStyles.cardTitleLight,
      labelSmall: AppStyles.cardSubTitleDark,
      labelLarge: AppStyles.dateActiveStyleLight,
      labelMedium: AppStyles.dateInactiveStyleDark,
      headlineLarge: AppStyles.bottomSheetHeaderDark,
    ),
    colorScheme:const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.whiteAppColor,
      secondary: AppColors.blackAppColor,
      onSecondary: AppColors.whiteAppColor,
      error: AppColors.redAppColor,
      onError: AppColors.kohliAppColor,
      surface: AppColors.whiteAppColor,
      onSurface: AppColors.primaryColor,
    ),
    cardTheme:const CardTheme(
        color: AppColors.blackAppColor,
        margin: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5.0,
        )
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0.0,
      backgroundColor: AppColors.blackAppColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.whiteAppColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        color: AppColors.primaryColor,
        size: 25.0,
      ),
    ),
  );
}