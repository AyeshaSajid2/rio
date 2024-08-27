import 'package:get/get.dart';

import '../controllers/change_admin_password_controller.dart';

class ChangeAdminPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeAdminPasswordController>(
      () => ChangeAdminPasswordController(),
    );
  }
}
