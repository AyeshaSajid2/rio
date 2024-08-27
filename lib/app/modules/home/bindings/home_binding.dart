import 'package:get/get.dart';
import 'package:usama/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:usama/app/modules/settings/controllers/settings_controller.dart';
import 'package:usama/app/modules/vpn/controllers/vpn_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      // () => HomeController(),
      HomeController(),
    );
    Get.put<DashboardController>(
      DashboardController(),
    );
    Get.put<VpnController>(
      VpnController(),
    );
    Get.put<SettingsController>(
      SettingsController(),
    );
  }
}
