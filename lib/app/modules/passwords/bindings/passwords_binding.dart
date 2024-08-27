import 'package:get/get.dart';

import '../controllers/passwords_controller.dart';

class PasswordsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PasswordsController>(
      () => PasswordsController(),
    );
  }
}
