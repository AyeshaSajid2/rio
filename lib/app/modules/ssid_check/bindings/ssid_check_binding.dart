import 'package:get/get.dart';
import 'package:usama/app/modules/ssid_check/controllers/ssid_check_controller.dart';

class SsidCheckBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SsidCheckController>(
      () => SsidCheckController(),
    );
  }
}
