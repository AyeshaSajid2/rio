import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:usama/core/theme/colors.dart';

import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/app_pages.dart';
import '../controllers/progress_controller.dart';

class ProgressView extends GetView<ProgressController> {
  const ProgressView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Scrollbar(
          thumbVisibility: true,
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        controller.isRebootActivated
                            ? 'Rebooting..'
                            : 'Resetting the Router..',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 16.0, left: 36, right: 36),
                      child: Text(
                        controller.isRebootActivated
                            ? 'Your connection to the router has been lost. Don\'t worry, it happens after a reboot. Please reconnect to the router to resume using the app. Once you\'re reconnected, you can simply tap \'Go Back to Dashboard\' to return to your home screen. Thank you for your patience!'
                            : 'Your router has been reset to its default factory settings. This means your previous configurations have been erased, and you will need to set up your connection again.\n\nTo get back online, please reconnect to the router and go through the setup process. If you need assistance, refer to the user manual or contact our support team.',
                        style: const TextStyle(
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
                    SizedBox(height: Get.height * 0.025),
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
                SizedBox(height: Get.height * 0.05),
                Obx(() {
                  return FilledRoundButton(
                    onPressed: controller.percentageIndicator.value != 100
                        ? null
                        : () {
                            controller.isRebootActivated
                                ? Get.offAllNamed(Routes.SIGN_IN)
                                : Get.offAllNamed(Routes.SPLASH);
                          },
                    buttonText: 'Login Now',
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
