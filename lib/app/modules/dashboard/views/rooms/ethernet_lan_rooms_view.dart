import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:usama/core/components/widgets/new_rio_app_bar.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../gen/assets.gen.dart';
import '../../controllers/dashboard_controller.dart';
import 'widget/dashboard_room_tile.dart';

class EthernetRoomsView extends GetView<DashboardController> {
  const EthernetRoomsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: const NewRioAppBar(
        titleText: 'Ethernet LAN Devices',
        backOn: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            height: Get.height * 0.25,
            width: Get.width,
            child: SvgPicture.asset(
              Assets.svgs.dashboardBg,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: Get.height * 0.19,
            height: Get.height - Get.height * 0.19 - Get.bottomBarHeight,
            width: Get.width,
            child: SingleChildScrollView(
              controller: controller.dashboardScrollController,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  bottom: 24.0,
                ),
                child: Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'SecureRooms™',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                      if (controller.ethernetLanRoomList.isNotEmpty &&
                          !controller.roomListShowLoader.value)
                        ListView.builder(
                            controller: controller.dashboardScrollController,
                            itemCount: controller.ethernetLanRoomList.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemBuilder: (context, index) {
                              return DashboardRoomTiles(
                                svgPath: Assets.svgs.admin,
                                titleText:
                                    controller.ethernetLanRoomList[index].name!,
                                ssid: '',
                                room: controller.ethernetLanRoomList[index],
                              );
                            }),
                      if (controller.roomListShowLoader.value)
                        Center(
                          child: Lottie.asset(Assets.animations.loading),
                        ),
                      const SizedBox(height: 16),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
