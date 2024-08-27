import 'package:get/get.dart';

import '../controllers/router_password_change_controller.dart';

class RouterPasswordChangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RouterPasswordChangeController>(
      () => RouterPasswordChangeController(),
    );
  }
}
