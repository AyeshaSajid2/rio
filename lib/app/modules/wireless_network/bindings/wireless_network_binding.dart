import 'package:get/get.dart';

import '../controllers/wireless_network_controller.dart';

class WirelessNetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WirelessNetworkController>(
      () => WirelessNetworkController(),
    );
  }
}
