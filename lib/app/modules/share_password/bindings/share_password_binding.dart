import 'package:get/get.dart';

import '../controllers/share_password_controller.dart';

class SharePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SharePasswordController>(
      () => SharePasswordController(),
    );
  }
}
