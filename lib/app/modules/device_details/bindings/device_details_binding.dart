import 'package:get/get.dart';

import '../controllers/device_details_controller.dart';

class DeviceDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeviceDetailsController>(
      () => DeviceDetailsController(),
    );
  }
}
