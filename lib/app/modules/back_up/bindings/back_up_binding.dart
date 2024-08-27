import 'package:get/get.dart';

import '../controllers/back_up_controller.dart';

class BackUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BackUpController>(
      () => BackUpController(),
    );
  }
}
