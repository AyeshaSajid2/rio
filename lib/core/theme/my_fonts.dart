import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// todo configure text family and size
class MyFonts {
  // return the right font depending on app language
  static TextStyle get getAppFontType => const TextStyle(fontFamily: 'Poppins');

  // display text font
  static TextStyle get displayTextStyle => getAppFontType;

  // headlines text font
  static TextStyle get headlineTextStyle => getAppFontType;

  // title text font
  static TextStyle get titleTextStyle => getAppFontType;

  // body text font
  static TextStyle get bodyTextStyle => getAppFontType;

  // label text font
  static TextStyle get labelTextStyle => getAppFontType;

  // button text font
  static TextStyle get buttonTextStyle => getAppFontType;

  // app bar text font
  static TextStyle get appBarTextStyle => getAppFontType;

  // chips text font
  static TextStyle get chipTextStyle => getAppFontType;

  // appBar font size
  static double get appBarTittleSize => 18.sp;

  // display font size
  static double get displayLargeTextSize => 13.sp;
  static double get displayMediumTextSize => 13.sp;
  static double get displaySmallTextSize => 13.sp;

  // headlines font size
  static double get headlineLargeTextSize => 13.sp;
  static double get headlineMediumTextSize => 13.sp;
  static double get headlineSmallTextSize => 13.sp;
  // static double get headline1TextSize => 50.sp;
  // static double get headline2TextSize => 40.sp;
  // static double get headline3TextSize => 30.sp;
  // static double get headline4TextSize => 25.sp;
  // static double get headline5TextSize => 20.sp;
  // static double get headline6TextSize => 17.sp;

  // title font size
  static double get titleLargeTextSize => 22.sp;
  static double get titleMediumTextSize => 20.sp;
  static double get titleSmallTextSize => 18.sp;

  // body font size
  static double get bodyLargeTextSize => 12.sp;
  static double get bodyMediumTextSize => 10.sp;
  static double get bodySmallTextSize => 8.sp;

  // label font size
  static double get labelLargeTextSize => 17.sp;
  static double get labelMediumTextSize => 15.sp;
  static double get labelSmallTextSize => 13.sp;

  //button font size
  static double get buttonTextSize => 16.sp;

  //caption font size
  static double get captionTextSize => 13.sp;

  //chip font size
  static double get chipTextSize => 10.sp;
}
