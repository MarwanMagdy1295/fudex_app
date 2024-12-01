import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaf_app/src/core/utils/app_colors.dart';

class AppTheme {
  static TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 22.0.sp,
      color: AppColors.appBlack,
      fontFamily: 'HelveticaNeueLTArabic-Bold 2',
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0.sp,
      color: AppColors.appBlack,
      fontFamily: 'HelveticaNeueLTArabic-Bold',
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16.0.sp,
      color: AppColors.appBlack,
      fontFamily: 'HelveticaNeueLTArabic-Light 2',
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14.0.sp,
      color: AppColors.appBlack,
      fontFamily: 'HelveticaNeueLTArabic-Light',
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 13.0.sp,
      color: AppColors.appBlack,
      fontFamily: 'HelveticaNeueLTArabic-Roman 2',
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12.0.sp,
      color: AppColors.appBlack,
      fontFamily: 'HelveticaNeueLTArabic-Roman',
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14.0.sp,
      color: AppColors.appBlack,
      fontFamily: 'HelveticaNeueLTArabic-Roman',
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 10.0.sp,
      color: AppColors.appBlack,
      fontFamily: 'HelveticaNeueLTArabic-Roman 2',
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 8.0.sp,
      color: AppColors.appBlack,
    ),
  );
}
