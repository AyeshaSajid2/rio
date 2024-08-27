import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:usama/app/routes/app_pages.dart';
import 'package:usama/core/utils/helpers/common_func.dart';

import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/components/widgets/app_pop_up_menu.dart';
import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/components/widgets/outlined_app_button.dart';
import '../../../../core/theme/colors.dart';

import '../../../../gen/assets.gen.dart';
import '../controllers/wireless_network_controller.dart';

class WirelessNetworkView extends GetView<WirelessNetworkController> {
  const WirelessNetworkView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      appBar: const RioAppBar(
        titleText: 'Wireless Network',
        // onTap: () {
        //   Get.toNamed(Routes.ADD_WIRELESS_NETWORK);
        // },
      ),
      body: Obx(() {
        return Stack(
          children: [
            if (controller.getWifiListModel.listOfWifi != null &&
                !controller.showLoader.value)
              SizedBox(
                height: Get.height - Get.bottomBarHeight,
                child: Column(
                  children: [
                    Expanded(
                      flex: 9,
                      child: SingleChildScrollView(
                        controller: controller.scrollController,
                        child: Column(
                          children: [
                            const SizedBox(height: 24),
                            ListView.builder(
                                controller: controller.scrollController,
                                itemCount: controller
                                    .getWifiListModel.listOfWifi!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                        color: AppColors.white),
                                    padding: const EdgeInsets.all(24),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Form(
                                      key: controller
                                          .listOfWirelessNetworkKey[index],
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const TitleText(
                                                  title:
                                                      'WiFi Network Name (SSID)',
                                                ),
                                                SizedBox(
                                                  width: ((Get.width - 64) / 2),
                                                  child: TextFormField(
                                                    controller: controller
                                                            .listOfWifiNameTEC[
                                                        index],
                                                    enabled: index == 0
                                                        ? false
                                                        : true,
                                                    onChanged: (p0) {},
                                                    onTapOutside: (event) {
                                                      constants.dismissKeyboard(
                                                          context);
                                                    },
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    decoration: InputDecoration(
                                                        isCollapsed: true,
                                                        suffixText: (index ==
                                                                    1 ||
                                                                index == 2 ||
                                                                index == 3)
                                                            ? controller
                                                                    .listOfSuffixText[
                                                                index]
                                                            : null,
                                                        hintText: 'WiFi Name',
                                                        border:
                                                            const UnderlineInputBorder()),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const TitleText(
                                                  title: 'Password',
                                                ),
                                                SizedBox(
                                                  width: ((Get.width - 64) / 2),
                                                  child: Obx(() {
                                                    return TextFormField(
                                                      controller: controller
                                                              .listOfWifiPasswordTEC[
                                                          index],
                                                      onTapOutside: (event) {
                                                        constants
                                                            .dismissKeyboard(
                                                                context);
                                                      },
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                      obscureText: !controller
                                                          .listOfShowWiFiPassword[
                                                              index]
                                                          .value,
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please Enter Password';
                                                        } else if (value
                                                                    .length <
                                                                8 ||
                                                            value.length > 16) {
                                                          return '8-16 characters are must';
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                              hintText:
                                                                  'WiFi Password',
                                                              isDense: true,
                                                              isCollapsed: true,
                                                              errorMaxLines: 2,
                                                              suffixIconConstraints:
                                                                  const BoxConstraints(
                                                                      maxHeight:
                                                                          24),
                                                              suffixIcon:
                                                                  InkWell(
                                                                onTap: () {
                                                                  controller
                                                                          .listOfShowWiFiPassword[
                                                                              index]
                                                                          .value =
                                                                      !controller
                                                                          .listOfShowWiFiPassword[
                                                                              index]
                                                                          .value;
                                                                },
                                                                child: Icon(controller
                                                                        .listOfShowWiFiPassword[
                                                                            index]
                                                                        .value
                                                                    ? Icons
                                                                        .visibility_off_outlined
                                                                    : Icons
                                                                        .remove_red_eye_outlined),
                                                              ),
                                                              border:
                                                                  const UnderlineInputBorder()),
                                                    );
                                                  }),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const TitleText(
                                                  title: 'Status',
                                                ),
                                                AppPopUpMenu(
                                                  listOfPopupMenuItems: [
                                                    AppPopupMenuItem.item(
                                                        menuText: 'Enable',
                                                        svgPath: ''),
                                                    if (index != 0)
                                                      AppPopupMenuItem.item(
                                                          menuText: 'Disable',
                                                          svgPath: ''),
                                                    AppPopupMenuItem.item(
                                                        menuText: '2.4g_only',
                                                        svgPath: ''),
                                                    AppPopupMenuItem.item(
                                                        menuText: '5g_only',
                                                        svgPath: ''),
                                                  ],
                                                  onSelected: (status) {
                                                    controller
                                                            .listOfWifiStatuses[
                                                                index]
                                                            .value =
                                                        status.toLowerCase();
                                                  },
                                                  child: Obx(() {
                                                    return TrailingNetworkWidget(
                                                      text: controller
                                                          .listOfWifiStatuses[
                                                              index]
                                                          .value
                                                          .capitalizeFirst!,
                                                      // onTap: () {},
                                                      showDropDown: true,
                                                    );
                                                  }),
                                                ),
                                                // Obx(() {
                                                //   return CupertinoSwitch(
                                                //       activeColor:
                                                //           AppColors.primary,
                                                //       value: controller
                                                //           .listOfWifiStatuses[
                                                //               index]
                                                //           .value,
                                                //       onChanged: (value) {
                                                //         controller
                                                //             .listOfWifiStatuses[
                                                //                 index]
                                                //             .value = value;
                                                //       });
                                                // }),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const TitleText(
                                                  title: 'Frequency',
                                                ),
                                                TrailingNetworkWidget(
                                                  text: controller
                                                      .getWifiListModel
                                                      .listOfWifi![index]
                                                      .frequency!,
                                                  onTap: () {},
                                                  showDropDown: false,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const TitleText(
                                                  title: 'Security Setting',
                                                ),
                                                TrailingNetworkWidget(
                                                  text: controller
                                                      .getWifiListModel
                                                      .listOfWifi![index]
                                                      .security!,
                                                  onTap: () {},
                                                  showDropDown: false,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const TitleText(
                                                  title: 'WPA Encryption',
                                                ),
                                                TrailingNetworkWidget(
                                                  text: controller
                                                      .getWifiListModel
                                                      .listOfWifi![index]
                                                      .encryption!,
                                                  onTap: () {},
                                                  showDropDown: false,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const TitleText(
                                                  title: 'SSID Broadcast',
                                                ),
                                                AppPopUpMenu(
                                                  listOfPopupMenuItems: [
                                                    AppPopupMenuItem.item(
                                                        menuText: 'Enable',
                                                        svgPath: ''),
                                                    AppPopupMenuItem.item(
                                                        menuText: 'Disable',
                                                        svgPath: ''),
                                                  ],
                                                  onSelected:
                                                      (broadcastStatus) {
                                                    controller
                                                            .listOfBroadcastValue[
                                                                index]
                                                            .value =
                                                        broadcastStatus
                                                            .toLowerCase();
                                                  },
                                                  child: Obx(() {
                                                    return TrailingNetworkWidget(
                                                      text: controller
                                                          .listOfBroadcastValue[
                                                              index]
                                                          .value
                                                          .capitalizeFirst!,
                                                      showDropDown: true,
                                                      // onTap: () {},
                                                    );
                                                  }),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: ((Get.width - 64) / 2),
                                                child: OutlinedAppButton(
                                                  onPressed: () {
                                                    Get.toNamed(
                                                        Routes.SECURE_ROOM,
                                                        arguments: {
                                                          'isAllRooms': false,
                                                          'SSID': controller
                                                              .getWifiListModel
                                                              .listOfWifi![
                                                                  index]
                                                              .id!,
                                                          'SSID_Name': controller
                                                              .getWifiListModel
                                                              .listOfWifi![
                                                                  index]
                                                              .name!,
                                                        });
                                                  },
                                                  buttonText: 'Show Rooms',
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 4),
                                                  buttonColor: AppColors.black,
                                                ),
                                              ),
                                              SizedBox(
                                                width: ((Get.width - 64) / 2),
                                                child: FilledRoundButton(
                                                  onPressed: () {
                                                    if (controller
                                                        .listOfWirelessNetworkKey[
                                                            index]
                                                        .currentState!
                                                        .validate()) {
                                                      controller.save(index);
                                                    }
                                                  },
                                                  buttonText: 'Save',
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 4),
                                                ),
                                              ),
                                              // SizedBox(
                                              //   width: ((Get.width - 64) / 2),
                                              //   child: OutlinedAppButton(
                                              //     onPressed: () {
                                              //       controller.setWifi(controller
                                              //           .fillDeleteWifi(index));
                                              //     },
                                              //     buttonText: 'Delete Network',
                                              //     padding: const EdgeInsets.symmetric(
                                              //         vertical: 4),
                                              //     buttonColor: AppColors.red,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: ((Get.width)),
                                            child: OutlinedAppButton(
                                              onPressed: () {
                                                Get.toNamed(
                                                    Routes.SHARE_PASSWORD,
                                                    arguments: {
                                                      'pageTitle': controller
                                                          .getWifiListModel
                                                          .listOfWifi![index]
                                                          .name,
                                                      'ssid': controller
                                                          .getWifiListModel
                                                          .listOfWifi![index]
                                                          .name,
                                                      'password': controller
                                                          .getWifiListModel
                                                          .listOfWifi![index]
                                                          .password,
                                                    });
                                              },
                                              buttonText: 'Share WiFi Password',
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                            if (!controller.isFirstTimer)
                              SizedBox(height: Get.height * 0.08),
                          ],
                        ),
                      ),
                    ),
                    if (controller.isFirstTimer)
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: FilledRoundButton(
                            onPressed: () {
                              Get.offAllNamed(Routes.DASHBOARD);
                            },
                            buttonText: 'Go to Dashboard',
                            padding: const EdgeInsets.symmetric(vertical: 4),
                          ),
                        ),
                      )
                  ],
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

class TrailingNetworkWidget extends StatelessWidget {
  const TrailingNetworkWidget({
    super.key,
    this.onTap,
    required this.text,
    required this.showDropDown,
  });

  final void Function()? onTap;
  final String text;
  final bool showDropDown;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: ((Get.width - 64) / 2),
        child: showDropDown
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(text),
                      if (showDropDown)
                        InkWell(
                            onTap: onTap,
                            child: const Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.appGrey,
                            ))
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    height: 1,
                  )
                ],
              )
            : Container(
                decoration:
                    BoxDecoration(color: AppColors.primary.withOpacity(0.04)),
                child: Text(
                  text,
                  style: const TextStyle(color: AppColors.appGrey),
                ),
              ));
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
