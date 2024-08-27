import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/components/widgets/filled_round_button.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../gen/assets.gen.dart';
import '../../controllers/secure_room_tabs_controller.dart';

class RoomAccessControlTabView extends GetView<SecureRoomTabsController> {
  const RoomAccessControlTabView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Obx(() {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                      child: const Text(
                        'Add access to other secured rooms.\nDevices of this room will be able to access to devices of the selected rooms below.',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: AppColors.appBlack),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    (controller.getRoomListModelForAllRooms.listOfRoom !=
                                null &&
                            controller.getRoomListModelForAllRooms.listOfRoom!
                                .isNotEmpty &&
                            controller.listOfRoomStatus.isNotEmpty)
                        ? ListView.builder(
                            itemCount: controller
                                .getRoomListModelForAllRooms.listOfRoom!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Obx(() {
                                return CheckboxListTile.adaptive(
                                  value:
                                      controller.listOfRoomStatus[index].value,
                                  title: Text(
                                    controller.getRoomListModelForAllRooms
                                        .listOfRoom![index].name!,
                                    style: const TextStyle(
                                      color: AppColors.appBlack,
                                      fontSize: 14,
                                      // fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  // groupValue: controller.selectedWifiSSID.value,
                                  onChanged: (boolValue) {
                                    if (boolValue!) {
                                      controller.accessList =
                                          '${controller.accessList}${controller.getRoomListModelForAllRooms.listOfRoom![index].id!} ';
                                      controller.listOfRoomStatus[index].value =
                                          boolValue;
                                    } else {
                                      controller.accessList =
                                          controller.accessList.replaceAll(
                                              '${controller.getRoomListModelForAllRooms.listOfRoom![index].id!} ',
                                              '');
                                      controller.listOfRoomStatus[index].value =
                                          boolValue;
                                    }
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  visualDensity: const VisualDensity(
                                      vertical: -4, horizontal: -4),
                                  activeColor: AppColors.appBlack,
                                );
                              });
                            })
                        : Text(
                            'There are no other rooms available',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.red),
                          ),
                    SizedBox(height: Get.height * 0.08),
                    FilledRoundButton(
                      onPressed:
                          controller.getRoomListModelForRoomAccess.listOfRoom ==
                                  null
                              ? null
                              : () {
                                  controller.setRoomsToAccessRoom(
                                      controller.fillSetRoomsToRoomAccess());
                                },
                      buttonText: 'Save',
                      padding: const EdgeInsets.symmetric(vertical: 4),
                    ),
                    SizedBox(height: Get.height * 0.08),
                  ],
                ),
              ),
              if (controller.showLoader.value)
                Positioned(
                  child: SizedBox(
                    height: Get.height - Get.statusBarHeight,
                    width: Get.width,
                    child: ColoredBox(
                      color: Colors.black38,
                      child: Lottie.asset(Assets.animations.loading),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
