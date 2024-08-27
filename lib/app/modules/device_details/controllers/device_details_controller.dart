import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/extensions/imports.dart';
import '../../../data/models/device/get_device_list_model.dart';
import '../../dashboard/controllers/dashboard_controller.dart';

class DeviceDetailsController extends GetxController {
  // late Map args;
  // late DeviceListItem deviceListItem;
  late Rx<DeviceListItem> deviceListItem;
  late String deviceType;
  RxString pageTitle = ''.obs;

  DashboardController dashboardController = Get.find<DashboardController>();

  final labelDeviceEC = TextEditingController();
  final GlobalKey<FormState> deviceLabelKey = GlobalKey<FormState>();
  String deviceName = '';
  bool isDeviceAdministrator = false;

  RxBool showMoveToOtherRoomButton = false.obs;

  double pageHeight = 420;

  @override
  void onInit() {
    // args = Get.arguments;

    deviceListItem = dashboardController.selectedDeviceListItem;
    deviceType = dashboardController.selectedDeviceType;
    isDeviceAdministrator = dashboardController.isSelectedDeviceAdministrator;
    // deviceListItem = args['DeviceListItem'];
    // deviceType = args['DeviceType'];
    // isDeviceAdministrator = args['isDeviceAdministrator'];
    setPageHeightWithRefresh();

    super.onInit();
  }

  @override
  void onReady() {
    setDeviceName();

    super.onReady();
  }

  @override
  void onClose() {
    labelDeviceEC.dispose();
    super.onClose();
  }

  setPageHeightWithRefresh() {
    if (deviceListItem.value.ssidId != '' &&
        // deviceListItem.value.ssidId != '0' &&
        deviceListItem.value.role != 'admin' &&
        !isDeviceAdministrator) {
      //MoveToOtherRoom
      pageHeight = pageHeight + 55;
    }
    if (isDeviceAdministrator &&
        deviceListItem.value.role == 'manager' &&
        deviceListItem.value.ssidId == '0' &&
        deviceListItem.value.block == 'disable') {
      //Set Role to Admin
      pageHeight = pageHeight + 55;
    }
    if ((deviceListItem.value.roomId!.isNotEmpty &&
        deviceListItem.value.role! != 'admin')) {
      //Block & Delete Buttons
      pageHeight = pageHeight + (55 * 2);
    }
  }

  setDeviceName() {
    if (deviceListItem.value.labelEncode != null &&
        deviceListItem.value.labelEncode!.isNotEmpty) {
      deviceName =
          utf8.decode(base64.decode(deviceListItem.value.labelEncode!));

      pageTitle.value = deviceName;
      labelDeviceEC.text = deviceName;
    } else {
      deviceName = deviceListItem.value.name ?? '';

      pageTitle.value = deviceName;
      labelDeviceEC.text = deviceName;
    }
  }
}
