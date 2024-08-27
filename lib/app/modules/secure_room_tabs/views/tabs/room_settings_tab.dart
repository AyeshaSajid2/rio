import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:usama/core/components/widgets/outlined_app_button.dart';

import '../../../../../core/components/widgets/app_text_field.dart';
import '../../../../../core/components/widgets/filled_round_button.dart';
import '../../../../../core/extensions/imports.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../data/models/vpn/get_vpn_2_model.dart';
import '../../../../data/params/rooms/get_room_param.dart';
import '../../../../routes/app_pages.dart';
import '../../../secure_room/controllers/secure_room_controller.dart';
import '../../controllers/secure_room_tabs_controller.dart';

class RoomSettingsTabView extends GetView<SecureRoomTabsController> {
  const RoomSettingsTabView({super.key});
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
                child: Form(
                  key: controller.settingsKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.getRoomModel.ssidId != '0' &&
                          controller.getRoomModel.ssidId != '')
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: SizedBox(
                              width: Get.width,
                              child: Obx(() {
                                return ListTile(
                                  title: const Text('Room Status'),
                                  trailing: CupertinoSwitch(
                                      activeColor: AppColors.primary,
                                      value: controller.enableRoomStatus.value,
                                      onChanged: (value) {
                                        controller.enableRoomStatus.value =
                                            value;
                                      }),
                                  tileColor: AppColors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                );
                              })),
                        ),
                      if (controller.getRoomModel.ssidId != '')
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: const Text(
                              'WiFi Network',
                              style: TextStyle(
                                color: AppColors.appBlack,
                                fontSize: 16,
                                // fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: Text(
                              controller.roomListItem.ssidName!,
                              style: const TextStyle(
                                color: AppColors.appBlack,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            tileColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Text(
                                'Room Name',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black.withOpacity(0.5)),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: AppTextField(
                                controller: controller.roomNameTEC,
                                obscureText: false,
                                hintText: 'Enter Room Name',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter room name';
                                  } else if (value
                                      .removeAllWhitespace.isEmpty) {
                                    return 'Please enter a valid room name';
                                  } else if (controller
                                      .checkRoomNameAlreadyExist(value)) {
                                    return 'Room name already exists';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (controller.getRoomModel.ssidId != '' &&
                          controller.roomPasswordTEC.text.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Change Password',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.black,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.SHARE_PASSWORD, arguments: {
                                  'pageTitle': controller.getRoomModel.name,
                                  'ssid': controller.getRoomModel.ssidName,
                                  'password': controller.getRoomModel.password,
                                });
                              },
                              child: const Row(
                                children: [
                                  Text(
                                    'Share Password',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.share_outlined,
                                    color: AppColors.primary,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (controller.getRoomModel.id != '0')
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'New Password',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black.withOpacity(0.5)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: AppTextField(
                                  controller: controller.roomPasswordTEC,
                                  obscureText:
                                      !controller.showWiFiPassword.value,
                                  hintText: 'Enter Password',
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      controller.showWiFiPassword.value =
                                          !controller.showWiFiPassword.value;
                                    },
                                    child: Icon(
                                        controller.showWiFiPassword.value
                                            ? Icons.visibility_off_outlined
                                            : Icons.remove_red_eye_outlined),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      // controller.updateSettingScreenSize(1);
                                      return 'Please Enter Password';
                                    } else if (value.length < 8 ||
                                        value.length > 16) {
                                      // controller.updateSettingScreenSize(1);
                                      return 'Password length must be 8-16 characters';
                                    } else if (controller
                                        .checkRoomPasswordAlreadyExist(value)) {
                                      return 'Please use a unique password for each room';
                                    } else if (value !=
                                        controller
                                            .roomConfirmPasswordTEC.text) {
                                      // controller.updateSettingScreenSize(1);
                                      return 'Both passwords are different';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Confirm Password',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              AppColors.black.withOpacity(0.5)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: AppTextField(
                                        controller:
                                            controller.roomConfirmPasswordTEC,
                                        obscureText: !controller
                                            .showConfirmWiFiPassword.value,
                                        hintText: 'Confirm Password',
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            controller.showConfirmWiFiPassword
                                                    .value =
                                                !controller
                                                    .showConfirmWiFiPassword
                                                    .value;
                                          },
                                          child: Icon(controller
                                                  .showConfirmWiFiPassword.value
                                              ? Icons.visibility_off_outlined
                                              : Icons.remove_red_eye_outlined),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            // controller.updateSettingScreenSize(2);
                                            return 'Please Enter Password';
                                          } else if (value !=
                                              controller.roomPasswordTEC.text) {
                                            // controller.updateSettingScreenSize(2);
                                            return 'Both passwords are different';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                        child: const Text(
                          'Select VPN for this room',
                          style: TextStyle(
                              fontSize: 14, color: AppColors.appBlack),
                        ),
                      ),
                      ListView.builder(
                          itemCount: controller.vpnList.length,
                          shrinkWrap: true,
                          // reverse: true,
                          // padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (controller.vpnList[index].server == '') {
                              return SizedBox(
                                width: Get.width / 2,
                                child: OutlinedAppButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.VPN);
                                  },
                                  buttonText: 'Configure VPN Server',
                                  buttonColor: AppColors.red,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                ),
                              );
                            }
                            return Obx(() {
                              return RadioListTile<VpnItem>.adaptive(
                                value: controller.vpnList[index],
                                title: (controller.vpnList[index].status ==
                                        'disable')
                                    ? SizedBox(
                                        width: Get.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (controller.vpnList[index]
                                                              .server! !=
                                                          'none' &&
                                                      controller.vpnList[index]
                                                              .country !=
                                                          null &&
                                                      controller
                                                          .vpnList[index]
                                                          .country!
                                                          .isNotEmpty &&
                                                      controller.vpnList[index]
                                                              .city !=
                                                          null &&
                                                      controller.vpnList[index]
                                                          .city!.isNotEmpty)
                                                    Text(
                                                      '${controller.vpnList[index].city!} (${controller.vpnList[index].country!})',
                                                      style: const TextStyle(
                                                        color: AppColors.red,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  Text(
                                                    '${controller.vpnList[index].server!} (disable)',
                                                    style: const TextStyle(
                                                      color: AppColors.red,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.toNamed(Routes.VPN);
                                              },
                                              child: const Text(
                                                'Enable VPN',
                                                style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: 14,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor:
                                                      AppColors.primary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (controller
                                                      .vpnList[index].server! !=
                                                  'none' &&
                                              controller
                                                      .vpnList[index].country !=
                                                  null &&
                                              controller.vpnList[index].country!
                                                  .isNotEmpty &&
                                              controller.vpnList[index].city !=
                                                  null &&
                                              controller.vpnList[index].city!
                                                  .isNotEmpty)
                                            Text(
                                              '${controller.vpnList[index].city!} (${controller.vpnList[index].country!})',
                                              style: TextStyle(
                                                color: controller.vpnList[index]
                                                            .connection ==
                                                        'disconnected'
                                                    ? AppColors.red
                                                    : AppColors.primary,
                                                fontSize: 16,
                                              ),
                                            ),
                                          Text(
                                            '${controller.vpnList[index].server!} ${controller.vpnList[index].connection == 'disconnected' ? '(disconnected)' : ''}',
                                            style: TextStyle(
                                              color: controller.vpnList[index]
                                                          .server! ==
                                                      'none'
                                                  ? AppColors.appBlack
                                                  : controller.vpnList[index]
                                                              .connection ==
                                                          'disconnected'
                                                      ? AppColors.red
                                                      : AppColors.primary,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                groupValue: controller.selectedVPN.value,
                                onChanged: (vpn) {
                                  if (controller.vpnList[index].status ==
                                          'disable' ||
                                      controller.vpnList[index].server! ==
                                          'none' ||
                                      controller.vpnList[index].connection ==
                                          'disconnected') {
                                    Dialogs.showDialogWithTwoButtonsMsg(
                                        context: context,
                                        title: 'Warning!',
                                        subtitle:
                                            'By performing this operation: \nDevices in this room may not be able to access Google services (search, gmail, etc.) briefly for a few minutes.',
                                        button1Func: () {
                                          Get.back();
                                        },
                                        button2Func: () {
                                          Get.back();
                                          controller.selectedVPN.value = vpn!;
                                        });
                                  } else {
                                    controller.selectedVPN.value = vpn!;
                                  }
                                },
                                contentPadding: EdgeInsets.zero,
                                visualDensity: const VisualDensity(
                                    vertical: -4, horizontal: -4),
                                activeColor: AppColors.appBlack,
                              );
                            });
                          }),
                      // if (controller.showSetVpnButton.value)
                      //   Column(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //         'Please Set your VPN Account and Enable VPNs',
                      //         style: TextStyle(
                      //             fontSize: 14.sp,
                      //             fontWeight: FontWeight.w400,
                      //             color: AppColors.red),
                      //       ),
                      //       SizedBox(
                      //         width: Get.width / 2,
                      //         child: OutlinedAppButton(
                      //           onPressed: () {
                      //             Get.toNamed(Routes.SET_API_ACCOUNT,
                      //                 arguments: {
                      //                   'isFromVPN': false,
                      //                   'isFromAddRoom': false
                      //                 });
                      //           },
                      //           buttonText: 'Set VPN Account',
                      //           buttonColor: AppColors.red,
                      //           padding:
                      //               const EdgeInsets.symmetric(vertical: 4),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      FilledRoundButton(
                        onPressed: () {
                          if (controller.settingsKey.currentState!.validate()) {
                            //Room Modify
                            controller
                                .setRoom(controller.fillSetRoomModify())
                                .then((value) {
                              if (value != null) {
                                controller
                                    .getRoom(GetRoomParam(
                                        id: controller.roomListItem.id!))
                                    .then((value) async {
                                  if (controller.isFromSecureRoom) {
                                    if (controller.isAllRooms!) {
                                      //Update both Room Lists simultaneously at dashboard and secure rooms
                                      SecureRoomController
                                          secureRoomController =
                                          Get.find<SecureRoomController>();
                                      await secureRoomController
                                          .callGetAllRooms();
                                    } else {
                                      //Update both Room Lists separately at dashboard and secure rooms for particular ssid
                                      SecureRoomController
                                          secureRoomController =
                                          Get.find<SecureRoomController>();
                                      await secureRoomController
                                          .callGetRoomsOfSSID(
                                              secureRoomController.ssid);
                                      controller.dashboardController
                                          .startFunc();
                                    }
                                  } else {
                                    //Update Room List at dashboard
                                    controller.dashboardController.startFunc();
                                  }
                                });

                                //     .then((value) => controller.getRoomList(
                                //         controller.fillGetAllRooms()))
                                //     .then((value) {
                                //   if (value != null) {
                                //     controller.secureRoomController
                                //         .getRoomListModel = value;
                                //   }
                                // });
                              }
                            });
                          }
                        },
                        buttonText: 'Save',
                        padding: const EdgeInsets.symmetric(vertical: 4),
                      ),
                      SizedBox(height: Get.height * 0.08),
                    ],
                  ),
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
