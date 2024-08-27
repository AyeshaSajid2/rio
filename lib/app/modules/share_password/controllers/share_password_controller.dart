import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:usama/core/utils/helpers/common_func.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/theme/colors.dart';

class SharePasswordController extends GetxController {
  String ssid = '';
  String password = '';
  // final box = GetStorage('AsKey');

  RxString pageTitle = 'Share Password'.obs;
  ScreenshotController screenshotController = ScreenshotController();

  RxBool hideIcon = false.obs;

  @override
  void onInit() {
    //
    Map<String, dynamic> args = Get.arguments;

    ssid = args['ssid'];
    password = args['password'];
    pageTitle.value = args['pageTitle'];

    super.onInit();
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }

  void copyToClipBoard() async {
    Clipboard.setData(ClipboardData(text: password));
    constants.showSnackbar(
        'Copied To Clipboard', 'Password is copied to clipboard', 1);
  }

  void shareScreenshot() async {
    hideIcon.value = true;

    await screenshotController
        // .capture()
        .captureFromWidget(
            Material(
              color: AppColors.greyBackground,
              type: MaterialType.card,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            border:
                                Border.all(width: 1, color: AppColors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: QrImageView(
                            data: 'WIFI:T:WPA2;S:$ssid;P:$password;H:;;',
                            version: QrVersions.auto,
                            size: 200.0,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(18),
                          margin: const EdgeInsets.all(24),
                          decoration:
                              const BoxDecoration(color: AppColors.white),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('WiFi'),
                                  Text(ssid),
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Password'),
                                  Text(password),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            delay: const Duration(milliseconds: 500))
        .then((image) async {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File(
              '${directory.path}/qr_code${DateTime.now().microsecondsSinceEpoch.toString()}.png')
          .create();
      await imagePath.writeAsBytes(image.toList());

      XFile file = XFile(imagePath.path);
      // Share.shareXFiles([file], subject: 'Sharing QR Code');
      if (Platform.isAndroid) {
        Share.shareXFiles(
          [file],
          text: '$ssid\n$password',
        );
      } else {
        Share.shareXFiles([file], subject: '$ssid\n$password');
      }
    });

    hideIcon.value = false;
  }
}
