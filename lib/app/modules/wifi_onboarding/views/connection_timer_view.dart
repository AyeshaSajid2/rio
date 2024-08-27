import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usama/app/modules/wifi_onboarding/controllers/wifi_onboarding_controller.dart';
import 'package:usama/app/modules/wifi_onboarding/views/enable_router_view.dart';
import 'package:usama/core/components/widgets/filled_round_button.dart';
import 'package:usama/core/theme/colors.dart';

class ConnectionTimerView extends GetView<WifiOnBoardingController> {
  const ConnectionTimerView({super.key});

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
                      top: Get.height * 0.25,
                    ),
                    child: const Text(
                      'Waiting for the devices to\nconnect to Rio',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    )),
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.05),
                  child: const Text(
                    '02:56',
                    style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.w400,
                        color: AppColors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Get.height * 0.025, left: 36, right: 36),
                  child: const Text(
                    'After devices are connected, you will be able to review the connected devices in the Rio-Home SecureRoom and then add name, block or delete individual devices.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: Get.height * 0.05),
                FilledRoundButton(
                  onPressed: () {
                    Get.to(const EnableRouterView());
                  },
                  buttonText: 'Continue',
                  buttonColor: AppColors.continueButton,
                ),
              ]),
        )),
      ),
    ));
  }
}


// Center(
//         child: Obx(() {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Waiting for the devices to connect to Rio',
//                 style: TextStyle(fontSize: 20),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 '${controller.connectionTimerModal.value.countdown}',
//                 style: const TextStyle(fontSize: 48, color: Colors.red),
//               ),
//               const SizedBox(height: 20),
//               // ElevatedButton(
//               //   onPressed: controller.connectionTimerModal.value.isConnected
//               //       ? () {
//               //           // Navigate to the next screen or perform an action
//               //         }
//               //       : null,
//               //   child: const Text('Continue'),
//               // ),
//               FilledRectButton(
//                 onPressed: controller.connectionTimerModal.value.isConnected
//                     ? () {
//                         Get.to(const EnableRouterView());
//                       }
//                     : null,
//                 buttonText: 'Continue',
//                 buttonColor: AppColors.continueButton,
//               )
//             ],
//           );
//         }),
//       ),