import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'widgets/device_list_widget.dart';
import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/devices_controller.dart';

class DevicesView extends GetView<DevicesController> {
  const DevicesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: RioAppBar(
        titleText: controller.pageTitle,
      ),
      body: Obx(() {
        return SizedBox(
          height: controller.dashboardController.showLoader.value
              ? Get.height - Get.statusBarHeight - Get.bottomBarHeight
              : controller.deviceList.isNotEmpty
                  ? controller.isDeviceAdministrator.value
                      ? ((90 * controller.deviceList.length) + 185)
                      : ((90 * controller.deviceList.length) + 28)
                  : Get.height * 0.5,
          width: Get.width,
          child: RefreshIndicator(
            onRefresh: () {
              return controller.dashboardController.getAllDevices();
            },
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  if (controller.deviceList.isNotEmpty &&
                      !controller.dashboardController.showLoader.value)
                    Column(
                      children: [
                        if (controller.isDeviceAdministrator.value)
                          Container(
                            width: Get.width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 12),
                            margin: const EdgeInsets.symmetric(vertical: 24),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Administrator Assignment',
                                  style: TextStyle(
                                    color: Colors.black
                                        .withOpacity(0.699999988079071),
                                    fontSize: 13,
                                    fontFamily: 'Circular Std',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'The first device setting up the Rio Router is automatically designated as the ADMINISTRATOR. The ADMIN can permit and move other devices connected to the Admin SSID to the Admin room. Those devices will have Manager role. A Manager can perform all ADMIN functions except a few functions.',
                                  style: TextStyle(
                                    color: Colors.black
                                        .withOpacity(0.699999988079071),
                                    fontSize: 13,
                                    fontFamily: 'Circular Std',
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        DeviceListWidget(
                          deviceList: controller.deviceList,
                          deviceType: controller.deviceType,
                          isDeviceAdministrator:
                              controller.isDeviceAdministrator.value,
                        ),
                      ],
                    ),
                  if (controller.deviceList.isEmpty &&
                      !controller.dashboardController.showLoader.value)
                    SizedBox(
                      width: Get.width,
                      height: Get.height * 0.51,
                      child: Align(
                        child: Container(
                          margin: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'There is no device here\nPlease Pull it down to refresh',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (controller.dashboardController.showLoader.value)
                    Positioned(
                      child: SizedBox(
                        height: Get.height,
                        width: Get.width,
                        child: ColoredBox(
                          color: Colors.white12,
                          child: Lottie.asset(Assets.animations.loading),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
