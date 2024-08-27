import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:usama/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:usama/app/modules/router_setup/controllers/router_setup_controller.dart';

import '../../../app/data/models/url/get_allowed_url_list_model.dart';
import '../../../app/data/models/vpn/get_vpn_server_list_model.dart';
import '../../../app/data/params/rooms/set_room_param.dart';
import '../../../app/data/params/url/get_allowed_url_list_param.dart';
import '../../../app/modules/secure_room_tabs/controllers/secure_room_tabs_controller.dart';
import '../../../app/modules/vpn/controllers/vpn_controller.dart';
import '../../../gen/assets.gen.dart';
import '../../extensions/imports.dart';
import '../../theme/colors.dart';
import '../widgets/rio_app_bar.dart';
import '../widgets/app_text_field.dart';
import '../widgets/filled_rect_button.dart';
import '../widgets/filled_round_button.dart';

class Dialogs {
  static Future<dynamic> showSimpleDialog({
    required String titleText,
  }) {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            titleText,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: FilledRectButton(
                  onPressed: () {
                    Get.back();
                  },
                  buttonText: 'OK'),
            )
          ],
        );
      },
    );
  }

  static Future<dynamic> showErrorDialog({
    required String errorCode,
    required String errorMessage,
  }) {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            "$errorCode : $errorMessage",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: FilledRectButton(
                  buttonColor: AppColors.red,
                  onPressed: () {
                    Get.back();
                  },
                  buttonText: 'OK'),
            )
          ],
        );
      },
    );
  }

  static Future<dynamic> showAlertDialogWithTitleContent({
    required String titleText,
    required String bodyText,
  }) {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            titleText,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(
            bodyText,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: FilledRectButton(
                  onPressed: () {
                    Get.back();
                  },
                  buttonText: 'OK'),
            )
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        );
      },
    );
  }

  static Future<dynamic> showDialogWithTwoButtonsMsg({
    required BuildContext context,
    required String title,
    required String subtitle,
    // required String button1Text,
    // required String button2Text,
    // required Color button1Color,
    // required Color button2Color,
    required void Function()? button1Func,
    required void Function()? button2Func,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Container(
            // height: 120,

            decoration: BoxDecoration(
                color: AppColors.dialogueBackground,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Divider(height: 0),
                SizedBox(
                  height: 44,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: button1Func,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'No',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        width: 0,
                        thickness: 0.5,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: button2Func,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.red),
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
        );
      },
    );
  }

  static Future<bool?> showDialogWithTwoTextButtonsMsg({
    required String title,
    required String subtitle,
    required String button1Text,
    required String button2Text,
    required Color button1Color,
    required Color button2Color,
    required void Function()? button1Func,
    required void Function()? button2Func,
  }) {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Container(
            // height: 120,

            decoration: BoxDecoration(
                color: AppColors.dialogueBackground,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Divider(height: 0),
                SizedBox(
                  height: 44,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: button1Func,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              button1Text,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: button1Color),
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        width: 0,
                        thickness: 0.5,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: button2Func,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              button2Text,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: button2Color),
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
        );
      },
    );
  }

  static Future<dynamic> showDialogWithColumnTwoButtonsMsg({
    required BuildContext context,
    required String title,
    required String subtitle,
    required void Function()? button1Func,
    required void Function()? button2Func,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Container(
            height: 300,
            decoration: BoxDecoration(
                color: AppColors.dialogueBackground,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 0),
                Expanded(
                  child: InkWell(
                    onTap: button1Func,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              'YES',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: AppColors.green,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'I am connected to my Router WiFi.\n Try again.',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(height: 0),
                Expanded(
                  child: InkWell(
                    onTap: button2Func,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(12),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              'NO',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: AppColors.red,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'I am away from my Router. \nConnect to the Router remotely.',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<dynamic> showAlertDialogueForSSID({
    required BuildContext context,
    required String msg,
    required String button1Text,
    required String button2Text,
    required Color button1Color,
    required Color button2Color,
    required void Function()? button1Func,
    required void Function()? button2Func,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            msg,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: FilledRectButton(
                    onPressed: button1Func,
                    buttonText: button1Text,
                    buttonColor: button1Color,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: FilledRectButton(
                      onPressed: button2Func,
                      buttonText: button2Text,
                      buttonColor: button2Color),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  static Future<dynamic> showDialogWithSingleButtonMsg({
    required String msg,
    required String button1Text,
    required Color button1Color,
    required void Function()? button1Func,
  }) {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            msg,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: FilledRectButton(
                      onPressed: button1Func,
                      buttonText: button1Text,
                      buttonColor: button1Color),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  static Future<dynamic> showDialogWithImage({
    required String imagePath,
  }) {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Image.asset(imagePath),
          actions: [
            Row(
              children: [
                Expanded(
                  child: FilledRectButton(
                      onPressed: () {
                        Get.back();
                      },
                      buttonText: 'OK'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  static Future<dynamic> showAddEditRoomBottomSheet({
    required SetRoomParam roomParam,
    required bool isNewRoom,
    required int index,
    required int i,
  }) {
    RouterSetupController controller = Get.find<RouterSetupController>();
    final settingsKey = GlobalKey<FormState>();
    final roomNameTEC =
        TextEditingController(text: roomParam.nameEncode.decodeBase64);
    final roomPasswordTEC = TextEditingController(text: roomParam.password);
    final confirmPasswordTEC = TextEditingController(text: roomParam.password);
    RxBool enableRoomStatus =
        roomParam.roomStatus == 'enable' ? true.obs : false.obs;
    RxBool enableParentControl =
        roomParam.parentalControl == 'enable' ? true.obs : false.obs;
    RxBool showRoomPassword = false.obs;
    RxBool showConfirmPassword = false.obs;
    return showModalBottomSheet(
      context: Get.context!,
      // showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      constraints: BoxConstraints(maxHeight: Get.height * 0.9),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.75),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                width: Get.width,
                child: Center(
                    child: Container(
                  height: 5,
                  width: 36,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: AppColors.appGrabber,
                      borderRadius: BorderRadius.circular(5)),
                )),
              ),
              RioAppBar(titleText: isNewRoom ? 'Add Room' : 'Edit Room'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: settingsKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Obx(() {
                              return ListTile(
                                title: const Text('Room Status'),
                                trailing: CupertinoSwitch(
                                    activeColor: AppColors.primary,
                                    value: enableRoomStatus.value,
                                    onChanged: (value) {
                                      enableRoomStatus.value = value;
                                    }),
                                tileColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              );
                            })),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Obx(() {
                              return ListTile(
                                title: const Text('Parental Control'),
                                trailing: CupertinoSwitch(
                                    activeColor: AppColors.primary,
                                    value: enableParentControl.value,
                                    onChanged: (value) {
                                      enableParentControl.value = value;
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
                                controller: roomNameTEC,
                                obscureText: false,
                                // hintText: 'Enter Room Name',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    // controller.updateSettingScreenSize(0);
                                    return 'Please Enter Room Name';
                                  } else if (value
                                      .removeAllWhitespace.isEmpty) {
                                    return 'Please enter a valid room name';
                                  } else if (controller.duplicateRoomNameCheck(
                                      index, i, value)) {
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
                              child: Obx(() {
                                return AppTextField(
                                  controller: roomPasswordTEC,
                                  obscureText: !showRoomPassword.value,
                                  // hintText: 'Enter Password',
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      showRoomPassword.value =
                                          !showRoomPassword.value;
                                    },
                                    child: Icon(showRoomPassword.value
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
                                        .duplicatePasswordCheck(
                                            index, i, value)) {
                                      return 'Password should be unique in all rooms';
                                    } else {
                                      return null;
                                    }
                                  },
                                );
                              }),
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
                                    child: Obx(() {
                                      return AppTextField(
                                        controller: confirmPasswordTEC,
                                        obscureText: !showConfirmPassword.value,
                                        // hintText: 'Confirm Password',
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            showConfirmPassword.value =
                                                !showConfirmPassword.value;
                                          },
                                          child: Icon(showConfirmPassword.value
                                              ? Icons.visibility_off_outlined
                                              : Icons.remove_red_eye_outlined),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            // controller.updateSettingScreenSize(2);
                                            return 'Please Enter Password';
                                          } else if (value !=
                                              roomPasswordTEC.text) {
                                            // controller.updateSettingScreenSize(2);
                                            return 'Both passwords are different';
                                          } else {
                                            return null;
                                          }
                                        },
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      FilledRoundButton(
                        onPressed: () {
                          if (settingsKey.currentState!.validate()) {
                            roomParam.nameEncode =
                                roomNameTEC.text.encodeToBase64;
                            roomParam.password = roomPasswordTEC.text;
                            roomParam.roomStatus =
                                enableRoomStatus.value ? 'enable' : 'disable';
                            roomParam.parentalControl =
                                enableParentControl.value
                                    ? 'enable'
                                    : 'disable';
                            //Adding Room
                            if (isNewRoom) {
                              controller.addNewRoom(roomParam);
                            } else {
                              //ModifyRoom
                              controller.modifyRoom(roomParam, index, i);
                            }

                            Get.back();
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
            ],
          ),
        );
      },
    );
  }

  static Future<dynamic> showRoomDevicesToMoveBottomSheet({
    required String titleText,
    required String type,
    required String currentRoomId,
    required int deviceId,
  }) {
    DashboardController controller = Get.find<DashboardController>();
    return showModalBottomSheet(
      context: Get.context!,
      // showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      constraints: BoxConstraints(maxHeight: Get.height * 0.9),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.75),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                width: Get.width,
                child: Center(
                    child: Container(
                  height: 5,
                  width: 36,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: AppColors.appGrabber,
                      borderRadius: BorderRadius.circular(5)),
                )),
              ),
              RioAppBar(titleText: titleText),
              const Padding(
                padding: EdgeInsets.only(top: 24.0, left: 16, right: 16),
                child: Text(
                  'You can move the device to any of the secure rooms below',
                  style: TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 16,
                  ),
                ),
              ),
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: controller.roomListBottomBarShowLoader.value
                      ? SizedBox(
                          height: Get.height * 0.5,
                          width: Get.width,
                          child: ColoredBox(
                            color: Colors.white12,
                            child: Lottie.asset(Assets.animations.loading),
                          ),
                        )
                      : ListView.builder(
                          itemCount: controller.getRoomsListForMoveToOtherRooms
                              .listOfRoom!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Obx(() {
                              return RadioListTile.adaptive(
                                value: controller
                                    .getRoomsListForMoveToOtherRooms
                                    .listOfRoom![index],
                                title: Text(
                                  controller.getRoomsListForMoveToOtherRooms
                                      .listOfRoom![index].name!,
                                ),
                                groupValue: controller.selectedRoom.value,
                                onChanged: (room) {
                                  controller.selectedRoom.value = room!;
                                },
                                contentPadding: EdgeInsets.zero,
                                visualDensity:
                                    const VisualDensity(vertical: -4),
                                activeColor: AppColors.appBlack,
                              );
                            });
                          }),
                );
              }),
              const Spacer(),
              Column(
                children: [
                  FilledRoundButton(
                      onPressed: () {
                        if (controller.selectedRoom.value.id == currentRoomId) {
                          showDialogWithSingleButtonMsg(
                              msg: 'Device is already in the selected room.',
                              button1Text: 'Back',
                              button1Color: AppColors.primary,
                              button1Func: () {
                                Get.back();
                              });
                        } else {
                          Get.back();
                          controller
                              .moveDevice(
                                  moveDeviceParam: controller.fillMoveDevice(
                                      deviceId: deviceId, type: type),
                                  type: type,
                                  currentRoomId: currentRoomId)
                              .then((value) {
                            // if (currentRoomId.isEmpty) {
                            //   Get.back();
                            // }
                          });
                        }
                      },
                      buttonText: 'Save'),
                  SizedBox(height: Get.height * 0.08),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<dynamic> showAllowedTimesDialog({
    required AllowedUrlItem allowedUrlItem,
    required int urlIndex,
  }) {
    SecureRoomTabsController controller = Get.find<SecureRoomTabsController>();
    if (allowedUrlItem.accessTime == null) {
      controller.selectedTimeAllowedTitle.value =
          controller.listOfAllowedTimes[0];
      controller.listOfSelectedTimes[urlIndex].value = 'allow';
    } else {
      if (allowedUrlItem.accessTime! == 'allow') {
        controller.selectedTimeAllowedTitle.value =
            controller.listOfAllowedTimes[0];
      } else if (allowedUrlItem.accessTime! == 'block') {
        controller.selectedTimeAllowedTitle.value =
            controller.listOfAllowedTimes[2];
      }
      // else if (allowedUrlItem.accessTime!.contains('-')) {
      else {
        controller.selectedTimeAllowedTitle.value =
            controller.listOfAllowedTimes[1];
      }
      // else {
      //   controller.selectedTimeAllowedTitle.value =
      //       controller.listOfAllowedTimes[2];
      // }
    }

    return showModalBottomSheet(
      context: Get.context!,
      // showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      constraints: BoxConstraints(maxHeight: Get.height * 0.9),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.75),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                width: Get.width,
                child: Center(
                    child: Container(
                  height: 5,
                  width: 36,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: AppColors.appGrabber,
                      borderRadius: BorderRadius.circular(5)),
                )),
              ),
              RioAppBar(
                titleText: allowedUrlItem.url!,
                actions: [
                  if (allowedUrlItem.accessTime != null)
                    IconButton(
                      icon: SvgPicture.asset(Assets.svgs.deleteRed),
                      onPressed: () {
                        Get.back();
                        controller
                            .setUrl(controller.fillSetUrlDelete(
                                allowedUrlItem, urlIndex))
                            .then((value) => controller.getUrlList(
                                GetAllowedUrlListParam(
                                    id: controller.roomListItem.id!)));
                      },
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Allowed Times',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.appBlack,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ListView.builder(
                    itemCount: controller.listOfAllowedTimes.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Obx(() {
                        return RadioListTile.adaptive(
                          value: controller.listOfAllowedTimes[index],
                          title: InkWell(
                            onTap: index == 1
                                ? () {
                                    controller.selectedTimeAllowedTitle.value =
                                        controller.listOfAllowedTimes[index];
                                    controller.listOfSelectedTimes[urlIndex]
                                            .value =
                                        '${controller.fromTimeValue}-${controller.toTimeValue}';
                                    showTimeSelectionWheel(
                                        controller, urlIndex);
                                  }
                                : null,
                            child: Text(
                              controller.listOfAllowedTimes[index],
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.appBlack,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          subtitle: (controller.listOfAllowedTimes[index] ==
                                      controller.listOfAllowedTimes[1] &&
                                  controller.listOfSelectedTimes[urlIndex]
                                          .value !=
                                      'allow' &&
                                  controller.listOfSelectedTimes[urlIndex]
                                          .value !=
                                      'block')
                              ? Text(controller
                                  .listOfSelectedTimes[urlIndex].value)
                              : null,
                          groupValue: controller.selectedTimeAllowedTitle.value,
                          onChanged: (timeAllowed) {
                            if (timeAllowed ==
                                controller.listOfAllowedTimes[0]) {
                              controller.listOfSelectedTimes[urlIndex].value =
                                  'allow';
                            }
                            if (timeAllowed == controller.listOfAllowedTimes[1]
                                //     ||
                                // timeAllowed ==
                                //     controller.listOfAllowedTimes[2]
                                ) {
                              controller.listOfSelectedTimes[urlIndex].value =
                                  '${controller.fromTimeValue}-${controller.toTimeValue}';
                              showTimeSelectionWheel(controller, urlIndex);
                            }
                            if (timeAllowed ==
                                controller.listOfAllowedTimes[2]) {
                              controller.listOfSelectedTimes[urlIndex].value =
                                  'block';
                            }
                            controller.selectedTimeAllowedTitle.value =
                                timeAllowed as String;
                          },
                          contentPadding: EdgeInsets.zero,
                          visualDensity: const VisualDensity(vertical: -4),
                          activeColor: AppColors.appBlack,
                        );
                      });
                    }),
              ),
              const Spacer(),
              Column(
                children: [
                  FilledRoundButton(
                      onPressed: () {
                        if (controller.fromTimerDuration >
                                controller.toTimerDuration &&
                            allowedUrlItem.accessTime != 'allow' &&
                            allowedUrlItem.accessTime != 'block') {
                          constants.showSnackbar(
                              'Invalid Range',
                              'The starting time must be earlier than the ending time.',
                              0);
                        } else {
                          if (allowedUrlItem.accessTime == null) {
                            Get.back();
                            controller
                                .setUrl(controller.fillSetUrlAdd(urlIndex))
                                .then((value) => controller.getUrlList(
                                    GetAllowedUrlListParam(
                                        id: controller.roomListItem.id!)));
                          } else {
                            Get.back();
                            controller
                                .setUrl(controller.fillSetUrlModify(
                                    allowedUrlItem, urlIndex))
                                .then((value) => controller.getUrlList(
                                    GetAllowedUrlListParam(
                                        id: controller.roomListItem.id!)));
                          }
                        }
                      },
                      buttonText: 'Save'),
                  SizedBox(height: Get.height * 0.08),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showTimeSelectionWheel(
      SecureRoomTabsController controller, int urlIndex) {
    return showCupertinoModalPopup<void>(
        context: Get.context!,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            padding: const EdgeInsets.only(top: 6.0),
            color: CupertinoColors.white,
            child: DefaultTextStyle(
              style: const TextStyle(
                color: CupertinoColors.black,
                fontSize: 22.0,
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.width / 2,
                      child: CupertinoTimerPicker(
                        mode: CupertinoTimerPickerMode.hm,
                        minuteInterval: 1,
                        initialTimerDuration: controller.fromTimerDuration,
                        onTimerDurationChanged: (Duration changeTimer) {
                          controller.fromTimerDuration = changeTimer;

                          int hours = changeTimer.inHours;

                          int minutes = changeTimer.inMinutes % 60;

                          controller.fromTimeValue =
                              '${hours > 9 ? hours : '0$hours'}:${minutes > 9 ? minutes : '0$minutes'}';
                          controller.listOfSelectedTimes[urlIndex].value =
                              '${controller.fromTimeValue}-${controller.toTimeValue}';

                          if (controller.fromTimerDuration >
                              controller.toTimerDuration) {
                            constants.showSnackbar(
                                'Invalid Range',
                                'The starting time must be earlier than the ending time.',
                                0);
                          }

                          // print(controller
                          //     .selectedTimeValue);
                        },
                      ),
                    ),
                    SizedBox(
                      width: Get.width / 2,
                      child: CupertinoTimerPicker(
                        mode: CupertinoTimerPickerMode.hm,
                        minuteInterval: 1,
                        initialTimerDuration: controller.toTimerDuration,
                        onTimerDurationChanged: (Duration changeTimer) {
                          controller.toTimerDuration = changeTimer;
                          int hours = changeTimer.inHours;

                          int minutes = changeTimer.inMinutes % 60;

                          controller.toTimeValue =
                              '${hours > 9 ? hours : '0$hours'}:${minutes > 9 ? minutes : '0$minutes'}';
                          // controller.toTimeValue =
                          //     '${changeTimer.inHours}:${changeTimer.inMinutes % 60}';
                          controller.listOfSelectedTimes[urlIndex].value =
                              '${controller.fromTimeValue}-${controller.toTimeValue}';

                          if (controller.fromTimerDuration >
                              controller.toTimerDuration) {
                            constants.showSnackbar(
                                'Invalid Range',
                                'The starting time must be earlier than the ending time.',
                                0);
                          }
                          // print(controller
                          //     .selectedTimeValue);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static Future<dynamic> showVPNServersBottomSheet({
    required RxList<ServerItem> serverList,
    required Rx<ServerItem> selectedServer,
    required VpnController controller,
    required int selectedServerIndex,
  }) {
    TextEditingController searchController = TextEditingController();
    const double itemExtent = 70; // Height of each list item
    final double offset = selectedServerIndex * itemExtent;

    ScrollController scrollController =
        ScrollController(initialScrollOffset: offset, keepScrollOffset: false);

    return showModalBottomSheet(
      context: Get.context!,
      // showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      constraints: BoxConstraints(maxHeight: Get.height * 0.925),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(maxHeight: Get.height * 0.925),
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.75),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                width: Get.width,
                child: Center(
                    child: Container(
                  height: 5,
                  width: 36,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: AppColors.appGrabber,
                      borderRadius: BorderRadius.circular(5)),
                )),
              ),
              const RioAppBar(titleText: 'Select VPN Server'),
              Padding(
                padding: EdgeInsets.all(Get.height * 0.01),
                child: AppTextField(
                  controller: searchController,
                  hintText: 'Search',
                  keyboardType: TextInputType.text,
                  prefixIcon: const Icon(Icons.search),
                  onChanged: (query) {
                    controller.filterSearchResults(query);
                  },
                ),
              ),
              Expanded(
                child: Obx(() {
                  return SizedBox(
                    width: Get.width,
                    child: Scrollbar(
                      controller: scrollController,
                      child: ListView.builder(
                          itemCount: serverList.length,
                          shrinkWrap: true,
                          itemExtent: 70,
                          padding: const EdgeInsets.all(0),
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            return Obx(() {
                              return Container(
                                height: 70,
                                color: AppColors.white,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: RadioListTile<ServerItem>.adaptive(
                                        value: serverList[index],
                                        title: Text(
                                          serverList[index].city!,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: AppColors.appBlack,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        subtitle: Text(
                                          serverList[index].name!,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.appBlack,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        secondary: Text(
                                          serverList[index].country!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: AppColors.appBlack,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        groupValue: selectedServer.value,
                                        onChanged: (server) {
                                          selectedServer.value = server!;
                                          selectedServerIndex = index;
                                          Get.back(result: true);
                                        },
                                        contentPadding: EdgeInsets.zero,
                                        visualDensity:
                                            const VisualDensity(vertical: -4),
                                        activeColor: AppColors.appBlack,
                                      ),
                                    ),
                                    const Divider(
                                      height: 0,
                                      thickness: 1.5,
                                    ),
                                  ],
                                ),
                              );
                            });
                          }),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<dynamic> showDeviceLabelChangeDialog({
    required String textValue,
  }) {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        TextEditingController editingController =
            TextEditingController(text: textValue);
        return SimpleDialog(
          title: AppTextField(
            controller: editingController,
            // style: Theme.of(context).textTheme.bodyMedium,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: FilledRectButton(onPressed: () {}, buttonText: 'Save'),
            )
          ],
        );
      },
    );
  }
}
