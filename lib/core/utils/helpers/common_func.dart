import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/colors.dart';

Constants constants = Constants();

// const title = "Constants";

class Constants {
  static final Constants _constants = Constants._i();

  factory Constants() {
    return _constants;
  }

  Constants._i();

  // final BASE_IMAGE_URL = "https://image.tmdb.org/t/p/";
  // final IMAGE_SIZE_ORIGINAL = "original";
  // final BACKDROP_SIZE_W300 = "w300";
  // final BACKDROP_SIZE_w780 = "w780";
  // final BACKDROP_SIZE_w1280 = "w1280";
  // final POSTER_SIZE_W92 = "w92";
  // final POSTER_SIZE_W154 = "w154";
  // final POSTER_SIZE_W185 = "w185";
  // final POSTER_SIZE_W342 = "w342";
  // final POSTER_SIZE_W500 = "w500";
  // final POSTER_SIZE_W780 = "w780";

  // String getImageUrl() => BASE_IMAGE_URL + POSTER_SIZE_W185;

  // String getBackdropImageUrl() => BASE_IMAGE_URL + BACKDROP_SIZE_w780;

  bool isKeyboardOpened() {
    return MediaQuery.of(Get.context!).viewInsets.bottom != 0;
  }

  RxBool isKeyboardOpenedRX() {
    return (MediaQuery.of(Get.context!).viewInsets.bottom != 0).obs;
  }

  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void dismissKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void showSnackbar(String title, String msg, int colorIndex) {
    Get.closeAllSnackbars();
    Get.snackbar(title, msg,
        titleText: Text(
          title,
          style: const TextStyle(
              color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        messageText: Text(
          msg,
          style: const TextStyle(color: AppColors.white),
        ),
        backgroundColor: colorIndex == 0
            ? AppColors.red
            : colorIndex == 1
                ? AppColors.primary
                : AppColors.blue,
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING);
  }

  // void showSnackbarWithLogo(String title, int colorIndex) {
  //   Get.closeAllSnackbars();
  //   Get.snackbar(title, '',
  //       titleText: Text(
  //         title,
  //         style: const TextStyle(
  //             color: AppColors.white, fontWeight: FontWeight.bold),
  //       ),
  //       messageText: Container(),
  //       icon: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Image.asset(appLogoImage),
  //       ),
  //       backgroundColor: colorIndex == 0
  //           ? AppColors.danger
  //           : colorIndex == 1
  //               ? AppColors.success
  //               : AppColors.primary,
  //       snackPosition: SnackPosition.BOTTOM,
  //       snackStyle: SnackStyle.FLOATING);
  // }

  void dismissSnackbar() {
    ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
  }
}

extension ExtensionOnString on String {
  String nameInitials(String name) {
    List splitName = name.trim().split(' ');
    String nameInit = '';
    if (splitName.length > 1) {
      for (var n in splitName) {
        n.trim();
        if (n.isNotEmpty && n != ' ' && nameInit.characters.length <= 1) {
          nameInit += '${n[0].toUpperCase()}';
        }
      }
      if (!nameInit.isAlphabetOnly) {
        nameInit =
            '${nameInit.characters.first} ${nameInit.characters.elementAt(1)}';
      }
      return nameInit;
    } else if (splitName.first.toString().length > 1) {
      nameInit = splitName.first.substring(0, 2).toString().toUpperCase();
      if (!nameInit.isAlphabetOnly) {
        nameInit =
            '${nameInit.characters.first} ${nameInit.characters.elementAt(1)}';
      }
      return nameInit;
    } else {
      nameInit = splitName.first.substring(0, 1).toString().toUpperCase();

      return nameInit;
    }
  }

  String get decimalSeparator =>
      NumberFormat.decimalPattern('en_us').format(double.parse(this));

  String mobileNumberWithoutCountryCode() {
    return trim()
        .removeAllWhitespace
        .replaceAll(RegExp(r'[()+\-*.\s]'), '')
        .replaceFirst(
          RegExp('^(0092|92|0)', multiLine: true),
          '',
        )
        // .characters
        // .takeLast(country.minLength)
        .toString();
  }

  bool get isEnglishOnly {
    return RegExp(r"^[a-zA-Z0-9. -_?]*\$").hasMatch(this);
  }

  String get encodeToBase64 => base64Encode(utf8.encode(this));
  String get decodeBase64 => utf8.decode(base64.decode(this));

  String get hourMinuteTimeFromHMS =>
      DateFormat('HH:mm').format(DateTime.parse('2023-03-31 $this'));
  String get hourTimeFromHMS =>
      DateFormat('HH').format(DateTime.parse('2023-03-31 $this'));
  String get minuteTimeFromHMS =>
      DateFormat('mm').format(DateTime.parse('2023-03-31 $this'));
}

extension ExtensionOnDouble on double {
  // double get decimalSeparatorReturnDouble =>
  //     double.parse(NumberFormat.decimalPattern('en_us').format(this));
  String get decimalSeparatorReturnString =>
      NumberFormat.decimalPattern('en_us').format(this);

  // double toPrecision(int fractionDigits) {
  //   double mod = pow(10, fractionDigits.toDouble()).roundToDouble();
  //   return ((this * mod).round().toDouble() / mod);
  // }
}

extension ExtensionOnDate on DateTime {
  // double get decimalSeparatorReturnDouble =>
  //     double.parse(NumberFormat.decimalPattern('en_us').format(this));
  String get dateTimeWithMonthName =>
      DateFormat('d MMM yyyy h:mm a').format(this);
  String get dateWithDayMonthName =>
      DateFormat('EEEE dd-MMMM-yyyy').format(this);
  String get dateWithShortDayMonthName =>
      DateFormat('E, dd MMMM yyyy').format(this);
  String get dayWithMonth => DateFormat.MMMd().format(this);
  String get dateWithSlashes => DateFormat.yMd().format(this);
  String get dateWithDashes => DateFormat('yyyy-MM-dd').format(this);
  String get hourAndMinutesWithDashes => DateFormat('HH:mm').format(this);
}

Future<void> openBrowserUrl({required String url}) async {
  final Uri urlLink = Uri.parse(url);

  if (!await launchUrl(urlLink)) {
    throw 'Could not launch $urlLink';
  }
}

void launchURL({
  required String scheme,
  required String path,
}) async {
  if (await canLaunchUrl(Uri(scheme: scheme, path: path))) {
    await launchUrl(Uri(scheme: scheme, path: path));
  } else {
    constants.showSnackbar(
        'Error', 'Something went wrong. Please try again later.', 0);
    // throw 'Could not launch ${url()}';
  }
}
