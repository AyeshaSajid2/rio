import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usama/app/modules/router_setup/views/router_ready_view.dart';
import 'package:usama/app/modules/ssid_check/controllers/ssid_check_controller.dart';
import 'package:usama/app/modules/ssid_check/views/ssid_status_view.dart';
import 'package:usama/core/components/widgets/filled_round_button.dart';
import 'package:usama/core/components/widgets/outlined_app_button.dart';
import 'package:usama/core/theme/colors.dart';

class ExistingRouterInquiryView extends GetView<SsidCheckController> {
  const ExistingRouterInquiryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: AppColors.white,
        // appBar: const NewRioAppBar(
        //   titleText: '',
        //   backOn: true,
        // ),
        body: SafeArea(
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
            ),
          ),
          // SizedBox(height: Get.height * 0.1),
          Padding(
              padding: EdgeInsets.only(top: Get.height * 0.13, bottom: 25.0),
              child: Image.asset('assets/images/question.png')),
          // SizedBox(height: Get.height * 0.9),
          const Padding(
              padding: EdgeInsets.only(bottom: 16.0, left: 36, right: 36),
              child: Text(
                'Do you have any\nexisting router?',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              )),
          SizedBox(height: Get.height * 0.02),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              width: Get.width * 0.4,
              child: OutlinedAppButton(
                onPressed: () {
                  Get.to(() => const RouterReadyView());
                },
                buttonText: 'No',
                buttonColor: AppColors.red,
              ),
            ),
            SizedBox(
              width: Get.width * 0.4,
              child: FilledRoundButton(
                onPressed: () {
                  Get.to(() => const SsidStatusView());
                },
                buttonText: 'Yes',
              ),
            )
          ])
        ])));
  }
}
