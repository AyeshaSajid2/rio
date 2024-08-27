import 'package:get/get.dart';

import '../controllers/router_setup_controller.dart';

class RouterSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RouterSetupController>(
      () => RouterSetupController(),
    );
  }
}
