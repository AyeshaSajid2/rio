//palette.dart
import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xff202132, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff1d1e2d), //10%
      100: Color(0xff1a1a28), //20%
      200: Color(0xff161723), //30%
      300: Color(0xff13141e), //40%
      400: Color(0xff101119), //50%
      500: Color(0xff0d0d14), //60%
      600: Color(0xff0a0a0f), //70%
      700: Color(0xff06070a), //80%
      800: Color(0xff030305), //90%
      900: Color(0xff000000), //100%
    },
  );
  static const MaterialColor kToLight = MaterialColor(
    0xff202132, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff363747), //10%
      100: Color(0xff4d4d5b), //20%
      200: Color(0xff636470), //30%
      300: Color(0xff797a84), //40%
      400: Color(0xff909099), //50%
      500: Color(0xffa6a6ad), //60%
      600: Color(0xffbcbcc2), //70%
      700: Color(0xffd2d3d6), //80%
      800: Color(0xffe9e9eb), //90%
      900: Color(0xffffffff), //100%
    },
  );
}
