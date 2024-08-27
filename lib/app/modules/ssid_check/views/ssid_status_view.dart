import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usama/app/modules/ssid_check/controllers/ssid_check_controller.dart';
import 'package:usama/app/modules/wifi_onboarding/views/wifi_onboarding_view.dart';
import 'package:usama/core/components/widgets/filled_round_button.dart';
import 'package:usama/core/components/widgets/outlined_app_button.dart';
import 'package:usama/core/theme/colors.dart';

class SsidStatusView extends GetView<SsidCheckController> {
  const SsidStatusView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        // appBar: const NewRioAppBar(
        //   titleText: '',
        //   backOn: true,
        // ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: SizedBox(
                    // height: Get.height,
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                )),
            // SizedBox(height: Get.height * 0.1),
            Padding(
                padding: EdgeInsets.only(top: Get.height * 0.1, bottom: 20.0),
                child: Image.asset('assets/images/question.png')),
            const Padding(
                padding: EdgeInsets.only(bottom: 16.0, left: 36, right: 36),
                child: Text(
                  'Do you plan to use\nthe same SSID name\nand Password?',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                )),
            SizedBox(height: Get.height * 0.02),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: Get.width * 0.5,
                child: const OutlinedAppButton(
                  onPressed: null,
                  buttonText: 'No',
                  buttonColor: AppColors.red,
                ),
              ),
              SizedBox(
                width: Get.width * 0.5,
                child: FilledRoundButton(
                    onPressed: () {
                      Get.to(
                        () => const WifiOnboardingView(),
                      );
                    },
                    buttonText: 'Yes'),
              )
            ]),
            SizedBox(height: Get.height * 0.02),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
              child: const Text.rich(
                textAlign: TextAlign.left,
                TextSpan(children: [
                  TextSpan(
                      text: 'Note:  ',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          'If you choose to use the same SSID and\npassword, all connected devices  will be\nautomatically allowed into the \'Rio-Home\' SecureRoom (VLAN) and  connect to Rio. There is no need to change the password of your devices;  it makes your onboarding a breeze.\n\n'
                          'Unfortunately,  if there\'s already a rogue device connected to your existing router, it  will also be added to Rio. We will be able to block those devices in Rio.\n\n '
                          'Devices not currently online or connected to your Wi-Fi won\'t be included.  However, once the setup process is complete, all other devices\n'
                          '—even  those with the proper password\n'
                          '—trying to connect to your Rio will need  your approval. You don\'t need to worry about your WiFi password being  shared with many people.\n\n'
                          'After  the setup, you\'ll be able to review all the devices in the \'Rio-Home\'  SecureRoom. From there, you can either block any device or reassign it  to other SecureRooms (VLANs).\n'
                          '',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400))
                ]),
              ),
            ),
          ],
        )))));
  }
}
