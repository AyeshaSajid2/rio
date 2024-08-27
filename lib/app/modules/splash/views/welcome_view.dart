import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:usama/app/modules/splash/views/welcome_Info_view.dart';
import 'package:usama/core/theme/colors.dart';

import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/splash_controller.dart';

class WelcomeView extends GetView<SplashController> {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle headingTS = TextStyle(
      fontWeight: FontWeight.w500,
      color: AppColors.black,
      fontSize: 17,
    );
    // const TextStyle bodyTS = TextStyle(
    //   fontWeight: FontWeight.w300,
    //   color: AppColors.textGrey,
    //   fontSize: 13,
    // );
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              controller.showLoader.value
                  ? Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: Get.height * 0.1),
                            child: SvgPicture.asset(
                              Assets.svgs.logo,
                              width: Get.width * 0.15,
                              height: Get.width * 0.15,
                            ),
                          ),
                          const Text(
                            'Welcome to Rio',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          Expanded(
                              flex: 3,
                              child: Lottie.asset(Assets.animations.loading)),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Text(
                                    'Getting Ready...',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                    textAlign: TextAlign.center,
                                  ),
                                  if (controller.isWifiConnected.value &&
                                      controller.wifiName!.value != 'null') ...[
                                    Text(
                                      'Connected to ${controller.wifiName!.value}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.center,
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.15,
                            width: Get.width,
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: Container(
                        // height: Get.height * 0.8,
                        width: Get.width,
                        color: AppColors.background,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: Get.height * 0.25),
                              child: SvgPicture.asset(
                                Assets.svgs.logo,
                                width: Get.width * 0.15,
                                height: Get.width * 0.15,
                              ),
                            ),
                            const Text(
                              'Welcome to Rio',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(36.0),
                              child: Text(
                                'Complete home internet protection is just around the corner.',
                                style: headingTS,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const Spacer(),
                            FilledRoundButton(
                              onPressed: () {
                                Get.to(() => const WelcomeInfoView());
                                // Get.toNamed(Routes.ONBOARDING);
                              },
                              buttonText: 'NEXT',
                            ),
                            SizedBox(height: Get.height * 0.04),
                          ],
                        ),
                      ),
                    ),
            ],
          );
        }),
      ),
    );
  }
}
