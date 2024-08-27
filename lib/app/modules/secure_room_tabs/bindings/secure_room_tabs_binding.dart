import 'package:get/get.dart';

import '../controllers/secure_room_tabs_controller.dart';

class SecureRoomTabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SecureRoomTabsController>(
      () => SecureRoomTabsController(),
    );
  }
}
