import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../../core/components/widgets/filled_round_button.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/onboarding_controller.dart';

class WaitingScreenView extends GetView<OnboardingController> {
  const WaitingScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.1),
                    child: SvgPicture.asset(
                      Assets.svgs.logo,
                      width: Get.width * 0.15,
                      height: Get.width * 0.15,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'Router is getting ready..',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16.0, left: 36, right: 36),
                    child: Text(
                      'Please wait for about a minute while router is setting it up',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Obx(() {
                      return Column(
                        children: [
                          Center(
                              child: Text(
                            '${controller.percentageIndicator.value.roundToDouble()}%',
                            style: const TextStyle(
                              fontSize: 18,
                              color: AppColors.red,
                            ),
                          )),
                          LinearPercentIndicator(
                            lineHeight: 14.0,
                            percent: controller.percentageIndicator.value / 100,
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
                  SizedBox(height: Get.height * 0.025),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16.0, left: 36, right: 36),
                    child: Text(
                      'This will take about a minute. Just hold on',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.05),
              Obx(() {
                return FilledRoundButton(
                  onPressed: controller.percentageIndicator.value != 100
                      ? null
                      : () {
                          Get.offNamed(Routes.ADMIN_LOGIN);
                        },
                  buttonText: 'Next',
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
