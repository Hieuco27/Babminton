import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_colors.dart';

class TextStyles {
  static TextStyle displayLarge(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.bold,
      color: color ?? Theme.of(context).textTheme.displayLarge?.color ?? AppColors.textPrimaryDark,
      letterSpacing: -0.5,
    );
  }

  static TextStyle headingLarge(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
      color: color ?? Theme.of(context).textTheme.headlineLarge?.color ?? AppColors.textPrimaryDark,
    );
  }

  static TextStyle headingMedium(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: color ?? Theme.of(context).textTheme.headlineMedium?.color ?? AppColors.textPrimaryDark,
    );
  }

  static TextStyle bodyMedium(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.normal,
      color: color ?? Theme.of(context).textTheme.bodyMedium?.color ?? AppColors.textSecondaryDark,
    );
  }

  static TextStyle caption(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: color ?? Theme.of(context).textTheme.bodySmall?.color ?? AppColors.textSecondaryDark,
    );
  }
}
