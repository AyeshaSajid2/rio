import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usama/app/modules/router_setup/views/router_ready_view.dart';
import 'package:usama/app/modules/wifi_onboarding/controllers/wifi_onboarding_controller.dart';
import 'package:usama/core/components/widgets/filled_round_button.dart';

class EnableRouterView extends GetView<WifiOnBoardingController> {
  const EnableRouterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/router_image.png'),
          SizedBox(height: Get.height * 0.05),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: const Text(
              'You may now re-enable SSID in the existing router if you wish to continue both routers. ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(height: Get.height * 0.05),
          FilledRoundButton(
              onPressed: () {
                Get.to(() => const RouterReadyView());
              },
              buttonText: 'Next')
        ],
      )),
    ));
  }
}
