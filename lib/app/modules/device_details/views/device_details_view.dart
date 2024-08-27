import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:usama/core/components/widgets/outlined_app_button.dart';

import '../../../../core/components/widgets/app_text_field.dart';
import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/extensions/imports.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/device_details_controller.dart';

class DeviceDetailsView extends GetView<DeviceDetailsController> {
  const DeviceDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: RioAppBar(
        titleText: '',
        refreshText: controller.pageTitle,
        refresh: true,
      ),
      body: Obx(() {
        return SizedBox(
          height: controller.dashboardController.showLoader.value
              ? Get.height - Get.bottomBarHeight
              : controller.pageHeight,
          width: Get.width,
          child: RefreshIndicator(
            onRefresh: () {
              return controller.dashboardController
                  .getAllDevices(deviceId: controller.deviceListItem.value.id);
            },
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  if (!controller.dashboardController.showLoader.value)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Form(
                            key: controller.deviceLabelKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: Text(
                                          'Device Name',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black
                                                  .withOpacity(0.5)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: AppTextField(
                                          controller: controller.labelDeviceEC,
                                          obscureText: false,
                                          hintText: 'Enter Device Name',
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please Enter Device Name';
                                            } else {
                                              return null;
                                            }
                                          },
                                          suffixIcon: InkWell(
                                              onTap: () {
                                                if (controller.deviceLabelKey
                                                    .currentState!
                                                    .validate()) {
                                                  constants
                                                      .dismissKeyboard(context);
                                                  controller.dashboardController
                                                      .setDeviceLabel(
                                                    setDeviceLabelParam: controller
                                                        .dashboardController
                                                        .fillDeviceLabel(
                                                            deviceId: controller
                                                                .deviceListItem
                                                                .value
                                                                .id!,
                                                            type: controller
                                                                .deviceType,
                                                            label: controller
                                                                .labelDeviceEC
                                                                .text),
                                                    type: controller.deviceType,
                                                    currentRoomId: controller
                                                        .deviceListItem
                                                        .value
                                                        .roomId!,
                                                  )
                                                      .then((value) async {
                                                    if (value != null) {
                                                      await controller
                                                          .dashboardController
                                                          .getAllDevices(
                                                              deviceId: controller
                                                                  .deviceListItem
                                                                  .value
                                                                  .id)
                                                          .then((value) =>
                                                              controller
                                                                  .setDeviceName());
                                                    }
                                                  });
                                                }
                                              },
                                              child: Container(
                                                width: 80,
                                                margin: const EdgeInsets.all(1),
                                                decoration: const BoxDecoration(
                                                    color: AppColors.primary,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(4),
                                                      bottomRight:
                                                          Radius.circular(4),
                                                    )),
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  'SAVE',
                                                  style: TextStyle(
                                                    color: AppColors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: Get.width,
                            margin: const EdgeInsets.symmetric(vertical: 24),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'MAC Address',
                                        style: TextStyle(
                                          color: AppColors.appGrey,
                                        ),
                                      ),
                                      Text(
                                          controller.deviceListItem.value.mac!),
                                    ],
                                  ),
                                ),
                                const Divider(height: 0),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Status',
                                        style: TextStyle(
                                          color: AppColors.appGrey,
                                        ),
                                      ),
                                      Text(controller
                                          .deviceListItem.value.status!),
                                    ],
                                  ),
                                ),
                                const Divider(height: 0),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Type',
                                        style: TextStyle(
                                          color: AppColors.appGrey,
                                        ),
                                      ),
                                      Text(controller
                                          .deviceListItem.value.role!),
                                    ],
                                  ),
                                ),
                                const Divider(height: 0),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'SSID',
                                        style: TextStyle(
                                          color: AppColors.appGrey,
                                        ),
                                      ),
                                      Text(controller
                                          .deviceListItem.value.ssidName!),
                                    ],
                                  ),
                                ),
                                if (controller.deviceListItem.value.roomName!
                                    .isNotEmpty) ...[
                                  const Divider(height: 0),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Room',
                                          style: TextStyle(
                                            color: AppColors.appGrey,
                                          ),
                                        ),
                                        Text(controller
                                            .deviceListItem.value.roomName!),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          if (controller.deviceListItem.value.ssidId != '' &&
                              // controller.deviceListItem.value.ssidId != '0' &&
                              controller.deviceListItem.value.role != 'admin' &&
                              !controller.isDeviceAdministrator) ...[
                            OutlinedAppButton.icon(
                                onPressed: () {
                                  if (controller.deviceListItem.value
                                              .destRoomId !=
                                          null &&
                                      controller.deviceListItem.value
                                          .destRoomId!.isNotEmpty &&
                                      controller.deviceListItem.value
                                              .destRoomName !=
                                          null &&
                                      controller.deviceListItem.value
                                          .destRoomName!.isNotEmpty) {
                                    controller
                                        .dashboardController
                                        .getRoomsListForMoveToOtherRooms
                                        .listOfRoom!
                                        .clear();

                                    controller
                                        .dashboardController
                                        .getRoomsListForMoveToOtherRooms
                                        .listOfRoom!
                                        .add(controller.dashboardController
                                            .getRoomListModel.listOfRoom!
                                            .firstWhere((element) =>
                                                element.id ==
                                                controller.deviceListItem.value
                                                    .destRoomId!));

                                    controller.dashboardController.selectedRoom
                                            .value =
                                        controller
                                            .dashboardController
                                            .getRoomsListForMoveToOtherRooms
                                            .listOfRoom!
                                            .first;

                                    Dialogs.showRoomDevicesToMoveBottomSheet(
                                      titleText: controller.deviceName,
                                      type: controller.deviceType,
                                      currentRoomId: controller
                                          .deviceListItem.value.roomId!,
                                      deviceId:
                                          controller.deviceListItem.value.id!,
                                    );
                                  } else {
                                    if (controller.deviceType == 'wait') {
                                      controller.dashboardController
                                          .updateWaitRoomList(
                                              controller.deviceType,
                                              controller
                                                  .deviceListItem.value.id!,
                                              // controller.deviceListItem.value.id!,
                                              controller.deviceListItem.value
                                                  .roomId!);
                                      Dialogs.showRoomDevicesToMoveBottomSheet(
                                        titleText: controller.deviceName,
                                        type: controller.deviceType,
                                        currentRoomId: controller
                                            .deviceListItem.value.roomId!,
                                        deviceId:
                                            controller.deviceListItem.value.id!,
                                      );
                                    } else {
                                      controller.dashboardController
                                          .updateRoomList(
                                              controller.deviceType,
                                              controller
                                                  .deviceListItem.value.ssidId!,
                                              // controller.deviceListItem.value.id!,
                                              controller.deviceListItem.value
                                                  .roomId!);
                                      Dialogs.showRoomDevicesToMoveBottomSheet(
                                        titleText: controller.deviceName,
                                        type: controller.deviceType,
                                        currentRoomId: controller
                                            .deviceListItem.value.roomId!,
                                        deviceId:
                                            controller.deviceListItem.value.id!,
                                      );
                                    }
                                  }
                                },

                                //Checking if it is from pending and from guest ssid (Guest ssid=2)
                                buttonText:
                                    controller.deviceListItem.value.roomId == ''
                                        ? controller.deviceListItem.value
                                                    .ssidId ==
                                                '2'
                                            ? 'Approve as guest'
                                            : 'Approve and move to room'
                                        : 'Move to Other Room',
                                svgPath:
                                    controller.deviceListItem.value.roomId == ''
                                        ? controller.deviceListItem.value
                                                    .ssidId ==
                                                '2'
                                            ? Assets.svgs.person
                                            : Assets.svgs.moveTo
                                        : Assets.svgs.moveTo,
                                svgColor:
                                    controller.deviceListItem.value.roomId == ''
                                        ? controller.deviceListItem.value
                                                    .ssidId ==
                                                '2'
                                            ? AppColors.blue
                                            : AppColors.primary
                                        : AppColors.primary,
                                buttonColor:
                                    controller.deviceListItem.value.roomId == ''
                                        ? controller.deviceListItem.value
                                                    .ssidId ==
                                                '2'
                                            ? AppColors.blue
                                            : AppColors.primary
                                        : AppColors.primary),
                          ],
                          if (controller.isDeviceAdministrator &&
                              controller.deviceListItem.value.role ==
                                  'manager' &&
                              controller.deviceListItem.value.ssidId == '0' &&
                              controller.deviceListItem.value.block ==
                                  'disable') ...[
                            OutlinedAppButton.icon(
                                onPressed: () {
                                  //Set Admin

                                  Dialogs.showDialogWithTwoButtonsMsg(
                                      context: context,
                                      title: 'Set Device Admin',
                                      subtitle:
                                          'Are you sure you want to make this Device an Admin?',
                                      button1Func: () {
                                        Get.back();
                                      },
                                      button2Func: () {
                                        Get.back();
                                        controller.dashboardController
                                            .setDeviceAdmin(controller
                                                .dashboardController
                                                .fillSetDeviceAdmin(controller
                                                    .deviceListItem.value.id!));
                                      });
                                },
                                buttonText: 'Set Role to Admin',
                                buttonColor: AppColors.blue,
                                svgPath: Assets.svgs.person,
                                svgColor: AppColors.blue),
                          ],
                          if (controller
                                  .deviceListItem.value.roomId!.isNotEmpty &&
                              controller.deviceListItem.value.role! !=
                                  'admin') ...[
                            OutlinedAppButton.icon(
                                onPressed: () {
                                  if (controller.deviceListItem.value.block ==
                                      'disable') {
                                    //Block Device
                                    Dialogs.showDialogWithTwoButtonsMsg(
                                        context: context,
                                        title: 'Block Device',
                                        subtitle:
                                            'Are you sure you want to block this device?',
                                        button1Func: () {
                                          Get.back();
                                        },
                                        button2Func: () {
                                          Get.back();

                                          controller
                                              .dashboardController
                                              .blockDevice(
                                                  setDeviceBlockParam: controller
                                                      .dashboardController
                                                      .fillBlockDevice(
                                                          deviceId: controller
                                                              .deviceListItem
                                                              .value
                                                              .id!),
                                                  type:
                                                      controller
                                                          .dashboardController
                                                          .blockDeviceType,
                                                  currentRoomId: controller
                                                      .deviceListItem
                                                      .value
                                                      .roomId!);
                                        });
                                  } else {
                                    //UnBlock
                                    Dialogs.showDialogWithTwoButtonsMsg(
                                        context: context,
                                        title: 'Unblock Device',
                                        subtitle:
                                            'Are you sure you want to unblock this device?',
                                        button1Func: () {
                                          Get.back();
                                        },
                                        button2Func: () {
                                          Get.back();

                                          controller
                                              .dashboardController
                                              .blockDevice(
                                                  setDeviceBlockParam: controller
                                                      .dashboardController
                                                      .fillUnBlockDevice(
                                                          deviceId: controller
                                                              .deviceListItem
                                                              .value
                                                              .id!),
                                                  type:
                                                      controller
                                                          .dashboardController
                                                          .blockDeviceType,
                                                  currentRoomId: controller
                                                      .deviceListItem
                                                      .value
                                                      .roomId!);
                                        });
                                  }
                                },
                                buttonColor: AppColors.yellow,
                                buttonText:
                                    (controller.deviceListItem.value.block ==
                                            'disable')
                                        ? 'Block Device'
                                        : 'Unblock Device',
                                svgPath: Assets.svgs.blockDevice,
                                svgColor: AppColors.yellow),
                            OutlinedAppButton.icon(
                                onPressed: () {
                                  //Delete Device

                                  Dialogs.showDialogWithTwoButtonsMsg(
                                      context: context,
                                      title: 'Delete Device',
                                      subtitle:
                                          'Are you sure you want to delete this device?',
                                      button1Func: () {
                                        Get.back();
                                      },
                                      button2Func: () {
                                        Get.back();

                                        controller.dashboardController
                                            .deleteDevice(
                                                setDeleteDeviceParam: controller
                                                    .dashboardController
                                                    .fillDeleteDevice(
                                                        deviceId: controller
                                                            .deviceListItem
                                                            .value
                                                            .id!),
                                                type: controller.deviceType,
                                                currentRoomId: controller
                                                    .deviceListItem
                                                    .value
                                                    .roomId!)
                                            .then((value) {
                                          if (value != null) {
                                            Get.back();

                                            constants.showSnackbar(
                                                'Device Status',
                                                'Successfully deleted device',
                                                1);
                                          }
                                        });
                                      });
                                },
                                buttonColor: AppColors.red,
                                buttonText: 'Delete Device',
                                svgPath: Assets.svgs.deleteRed,
                                svgColor: AppColors.red),
                          ],
                        ],
                      ),
                    ),
                  if (controller.dashboardController.allDevicesList.isEmpty)
                    Container(
                      width: Get.width,
                      margin: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('There are no connected devices'),
                      ),
                    ),
                  if (controller.dashboardController.showLoader.value)
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
              ),
            ),
          ),
        );
      }),
    );
  }
}
