import 'package:get/get.dart';

import '../controllers/speed_test_controller.dart';

class SpeedTestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpeedTestController>(
      () => SpeedTestController(),
    );
  }
}
