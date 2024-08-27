import 'package:get/get.dart';

import '../controllers/vpn_controller.dart';

class VpnBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VpnController>(
      () => VpnController(),
    );
  }
}
