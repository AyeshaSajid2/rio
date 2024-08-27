import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usama/app/modules/wifi_onboarding/controllers/wifi_onboarding_controller.dart';
import 'package:usama/app/modules/wifi_onboarding/views/connection_timer_view.dart';
import 'package:usama/core/components/widgets/filled_round_button.dart';
import 'package:usama/core/components/widgets/outlined_app_button.dart';
import 'package:usama/core/theme/colors.dart';

class SsidGuideView extends GetView<WifiOnBoardingController> {
  const SsidGuideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
            child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: EdgeInsets.only(
                      top: Get.height * 0.1,
                    ),
                    child: const Text(
                      'WiFi Network Onboarding:\nUsing Existing SSID',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: Get.height * 0.05, left: 36, right: 36),
                  child: const Text(
                    'If  you plan to continue using the existing router alongside your Rio, Please disable SSID in the existing router. After this setup is  complete you may re-enable the SSID in the existing router.\n\n'
                    'This way, your devices will be able to connect to either of the routers, but you may not be sure which router your device is connecting to.\n\n'
                    'Additionally,  you have the option to change the SSID in the existing router you may do so.\tIf you decide not to keep the existing router, you can turn it off.',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: Get.height * 0.07),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                    width: Get.width * 0.45,
                    child: const OutlinedAppButton(
                      onPressed: null,
                      buttonText: 'Skip',
                      buttonColor: AppColors.inActiveColor,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.45,
                    child: FilledRoundButton(
                        onPressed: () {
                          Get.to(const ConnectionTimerView());
                        },
                        buttonText: 'Confirm'),
                  ),
                ]),
              ]),
        )),
      ),
    ));
  }
}
