import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:open_settings_plus/open_settings_plus.dart';

import '../../../../../core/components/widgets/filled_round_button.dart';
import '../../../../../core/components/widgets/outlined_app_button.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/onboarding_controller.dart';

class OnboardingOption3TabView extends GetView<OnboardingController> {
  const OnboardingOption3TabView({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Join from Wireless Settings',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  // textAlign: TextAlign.center,
                ),
                SizedBox(height: Get.height * 0.01),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 24,
                            child: Text(
                              '1.',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300),
                              // textAlign: TextAlign.center,
                            ),
                          ),
                          RichText(
                            text: const TextSpan(
                                text: 'Open ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'SETTINGS',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' of your mobile app',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 24,
                            child: Text(
                              '2.',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300),
                            ),
                          ),
                          RichText(
                            text: const TextSpan(
                                text: 'Select WiFi from the ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'SETTINGS',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' Menu',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 24,
                            child: Text(
                              '3.',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300),
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                text:
                                    'Locate and select the Rio SSID shown on the sticker at the bottom of your router. Do not select the SSID that contains managed, shared, or guest next to the name.',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.black,
                                ),
                                // children: [
                                //   TextSpan(
                                //     text: 'RIO-ROUTER',
                                //     style: TextStyle(
                                //       fontSize: 14,
                                //       fontWeight: FontWeight.w700,
                                //       color: AppColors.black,
                                //     ),
                                //   ),
                                //   TextSpan(
                                //     text:
                                //         ' with the SSID shown on the sticker at the bottom of the Rio router',
                                //     style: TextStyle(
                                //       fontSize: 14,
                                //       fontWeight: FontWeight.w300,
                                //       color: AppColors.black,
                                //     ),
                                //   ),
                                // ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 24,
                            child: Text(
                              '4.',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'When prompt, enter the Password also shown at the bottom of the Rio router. \n(Please do not use the Password associated with the USER NAME Admin.)',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      Assets.images.routerStep3Manual.path,
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                OutlinedAppButton.icon(
                  onPressed: () {
                    if (Platform.isAndroid) {
                      const OpenSettingsPlusAndroid().wifi();
                    } else if (Platform.isIOS) {
                      const OpenSettingsPlusIOS().wifi();
                    }
                  },
                  buttonText: 'Open WiFi Settings',
                  svgPath: Assets.svgs.wifiSignals,
                  buttonColor: AppColors.appBlack,
                ),
                FilledRoundButton(
                  onPressed: () {
                    // if (asKeyStorage.getAsKeyDeviceToken() == '') {
                    //   Get.to(() => const WaitingScreenView());
                    //   controller.startTimer(1);
                    // } else {
                    //   Get.toNamed(Routes.ADMIN_LOGIN);
                    // }
                    Get.toNamed(Routes.ADMIN_LOGIN);
                  },
                  buttonText: 'Next',
                  buttonColor: AppColors.primary,
                ),
                SizedBox(height: Get.height * 0.08),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
