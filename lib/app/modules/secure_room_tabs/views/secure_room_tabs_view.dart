import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/theme/colors.dart';
import '../controllers/secure_room_tabs_controller.dart';
import 'tabs/room_access_control_tab.dart';
import 'tabs/room_parental_control_tab.dart';
import 'tabs/room_settings_tab.dart';

class SecureRoomTabsView extends GetView<SecureRoomTabsController> {
  const SecureRoomTabsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: RioAppBar(
        refreshText: controller.pageTitle,
        titleText: '',
        refresh: true,
      ),
      body: Center(
        child: DefaultTabController(
          length: 3,
          child: SizedBox(
            width: Get.width,
            child: Column(
              children: [
                Container(
                  height: Get.height * 0.04,
                  decoration: BoxDecoration(
                    color: AppColors.tabBackground,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                  child: TabBar(
                    controller: controller.secureRoomTabController,
                    labelColor: AppColors.white,
                    labelStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    isScrollable: true,
                    padding: const EdgeInsets.all(2),
                    indicatorWeight: 0,
                    splashBorderRadius: BorderRadius.circular(7),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 1,
                            color: Color.fromRGBO(0, 0, 0, 0.04)),
                        BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 8,
                            color: Color.fromRGBO(0, 0, 0, 0.12)),
                      ],
                      color: AppColors.primary,
                    ),
                    tabs: [
                      for (int i = 0; i < controller.tabsList.length; i++)
                        Tab(text: controller.tabsList[i]),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                      controller: controller.secureRoomTabController,
                      children: const [
                        RoomSettingsTabView(),
                        RoomParentalControlTabView(),
                        RoomAccessControlTabView(),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
