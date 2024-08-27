import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';
import 'my_fonts.dart';
import 'my_theme_colors.dart';

class AppTS {
  static TextStyle drawerListTileTS =
      TextStyle(color: AppColors.appBlack, fontSize: 14.sp);

  static TextStyle white18TS =
      TextStyle(color: AppColors.white, fontSize: 18.sp);
  static TextStyle secondary16TS = TextStyle(
      color: AppColors.appBlack, fontSize: 16.sp, fontWeight: FontWeight.w500);
  static TextStyle homeHeadingTS = TextStyle(
      color: AppColors.black, fontSize: 14.sp, fontWeight: FontWeight.w500);
  static TextStyle homeTextFieldTS = TextStyle(
      color: AppColors.appBlack, fontSize: 14.sp, fontWeight: FontWeight.w700);
  static TextStyle homeLabelTS = TextStyle(
      color: AppColors.appBlack, fontSize: 14.sp, fontWeight: FontWeight.w400);
  static TextStyle homeBottomNavLabelTS = TextStyle(
      color: AppColors.appBlack, fontSize: 12.sp, fontWeight: FontWeight.w400);
  static TextStyle titlePrimaryTS = TextStyle(
      color: AppColors.primary, fontSize: 18.sp, fontWeight: FontWeight.w600);
  static TextStyle labelGreyTS = TextStyle(
      color: AppColors.appBlack, fontSize: 16.sp, fontWeight: FontWeight.w600);

  ///text theme
  static TextTheme getDarkTextTheme() => TextTheme(
        //Display
        displayLarge: (MyFonts.displayTextStyle).copyWith(
            fontSize: MyFonts.displayLargeTextSize,
            height: 57,
            fontWeight: FontWeight.bold,
            color: DarkThemeColors.headlinesTextColor),
        displayMedium: (MyFonts.displayTextStyle).copyWith(
            fontSize: MyFonts.displayMediumTextSize,
            fontWeight: FontWeight.bold,
            color: DarkThemeColors.headlinesTextColor),
        displaySmall: (MyFonts.displayTextStyle).copyWith(
            fontSize: MyFonts.displaySmallTextSize,
            fontWeight: FontWeight.bold,
            color: DarkThemeColors.headlinesTextColor),
        //Headline
        headlineLarge: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headlineLargeTextSize,
            fontWeight: FontWeight.bold,
            color: DarkThemeColors.headlinesTextColor),
        headlineMedium: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headlineMediumTextSize,
            fontWeight: FontWeight.bold,
            color: DarkThemeColors.headlinesTextColor),
        headlineSmall: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headlineSmallTextSize,
            fontWeight: FontWeight.bold,
            color: DarkThemeColors.headlinesTextColor),
        //Title
        titleLarge: (MyFonts.titleTextStyle).copyWith(
            fontSize: MyFonts.titleLargeTextSize,
            fontWeight: FontWeight.bold,
            color: DarkThemeColors.headlinesTextColor),
        titleMedium: (MyFonts.titleTextStyle).copyWith(
            fontSize: MyFonts.titleMediumTextSize,
            fontWeight: FontWeight.bold,
            color: DarkThemeColors.headlinesTextColor),
        titleSmall: (MyFonts.titleTextStyle).copyWith(
            fontSize: MyFonts.titleSmallTextSize,
            fontWeight: FontWeight.bold,
            color: DarkThemeColors.headlinesTextColor),
        //Body
        bodyLarge: (MyFonts.bodyTextStyle).copyWith(
            fontSize: MyFonts.bodyLargeTextSize,
            fontWeight: FontWeight.bold,
            color: DarkThemeColors.headlinesTextColor),
        bodyMedium: (MyFonts.bodyTextStyle).copyWith(
            fontSize: MyFonts.bodyMediumTextSize,
            fontWeight: FontWeight.bold,
            color: DarkThemeColors.headlinesTextColor),
        bodySmall: (MyFonts.bodyTextStyle).copyWith(
            fontSize: MyFonts.bodySmallTextSize,
            fontWeight: FontWeight.bold,
            color: DarkThemeColors.headlinesTextColor),
        //Label
        labelLarge: MyFonts.labelTextStyle.copyWith(
          fontSize: MyFonts.labelLargeTextSize,
        ),
        labelMedium: (MyFonts.labelTextStyle).copyWith(
            fontSize: MyFonts.labelMediumTextSize,
            fontWeight: FontWeight.bold,
            color: DarkThemeColors.headlinesTextColor),
        labelSmall: (MyFonts.labelTextStyle).copyWith(
            fontSize: MyFonts.labelSmallTextSize,
            fontWeight: FontWeight.bold,
            color: DarkThemeColors.headlinesTextColor),
      );
}
