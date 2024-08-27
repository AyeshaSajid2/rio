import 'package:get/get.dart';

import '../controllers/forgot_router_password_controller.dart';

class ForgotRouterPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotRouterPasswordController>(
      () => ForgotRouterPasswordController(),
    );
  }
}
