import 'package:get/get.dart';
import 'package:usama/app/modules/wifi_onboarding/controllers/wifi_onboarding_controller.dart';

class WifiOnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WifiOnBoardingController>(() => WifiOnBoardingController());
  }
}
