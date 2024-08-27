import 'package:get/get.dart';

import '../controllers/add_wireless_network_controller.dart';

class AddWirelessNetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddWirelessNetworkController>(
      () => AddWirelessNetworkController(),
    );
  }
}
