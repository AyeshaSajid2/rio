import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/components/widgets/app_pop_up_menu.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../../../data/models/room/get_room_list_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/secure_room_controller.dart';

class SecureRoomView extends GetView<SecureRoomController> {
  const SecureRoomView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: RioAppBar(
        refreshText: controller.pageTitle,
        titleText: '',
        refresh: true,
        actions: [
          Obx(() {
            return (controller.isAllRooms.value &&
                    !controller.isRoomsLimitReached.value)
                ? IconButton(
                    icon: SvgPicture.asset(Assets.svgs.add),
                    onPressed: () {
                      Get.toNamed(Routes.ADD_ROOM, arguments: {
                        'ssid': '1',
                        'isFromSecureRooms': true,
                        'isAllRooms': controller.isAllRooms.value,
                      });
                    },
                  )
                : Container();
          }),
        ],
      ),
      body: Obx(() {
        return Stack(
          children: [
            if (controller.getRoomListModel.listOfRoom != null &&
                controller.getRoomListModel.listOfRoom!.isNotEmpty)
              Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.getRoomListModel.listOfRoom!.length,
                      itemBuilder: (_, index) {
                        return SecureRoomTile(
                          room: controller.getRoomListModel.listOfRoom![index],
                          // roomStatus: controller.listOfRoomStatus[index],
                          controller: controller,
                        );
                      })),
            if (controller.getRoomListModel.listOfRoom != null &&
                controller.getRoomListModel.listOfRoom!.isEmpty)
              Center(
                child: Text(
                  'There are no rooms in this WiFi Network',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.red),
                ),
              ),
            if (controller.showLoader.value)
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
        );
      }),
    );
  }
}

class SecureRoomTile extends StatelessWidget {
  const SecureRoomTile({
    super.key,
    required this.room,
    // required this.roomStatus,
    required this.controller,
  });

  final RoomListItem room;
  // final RxBool roomStatus;
  final SecureRoomController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child:

            //  Obx(() {
            //   return
            ListTile(
          // leading: SvgPicture.asset(room.svgPath),

          leading: Container(
              height: 33,
              width: 33,
              decoration: BoxDecoration(
                color: AppColors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Align(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: SvgPicture.asset(
                    Assets.svgs.blueTick,
                  ),
                ),
              )),
          title: Text(
            room.name!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.appBlack,
            ),
          ),
          onTap: () {
            Get.toNamed(Routes.SECURE_ROOM_TABS, arguments: {
              'RoomListItem': room,
              'isFromSecureRooms': true,
              'isAllRooms': controller.isAllRooms.value,
            });
          },
          trailing: AppPopUpMenu(
            listOfPopupMenuItems: [
              AppPopupMenuItem.item(
                  menuText: 'Configure', svgPath: Assets.svgs.edit),
              // AppPopupMenuItem.item(
              //     menuText: roomStatus.value ? 'Disable' : 'Activate',
              //     svgPath: roomStatus.value
              //         ? Assets.svgs.disableWhite
              //         : Assets.svgs.activate),
              AppPopupMenuItem.item(
                  menuText: 'Connected Devices',
                  svgPath: Assets.svgs.connectedDevices),
              // if (room.id != '1')
              //   AppPopupMenuItem.item(
              //       menuText: 'Delete', svgPath: Assets.svgs.deleteWhite),
            ],
            onSelected: (menuItemString) {
              //
              if (menuItemString == 'Configure') {
                Get.toNamed(Routes.SECURE_ROOM_TABS, arguments: {
                  'RoomListItem': room,
                  'isFromSecureRooms': true,
                  'isAllRooms': controller.isAllRooms.value,
                });
              }
              // else if (menuItemString == 'Disable') {
              //   roomStatus.value = false;
              // } else if (menuItemString == 'Activate') {
              //   roomStatus.value = true;
              // }
              else if (menuItemString == 'Connected Devices') {
                Get.toNamed(Routes.DEVICES, arguments: {
                  'pageTitle': room.name,
                  'deviceType': controller.dashboardController.roomDeviceType,
                  'RoomId': room.id,
                });
                // Get.to(() => const ConnectedDevicesWithRoomView(),
                //     binding: SecureRoomTabsBinding(),
                //     arguments: {
                //       'Add Room': false,
                //       'RoomListItem': room,
                //       'Edit': false
                //     });
              } else {
                //Delete Room
                controller
                    .setRoom(controller.fillSetRoomDelete(room))
                    .then((value) => controller.callGetAllRooms());
              }
            },
          ),
          horizontalTitleGap: 4,
          tileColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        )
        // ;}),
        );
  }
}
