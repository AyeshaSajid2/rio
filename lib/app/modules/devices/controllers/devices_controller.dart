import 'package:get/get.dart';

import '../../../data/models/device/get_device_list_model.dart';
import '../../dashboard/controllers/dashboard_controller.dart';

class DevicesController extends GetxController {
  DashboardController dashboardController = Get.find<DashboardController>();

  RxList<DeviceListItem> deviceList = <DeviceListItem>[].obs;
  String pageTitle = 'Devices';

  RxBool isDeviceAdministrator = false.obs;

  late final String deviceType;
  String roomId = '';

  late Map args;

  @override
  void onInit() {
    args = Get.arguments;
    pageTitle = args['pageTitle'];
    deviceType = args['deviceType'];
    if (args['RoomId'] != null) {
      roomId = args['RoomId'];
      dashboardController.selectedDeviceListItem.value =
          DeviceListItem(roomId: roomId);
    }

    super.onInit();
  }

  @override
  void onReady() {
    //
    setDeviceListValues();
    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }

  void setDeviceListValues() async {
    isDeviceAdministrator.value = false;

    await dashboardController.getAllDevices();
    if (deviceType == dashboardController.allDeviceType) {
      if (pageTitle == 'Device Administration') {
        isDeviceAdministrator.value = true;
      }
      deviceList = dashboardController.allDevicesList;
    } else if (deviceType == dashboardController.waitDeviceType) {
      deviceList = dashboardController.waitingDevicesList;
    } else if (deviceType == dashboardController.blockDeviceType) {
      deviceList = dashboardController.blockedDevicesList;
    } else if (deviceType == dashboardController.roomDeviceType) {
      deviceList = dashboardController.roomsDevicesList;
      // dashboardController.addRoomsDevicesInLists(roomId);
    }
  }
}
