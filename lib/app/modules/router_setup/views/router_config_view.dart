import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:usama/app/modules/ssid_check/views/exting_router_inquiry_view.dart';
import 'package:usama/core/theme/colors.dart';

import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/router_setup_controller.dart';

class RouterConfigView extends GetView<RouterSetupController> {
  const RouterConfigView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            // height: Get.height,
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: Get.height * 0.1,
                      ),
                      child: SvgPicture.asset(
                        Assets.svgs.logo,
                        width: Get.width * 0.15,
                        height: Get.width * 0.15,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        'Hang Tight!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(bottom: 16.0, left: 36, right: 36),
                      child: Text(
                        'Your wireless and SecureRoom settings are being updated in the Rio.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.1),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Obx(() {
                        return Column(
                          children: [
                            Center(
                                child: Text(
                              '${controller.percentageIndicator.value}%',
                              style: const TextStyle(
                                fontSize: 18,
                                color: AppColors.red,
                              ),
                            )),
                            LinearPercentIndicator(
                              lineHeight: 14.0,
                              percent:
                                  controller.percentageIndicator.value / 100,
                              barRadius: const Radius.circular(20),
                              backgroundColor: AppColors.grey,
                              progressColor: AppColors.red,
                              animation: true,
                              animateFromLastPercent: true,
                            ),
                          ],
                        );
                      }),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(bottom: 16.0, left: 36, right: 36),
                      child: Text(
                        'This may take several minutes. Please do not close the Mobile App / do not power off/ disconnect the Router.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.1),
                Obx(() {
                  return FilledRoundButton(
                    onPressed: controller.percentageIndicator.value != 100
                        ? null
                        : () {
                            Get.to(() => const ExistingRouterInquiryView());
                          },
                    buttonText: 'Continue',
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
