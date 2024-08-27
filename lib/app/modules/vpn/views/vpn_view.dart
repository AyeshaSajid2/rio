import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:usama/app/modules/add_room/controllers/add_room_controller.dart';
import 'package:usama/app/modules/secure_room_tabs/controllers/secure_room_tabs_controller.dart';

import '../../../../core/components/widgets/refresh_sign.dart';
import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/components/widgets/outlined_app_button.dart';
import '../../../../core/extensions/imports.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/app_pages.dart';
import '../controllers/vpn_controller.dart';

class VpnView extends GetView<VpnController> {
  const VpnView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      appBar: const RioAppBar(
        titleText: 'Virtual Private Network',
        backOn: false,
        // actions: [
        //   IconButton(
        //     icon: SvgPicture.asset(Assets.svgs.system),
        //     onPressed: () {
        //       Get.toNamed(Routes.SET_API_ACCOUNT, arguments: {
        //         'isFromVPN': true,
        //         'isFromAddRoom': false,
        //         'isFromVPNPlusAddRoom': Get.previousRoute == Routes.ADD_ROOM,
        //         'isFromVPNPlusSecureRoom':
        //             Get.previousRoute == Routes.SECURE_ROOM_TABS,
        //       });
        //     },
        //   ),
        // ],
      ),
      body: Obx(() {
        return SizedBox(
          height: (controller.getVpnModel.vpnList != null &&
                  !controller.showEnableVPN.value &&
                  !controller.showLoader.value)
              ? 850
              : 600,
          width: Get.width,
          child: RefreshIndicator(
            onRefresh: () {
              // return controller.getVpnList();
              return controller.callCheckVPNStatusAndCallVPNList();
            },
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: Stack(
                children: [
                  if (controller.getVpnModel.vpnList != null &&
                      !controller.showEnableVPN.value &&
                      !controller.showLoader.value)
                    Column(
                      children: [
                        const SizedBox(height: 24),
                        // RefreshSign(
                        //     showRefreshTitle: controller.showRefreshTitle),
                        SizedBox(
                            height: 180,
                            width: Get.width,
                            child: Image.asset(
                              Assets.images.vpnBanner.path,
                              width: Get.width,
                              fit: BoxFit.fitWidth,
                            )),
                        const SizedBox(height: 16),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Your Rio Router allows you the ability to enhance your network security by using two distinct VPN connections to various server locations for each SecureRoom.\n',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 13),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Your Rio purchase comes with a 12 month FREE subscription of Rio VPN. Follow the steps below to enable your VPN connections. You can enable your SecureRooms™️ to also use these connections.',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 13),
                          ),
                        ),

                        ListView.builder(
                            controller: controller.scrollController,
                            itemCount: controller.getVpnModel.vpnList!.length,
                            shrinkWrap: true,
                            // reverse: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              // return Obx(() {
                              return Container(
                                decoration:
                                    const BoxDecoration(color: AppColors.white),
                                padding: const EdgeInsets.only(
                                    left: 24, top: 24, right: 24, bottom: 8),
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const TitleText(
                                          title: 'Status',
                                        ),
                                        SizedBox(
                                          width: ((Get.width - 64) / 2),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                controller
                                                    .getVpnModel
                                                    .vpnList![index]
                                                    .status!
                                                    .capitalizeFirst!,
                                              ),
                                              const SizedBox(width: 8),
                                              SvgPicture.asset(controller
                                                          .getVpnModel
                                                          .vpnList![index]
                                                          .status! ==
                                                      'enable'
                                                  ? Assets.svgs.checkCircle
                                                  : Assets.svgs.disableRed),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const Divider(thickness: 1, height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const TitleText(
                                            title: 'Server',
                                          ),
                                          SizedBox(
                                            width: ((Get.width - 64) / 2),
                                            child: Obx(() {
                                              return InkWell(
                                                onTap: () async {
                                                  // print(controller
                                                  //         .listOfSelectedServersIndex[
                                                  //     index]);
                                                  controller
                                                      .filterSearchResults('');
                                                  bool? serverChanged =
                                                      await Dialogs
                                                          .showVPNServersBottomSheet(
                                                    controller: controller,
                                                    serverList: controller
                                                        .listOfFilteredServers,
                                                    selectedServer: controller
                                                            .listOfSelectedServers[
                                                        index],
                                                    selectedServerIndex: controller
                                                            .listOfSelectedServersIndex[
                                                        index],
                                                  );

                                                  if (serverChanged != null &&
                                                      serverChanged) {
                                                    controller.setVpn(controller
                                                        .fillEditVPN(index));
                                                  } else {}
                                                },
                                                child: Container(
                                                  width: ((Get.width - 64) / 2),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        controller
                                                                .listOfSelectedServers[
                                                                    index]
                                                                .value
                                                                .name!
                                                                .isEmpty
                                                            ? 'Select Server'
                                                            : controller
                                                                .listOfSelectedServers[
                                                                    index]
                                                                .value
                                                                .name!,
                                                      ),
                                                      const Icon(
                                                          Icons.arrow_drop_down)
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(thickness: 1, height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const TitleText(
                                            title: 'Protocol',
                                          ),
                                          Text(
                                            controller
                                                .getVpnModel
                                                .vpnList![index]
                                                .protocol!
                                                .capitalizeFirst!,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(thickness: 1, height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const TitleText(
                                            title: 'Connection',
                                          ),
                                          Text(
                                            controller
                                                .getVpnModel
                                                .vpnList![index]
                                                .connection!
                                                .capitalizeFirst!,
                                          ),
                                        ],
                                      ),
                                    ),
                                    OutlinedAppButton(
                                      onPressed: (controller
                                              .listOfSelectedServers[index]
                                              .value
                                              .name!
                                              .isEmpty)
                                          ? null
                                          : () async {
                                              if (controller
                                                  .listOfSelectedServers[index]
                                                  .value
                                                  .name!
                                                  .isNotEmpty) {
                                                if (controller
                                                        .getVpnModel
                                                        .vpnList![index]
                                                        .status! ==
                                                    'enable') {
                                                  Dialogs
                                                      .showDialogWithTwoButtonsMsg(
                                                          context: context,
                                                          title: 'Warning!',
                                                          subtitle:
                                                              'By performing this operation: \nDevices of the SecureRooms who have this VPN enabled may not be able to access Google services (search, gmail, etc.) briefly for a few minutes. Are you sure! You want to disable this VPN?',
                                                          button1Func: () {
                                                            Get.back();
                                                          },
                                                          button2Func:
                                                              () async {
                                                            Get.back();
                                                            controller.setVpn(
                                                                controller
                                                                    .fillChangeVpnStatus(
                                                                        index));
                                                            if (Get.previousRoute ==
                                                                Routes
                                                                    .ADD_ROOM) {
                                                              AddRoomController
                                                                  addRoomController =
                                                                  Get.find<
                                                                      AddRoomController>();
                                                              addRoomController
                                                                  .getVpnList();
                                                            } else if (Get
                                                                    .previousRoute ==
                                                                Routes
                                                                    .SECURE_ROOM_TABS) {
                                                              SecureRoomTabsController
                                                                  secureRoomTabsController =
                                                                  Get.find<
                                                                      SecureRoomTabsController>();
                                                              secureRoomTabsController
                                                                  .getVpnList();
                                                            }
                                                          });
                                                } else {
                                                  controller.setVpn(controller
                                                      .fillChangeVpnStatus(
                                                          index));
                                                  if (Get.previousRoute ==
                                                      Routes.ADD_ROOM) {
                                                    AddRoomController
                                                        addRoomController =
                                                        Get.find<
                                                            AddRoomController>();
                                                    addRoomController
                                                        .getVpnList();
                                                  } else if (Get
                                                          .previousRoute ==
                                                      Routes.SECURE_ROOM_TABS) {
                                                    SecureRoomTabsController
                                                        secureRoomTabsController =
                                                        Get.find<
                                                            SecureRoomTabsController>();
                                                    secureRoomTabsController
                                                        .getVpnList();
                                                  }
                                                }
                                              } else {
                                                Dialogs.showAlertDialogWithTitleContent(
                                                    titleText:
                                                        'Server Not Selected',
                                                    bodyText:
                                                        'Please select VPN server and try again');
                                              }
                                            },
                                      buttonText: controller.getVpnModel
                                                  .vpnList![index].status! ==
                                              'enable'
                                          ? 'Disable VPN'
                                          : 'Enable VPN',
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      buttonColor: controller
                                              .listOfSelectedServers[index]
                                              .value
                                              .name!
                                              .isEmpty
                                          ? AppColors.appGrey
                                          : controller
                                                      .getVpnModel
                                                      .vpnList![index]
                                                      .status! ==
                                                  'enable'
                                              ? AppColors.red
                                              : AppColors.primary,
                                    ),
                                    if (controller.listOfSelectedServers[index]
                                        .value.name!.isEmpty)
                                      const Text(
                                          'Before enabling the VPN, please select a server.'),
                                  ],
                                ),
                              );
                              // });
                            }),
                        SizedBox(height: Get.height * 0.08),
                      ],
                    ),
                  if (!controller.showLoader.value &&
                      controller.showEnableVPN.value)
                    SingleChildScrollView(
                      child: SafeArea(
                        child: Column(
                          children: [
                            const SizedBox(height: 24),
                            RefreshSign(
                                showRefreshTitle: controller.showRefreshTitle),
                            SizedBox(
                                height: 180,
                                width: Get.width,
                                child: Image.asset(
                                  Assets.images.vpnBanner.path,
                                  width: Get.width,
                                  fit: BoxFit.fitWidth,
                                )),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Your Rio Router provides two distinct VPN connections to various server locations, for enhanced security of the secured rooms.\n',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 13),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Your VPN account is pre-provisioned for one year. Please follow the steps below to enable the VPN connections. You can then configure secured rooms to use these VPN connections.',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 13),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 32),
                              child: Text(
                                'Your VPN account is getting this error "${controller.getVpnLoginStatusModel.loginStatusStr}". Please contact our support team to resolve it.',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.red),
                              ),
                            ),
                            SizedBox(height: Get.height * 0.2),
                          ],
                        ),
                      ),
                    ),
                  if (controller.showLoader.value)
                    Positioned(
                      child: SizedBox(
                        height: Get.height * 0.8,
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

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ((Get.width - 64) / 2),
      height: 20,
      child: FittedBox(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.appGrey,
            fontWeight: FontWeight.w400,
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}
