import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:usama/app/modules/dashboard/controllers/dashboard_controller.dart';

import '../../../../../../core/components/widgets/app_pop_up_menu.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../data/models/room/get_room_list_model.dart';
import '../../../../../routes/app_pages.dart';

class DashboardRoomTiles extends StatelessWidget {
  const DashboardRoomTiles({
    super.key,
    required this.svgPath,
    required this.titleText,
    // required this.onTap,
    required this.room,
    required this.ssid,
  });
  final String svgPath;
  final String titleText;
  // final void Function() onTap;
  final RoomListItem room;
  final String ssid;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: ListTile(
        tileColor: AppColors.white,
        // style: ListTileStyle.drawer,
        // contentPadding: const EdgeInsets.only(left: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        leading: Container(
          width: 33,
          height: 33,
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
              color: AppColors.blue.withOpacity(0.25), shape: BoxShape.circle),
          child: SvgPicture.asset(
            svgPath,
            colorFilter:
                const ColorFilter.mode(AppColors.blue, BlendMode.srcIn),
          ),
        ),
        horizontalTitleGap: 8,
        title: Text(
          titleText,
          style: const TextStyle(
              fontSize: 18,
              color: AppColors.appBlack,
              fontWeight: FontWeight.w300),
        ),

        onTap: () {
          final dashboardController = Get.find<DashboardController>();

          Get.toNamed(Routes.DEVICES, arguments: {
            'pageTitle': room.name,
            'deviceType': dashboardController.roomDeviceType,
            'RoomId': room.id,
          });
        },
        trailing: AppPopUpMenu(
          listOfPopupMenuItems: [
            AppPopupMenuItem.item(
                menuText: 'Configure', svgPath: Assets.svgs.edit),
            AppPopupMenuItem.item(
                menuText: 'Connected Devices',
                svgPath: Assets.svgs.connectedDevices),
          ],
          onSelected: (menuItemString) {
            //
            if (menuItemString == 'Configure') {
              Get.toNamed(Routes.SECURE_ROOM_TABS, arguments: {
                'Add Room': false,
                'RoomListItem': room,
                'isFromSecureRooms': false,
                // 'SSID': ssid,
              });
            } else if (menuItemString == 'Connected Devices') {
              final dashboardController = Get.find<DashboardController>();
              // dashboardController.getDevicesOfRoom(room.id!);
              // dashboardController.pageTitle.value = room.name!;
              // dashboardController.connectedDeviceRoom = room;

              Get.toNamed(Routes.DEVICES, arguments: {
                'pageTitle': room.name,
                'deviceType': dashboardController.roomDeviceType,
                'RoomId': room.id,
              });
              // Get.to(() => const ConnectedDevicesWithRoomView());
            } else {}
          },
        ),

        // trailing: const Icon(
        //   Icons.more_vert,
        //   size: 24,
        //   color: AppColors.black,
        // ),

        // onTap: onTap,
      ),
    );
  }
}
