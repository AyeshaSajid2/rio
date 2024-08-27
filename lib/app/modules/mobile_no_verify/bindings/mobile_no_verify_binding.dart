import 'package:get/get.dart';

import '../controllers/mobile_no_verify_controller.dart';

class MobileNoVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MobileNoVerifyController>(
      () => MobileNoVerifyController(),
    );
  }
}
