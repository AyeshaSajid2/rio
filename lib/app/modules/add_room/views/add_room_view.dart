import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:usama/app/modules/secure_room/controllers/secure_room_controller.dart';

import '../../../../core/components/widgets/app_text_field.dart';
import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/components/widgets/outlined_app_button.dart';
import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/extensions/imports.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../../../data/models/vpn/get_vpn_2_model.dart';
import '../../../data/models/wifi/get_wifi_list_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/add_room_controller.dart';

class AddRoomView extends GetView<AddRoomController> {
  const AddRoomView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      appBar: const RioAppBar(
        titleText: 'Add Room',
        refresh: false,
      ),
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
                                      controller.enableRoomStatus.value = value;
                                    }),
                                tileColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              );
                            })),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SizedBox(
                            width: Get.width,
                            child: Obx(() {
                              return ListTile(
                                title: const Text('Parental Control'),
                                trailing: CupertinoSwitch(
                                    activeColor: AppColors.primary,
                                    value: controller.enableParentControl.value,
                                    onChanged: (value) {
                                      controller.enableParentControl.value =
                                          value;
                                    }),
                                tileColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              );
                            })),
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
                                // hintText: 'Enter Room Name',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    // controller.updateSettingScreenSize(0);
                                    return 'Please Enter Room Name';
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Room Password',
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
                                obscureText: !controller.showWiFiPassword.value,
                                // hintText: 'Enter Password',
                                suffixIcon: InkWell(
                                  onTap: () {
                                    controller.showWiFiPassword.value =
                                        !controller.showWiFiPassword.value;
                                  },
                                  child: Icon(controller.showWiFiPassword.value
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
                                    return 'Password should be different than other room\'s password';
                                  } else if (value !=
                                      controller.roomConfirmPasswordTEC.text) {
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
                                      // hintText: 'Confirm Password',
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
                      const Text(
                        'WiFi Networks',
                        style:
                            TextStyle(fontSize: 14, color: AppColors.appBlack),
                      ),
                      if (controller.getWifiListModel.listOfWifi != null)
                        ListView.builder(
                            itemCount:
                                controller.getWifiListModel.listOfWifi!.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Obx(() {
                                return RadioListTile<WifiElement>.adaptive(
                                  value: controller
                                      .getWifiListModel.listOfWifi![index],
                                  title: Text(
                                    controller.getWifiListModel
                                        .listOfWifi![index].name!,
                                    style: const TextStyle(
                                      color: AppColors.appBlack,
                                      fontSize: 14,
                                      // fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  groupValue: controller.selectedWifiSSID.value,
                                  onChanged: (wifi) {
                                    controller.selectedWifiSSID.value = wifi!;
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  visualDensity: const VisualDensity(
                                      vertical: -4, horizontal: -4),
                                  activeColor: AppColors.appBlack,
                                );
                              });
                            }),
                      const Padding(
                        padding: EdgeInsets.only(top: 12, bottom: 12),
                        child: Text(
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
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (controller.vpnList[index]
                                                          .server! !=
                                                      'none' &&
                                                  controller.vpnList[index]
                                                          .country !=
                                                      null &&
                                                  controller.vpnList[index]
                                                      .country!.isNotEmpty &&
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
                                              style: const TextStyle(
                                                color: AppColors.primary,
                                                fontSize: 16,
                                              ),
                                            ),
                                          Text(
                                            controller.vpnList[index].server!,
                                            style: TextStyle(
                                              color: controller.vpnList[index]
                                                          .server! ==
                                                      'none'
                                                  ? AppColors.appBlack
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
                                          'none') {
                                    Dialogs.showDialogWithTwoButtonsMsg(
                                        context: context,
                                        title: 'Warning!',
                                        subtitle:
                                            'By performing this operation: \nDevices in this room may not be able to access Google services (search, gmail, etc.) briefly for few a  minutes. ',
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
                            //Adding Room
                            controller
                                .setRoom(controller.fillSetRoomAdd())
                                .then((value) async {
                              if (value != null) {
                                Get.back();

                                // if (controller.isFromSecureRooms) {
                                //   SecureRoomController secureRoomController =
                                //       Get.find<SecureRoomController>();
                                //   await secureRoomController.callGetAllRooms();
                                // } else {
                                //   await controller.dashboardController
                                //       .startFunc();
                                // }

                                if (controller.isFromSecureRooms) {
                                  if (controller.isAllRooms!) {
                                    //Update both Room Lists simultaneously at dashboard and secure rooms
                                    SecureRoomController secureRoomController =
                                        Get.find<SecureRoomController>();
                                    await secureRoomController
                                        .callGetAllRooms();
                                  } else {
                                    //Update both Room Lists separately at dashboard and secure rooms for particular ssid
                                    SecureRoomController secureRoomController =
                                        Get.find<SecureRoomController>();
                                    await secureRoomController
                                        .callGetRoomsOfSSID(
                                            secureRoomController.ssid);
                                    await controller.dashboardController
                                        .startFunc();
                                  }
                                } else {
                                  //Update Room List at dashboard
                                  await controller.dashboardController
                                      .startFunc();
                                }
                              }
                            });
                          }
                        },
                        buttonText: 'Save',
                        padding: const EdgeInsets.symmetric(vertical: 4),
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ),
              if (controller.showLoader.value)
                Positioned(
                  child: SizedBox(
                    height: 880,
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
