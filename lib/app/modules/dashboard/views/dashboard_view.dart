import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:usama/app/modules/dashboard/views/rooms/ethernet_lan_rooms_view.dart';
import 'package:usama/app/modules/dashboard/views/rooms/guest_rooms_view.dart';
import 'package:usama/app/modules/dashboard/views/rooms/shared_rooms_view.dart';
import 'package:usama/core/components/widgets/new_rio_app_bar.dart';
import 'package:usama/core/components/widgets/refresh_sign.dart';
import 'package:usama/core/extensions/imports.dart';
import 'package:usama/core/utils/helpers/askey_storage.dart';

import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';

import '../../../routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';
import 'shared_password_view.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: NewRioAppBar(
        titleText: 'Rio Dashboard',
        backOn: false,
        actions: [
          SizedBox(
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 16.0, left: 16),
              child: Obx(() {
                return Row(
                  mainAxisAlignment: (controller.isWifiConnected.value &&
                          controller.wifiName!.value != 'null')
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.end,
                  children: [
                    if (controller.isWifiConnected.value &&
                        controller.wifiName!.value != 'null' &&
                        controller.wifiName!.value != '<unknownssid>') ...[
                      Text(
                        'WiFi Name: ${controller.wifiName!.value}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    Text(
                      'Status: ${controller.routerStatus.value.capitalizeFirst}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                );
              }),
            ),
          )
        ],
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
            height: Get.height - Get.height * 0.25,
            width: Get.width,
            child: RefreshIndicator(
              onRefresh: () {
                return controller.getDeviceList(
                    controller.fillGetAllDevices(), null);
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    right: 24.0,
                    bottom: 24.0,
                  ),
                  child: Column(
                    children: [
                      RefreshSign(
                          showRefreshTitle: controller.showRefreshTitle),
                      Row(
                        children: [
                          DashboardBottomCard(
                            cardTitle: 'Share Password',
                            value: '',
                            iconName: Icons.lock,
                            onTap: () {
                              Get.to(() => const SharePasswordView());
                              controller.updateWifiAndRoomsFunc();
                            },
                          ),
                          const SizedBox(width: 16),
                          DashboardBottomCard(
                              cardTitle: 'Room Management',
                              value: '',
                              iconName: Icons.wifi,
                              onTap: () {
                                // controller.homeController.currentIndex.value = 4;
                                Get.toNamed(Routes.SECURE_ROOM,
                                    arguments: {'isAllRooms': true});
                              }),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Obx(() {
                            return DashboardBottomCard(
                              iconName: Icons.vpn_lock_outlined,
                              cardTitle: 'Pending Admittance',
                              value: controller.pendingDevicesCount.value,
                              onTap: () {
                                Get.toNamed(Routes.DEVICES, arguments: {
                                  'pageTitle': 'Pending Devices',
                                  'deviceType': controller.waitDeviceType,
                                });
                              },
                            );
                          }),
                          const SizedBox(width: 16),
                          DashboardBottomCard(
                            cardTitle: 'VPN',
                            value: '',
                            iconName: Icons.vpn_lock_outlined,
                            onTap: () {
                              controller.homeController.currentIndex.value = 3;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      DashboardTiles(
                        svgPath: Assets.svgs.admin,
                        titleText: 'Admin Devices',
                        onTap: () {
                          // Get.to(() => const AdminRoomsView());
                          controller.homeController.currentIndex.value = 1;
                        },
                        isFirst: true,
                      ),
                      DashboardTiles(
                        svgPath: Assets.svgs.managed,
                        titleText: 'Managed Devices',
                        onTap: () {
                          // Get.toNamed(Routes.MESH);
                          controller.homeController.currentIndex.value = 2;
                        },
                      ),
                      DashboardTiles(
                        svgPath: Assets.svgs.shared,
                        titleText: 'Shared Devices',
                        onTap: () {
                          Get.to(() => const SharedRoomsView());
                          // Get.toNamed(Routes.SECURE_ROOM,
                          //     arguments: {'isAllRooms': true});
                        },
                      ),
                      DashboardTiles(
                        svgPath: Assets.svgs.guestWhite,
                        titleText: 'Guest Devices',
                        onTap: () {
                          Get.to(() => const GuestRoomsView());
                          // Get.toNamed(Routes.SETTINGS);
                        },
                      ),
                      DashboardTiles(
                        svgPath: Assets.svgs.ethernetLan,
                        titleText: 'Ethernet Lan Devices',
                        onTap: () {
                          Get.to(() => const EthernetRoomsView());
                          // Get.toNamed(Routes.SHARE_PASSWORD, arguments: {
                          //   'from': 'Dashboard',
                          // });
                        },
                        isLast: true,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Obx(() {
                            return DashboardCard(
                                strValue:
                                    controller.connectedDevicesCount.value,
                                title: 'Connected Devices',
                                onTap: () {
                                  Get.toNamed(Routes.DEVICES, arguments: {
                                    'pageTitle': 'Connected Devices',
                                    'deviceType': controller.allDeviceType,
                                  });
                                  // Get.to(() => const ConnectedDevicesView());
                                },
                                svgPath: Assets.svgs.connected,
                                svgColor: AppColors.newAppBarColor);
                          }),
                          const SizedBox(width: 16),
                          Obx(() {
                            return DashboardCard(
                                strValue: controller.blockedDevicesCount.value,
                                title: 'Blocked Devices',
                                onTap: () {
                                  Get.toNamed(Routes.DEVICES, arguments: {
                                    'pageTitle': 'Blocked Devices',
                                    'deviceType': controller.blockDeviceType,
                                  });
                                  // Get.to(() => const BlockedDevicesView());
                                },
                                svgPath: Assets.svgs.blocked,
                                svgColor: AppColors.red);
                          }),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'App Version : ${AppConstants.appVersion}',
                        style: TextStyle(
                            color: AppColors.appGrey,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Router S.No: ${asKeyStorage.getAsKeyRouterSerialNumber()}',
                        style: const TextStyle(
                            color: AppColors.appGrey,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardBottomCard extends StatelessWidget {
  const DashboardBottomCard({
    super.key,
    required this.iconName,
    required this.cardTitle,
    required this.onTap,
    required this.value,
  });
  final IconData iconName;
  final String cardTitle;
  final String value;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: (Get.width - 64) / 2,
        height: Get.height * 0.1,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                color: AppColors.black.withOpacity(0.05),
              ),
            ]),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            value.isEmpty
                ? Icon(
                    iconName,
                    color: AppColors.blue,
                  )
                : Text(
                    value,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blue,
                      height: 0,
                    ),
                    textAlign: TextAlign.center,
                  ),
            if (value.isEmpty) const SizedBox(height: 8),
            Text(
              cardTitle,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 14, height: 0),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.strValue,
    required this.title,
    required this.svgPath,
    required this.svgColor,
    required this.onTap,
  });

  final String title;
  final String strValue;
  final String svgPath;
  final Color svgColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: (Get.width - 64) / 2,
        height: Get.height * 0.1,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                color: AppColors.black.withOpacity(0.05),
              ),
            ]),
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  strValue.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(12),
                          child: SizedBox(
                            height: 24,
                            width: 24,
                            child: ColoredBox(
                              color: Colors.white12,
                              child: Lottie.asset(Assets.animations.loading),
                            ),
                          ),
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              strValue,
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 48.h,
                    width: 60,
                    child: Stack(
                      children: [
                        Positioned(
                          top: -12,
                          right: -10,
                          child: Container(
                            height: 60.h,
                            width: 60,
                            decoration: BoxDecoration(
                              color: svgColor.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 8,
                                  right:
                                      svgPath != Assets.svgs.blocked ? 16 : 8,
                                  top: 16.h,
                                  bottom: 8.h),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              // clipBehavior: Clip.hardEdge,
                              child: SvgPicture.asset(
                                svgPath,
                                width: 30,
                                fit: BoxFit.none,
                                colorFilter:
                                    ColorFilter.mode(svgColor, BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black.withOpacity(0.7)),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardTiles extends StatelessWidget {
  const DashboardTiles({
    super.key,
    required this.svgPath,
    required this.titleText,
    this.onTap,
    this.trailingText = '',
    this.isFirst = false,
    this.isLast = false,
  });
  final String svgPath;
  final String titleText;
  final String trailingText;
  final void Function()? onTap;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: isFirst ? const Radius.circular(16) : Radius.zero,
          topRight: isFirst ? const Radius.circular(16) : Radius.zero,
          bottomLeft: isLast ? const Radius.circular(16) : Radius.zero,
          bottomRight: isLast ? const Radius.circular(16) : Radius.zero,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            tileColor: AppColors.white,
            // style: ListTileStyle.drawer,
            // contentPadding: const EdgeInsets.only(left: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: isFirst ? const Radius.circular(16) : Radius.zero,
                topRight: isFirst ? const Radius.circular(16) : Radius.zero,
                bottomLeft: isLast ? const Radius.circular(16) : Radius.zero,
                bottomRight: isLast ? const Radius.circular(16) : Radius.zero,
              ),
            ),
            leading: Container(
              width: 30,
              height: 30,
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.circular(6)),
              child: SvgPicture.asset(
                svgPath,
                colorFilter:
                    const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
              ),
            ),
            horizontalTitleGap: 0,
            title: Text(
              titleText,
              style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.appBlack,
                  fontWeight: FontWeight.w300),
            ),
            titleTextStyle: const TextStyle(
                fontSize: 18,
                color: AppColors.appBlack,
                fontWeight: FontWeight.w300),

            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),

            onTap: onTap,
          ),
          isLast
              ? Container()
              : const Divider(
                  indent: 57,
                  height: 0,
                  thickness: 0.5,
                ),
        ],
      ),
    );
  }
}
