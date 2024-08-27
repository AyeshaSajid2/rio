import 'package:get/get.dart';

import '../controllers/secure_room_controller.dart';

class SecureRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SecureRoomController>(
      () => SecureRoomController(),
    );
  }
}
