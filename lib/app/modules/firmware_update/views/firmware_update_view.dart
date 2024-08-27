import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:usama/core/components/widgets/filled_rect_button.dart';

import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/firmware_update_controller.dart';

class FirmwareUpdateView extends GetView<FirmwareUpdateController> {
  const FirmwareUpdateView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const RioAppBar(
        titleText: 'Firmware Upgrade',
      ),
      body: Obx(() {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  if (controller.isUpdateAvailable.value) ...[
                    Center(
                      child: Card(
                        color: AppColors.white,
                        margin:
                            const EdgeInsets.only(top: 32, left: 16, right: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Text(
                                'Firmware update is available',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primary),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Current Version: ${controller.settingsController.getSystemSettingModel.firmwareVersion}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'New Version: ${controller.getFirmwareVersionModel.firmwareVersion}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              FilledRectButton(
                                  onPressed: () {
                                    // controller.upgradeFirmware();
                                  },
                                  buttonText: 'Upgrade Firmware'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    Center(
                      child: Card(
                        color: AppColors.white,
                        margin:
                            const EdgeInsets.only(top: 32, left: 16, right: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Text(
                                'Your Firmware is up to date',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primary),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Current Version: ${controller.settingsController.getSystemSettingModel.firmwareVersion}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  // AppCardTile(
                  //   title: 'Reset to Factory Defaults',
                  //   onTap: () {
                  //     Dialogs.showDialogWithTwoButtonsMsg(
                  //         context: context,
                  //         title: 'Reset Router',
                  //         subtitle:
                  //             'Do you want to reset the router to factory default settings?',
                  //         button1Func: () {
                  //           Get.back();
                  //         },
                  //         button2Func: () {
                  //           controller.factoryReset();
                  //         });
                  //   },
                  // ),

                  SizedBox(height: Get.height * 0.04),
                ],
              ),
            ),
            if (controller.showLoader.value)
              Positioned(
                child: SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: ColoredBox(
                    color: Colors.black12,
                    child: Lottie.asset(Assets.animations.loading),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
