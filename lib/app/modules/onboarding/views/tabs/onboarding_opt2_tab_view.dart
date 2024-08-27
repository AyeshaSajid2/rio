import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/components/widgets/app_text_field.dart';
import '../../../../../core/components/widgets/filled_round_button.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../gen/assets.gen.dart';
import '../../controllers/onboarding_controller.dart';

class OnboardingOption2TabView extends GetView<OnboardingController> {
  const OnboardingOption2TabView({super.key});
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
                // const Text(
                //   'Join the Rio WiFi manually',
                //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                //   // textAlign: TextAlign.center,
                // ),
                // SizedBox(height: Get.height * 0.01),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 24,
                            child: Text(
                              '1.',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300),
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                  text: 'Locate ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'RIO-ROUTER',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          ' with the SSID shown on the sticker at the bottom of the Rio router and Enter it below',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ]),
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
                              '2.',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Password also shown at the bottom of the Rio router. \n(Please do not use the Password associated with the USER NAME Admin.)',
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
                      // height: Get.height * 0.11,
                    ),
                  ),
                ),
                Obx(() {
                  return Form(
                    key: controller.connectKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!controller.isWifiConnected.value) ...[
                          SizedBox(height: Get.height * 0.02),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 16.0, left: 16, right: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SSID',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black.withOpacity(0.5)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: AppTextField(
                                    controller: controller.ssidTEC,
                                    obscureText: false,
                                    keyboardType: TextInputType.text,
                                    hintText: 'Enter SSID',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter SSID';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Password',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            AppColors.black.withOpacity(0.5)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: AppTextField(
                                      controller: controller.passwordTEC,
                                      obscureText:
                                          !controller.showPassword.value,
                                      hintText: 'Password',
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          controller.showPassword.value =
                                              !controller.showPassword.value;
                                        },
                                        child: Icon(controller
                                                .showPassword.value
                                            ? Icons.visibility_off_outlined
                                            : Icons.remove_red_eye_outlined),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Password';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ]),
                          ),
                          SizedBox(height: Get.height * 0.02),
                          FilledRoundButton(
                            onPressed: () {
                              if (controller.connectKey.currentState!
                                  .validate()) {
                                controller.connectToWifiNetwork(
                                    controller.ssidTEC.text,
                                    controller.passwordTEC.text);
                              }
                            },
                            buttonText: 'Connect to WiFi',
                            buttonColor: AppColors.primary,
                          ),
                        ] else ...[
                          Column(
                            children: [
                              Lottie.asset(Assets.animations.loading),
                              const SizedBox(height: 8),
                              const Text(
                                'Connecting to WiFi Router',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  );
                }),

                SizedBox(height: Get.height * 0.08),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
