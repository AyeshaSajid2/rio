import 'package:get/get.dart';

import '../controllers/firmware_update_controller.dart';

class FirmwareUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirmwareUpdateController>(
      () => FirmwareUpdateController(),
    );
  }
}
