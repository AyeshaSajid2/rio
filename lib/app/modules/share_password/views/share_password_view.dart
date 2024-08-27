import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/theme/colors.dart';
import '../controllers/share_password_controller.dart';

class SharePasswordView extends GetView<SharePasswordController> {
  const SharePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    final pageHeight =
        Get.height - Get.statusBarHeight + (Get.mediaQuery.padding.top / 2);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: RioAppBar(
        titleText: 'Share Password',
        refresh: true,
        refreshText: controller.pageTitle,
      ),
      body: SizedBox(
        height: pageHeight,
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.08,
              ),
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  'QR Code for automatically \nconnecting to Rio Wireless SSID',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),

              Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(width: 1, color: AppColors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: QrImageView(
                      data:
                          'WIFI:T:WPA2;S:${controller.ssid};P:${controller.password};H:;;',
                      version: QrVersions.auto,
                      size: 200.0,
                      // embeddedImage: AssetImage(Assets.images.appIconLight.path),
                      // embeddedImageStyle: const QrEmbeddedImageStyle(
                      //   size: Size(24, 24),
                      // ),
                      // eyeStyle: const QrEyeStyle(
                      //     eyeShape: QrEyeShape.circle, color: AppColors.black),
                      // dataModuleStyle: const QrDataModuleStyle(
                      //     dataModuleShape: QrDataModuleShape.circle,
                      //     color: AppColors.primary),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(18),
                    margin: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(color: AppColors.white),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('WiFi'),
                            Text(controller.ssid),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Password'),
                            Row(
                              children: [
                                Text(controller.password),
                                InkWell(
                                  onTap: () {
                                    controller.copyToClipBoard();
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Icon(Icons.copy),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // OutlinedAppButton(
                    //   onPressed: () {
                    //     //
                    //   },
                    //   buttonText: 'Share to iOS/Android phones',
                    //   buttonColor: AppColors.appBlack,
                    // ),
                    FilledRoundButton(
                      onPressed: () {
                        //
                        controller.shareScreenshot();
                      },
                      buttonText: 'Share Password',
                      // buttonColor: AppColors.appBlack,
                    ),
                    SizedBox(height: Get.height * 0.08),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
