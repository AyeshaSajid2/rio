import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usama/app/modules/wifi_onboarding/bindings/wifi_onboarding_binding.dart';
import 'package:usama/app/modules/wifi_onboarding/controllers/wifi_onboarding_controller.dart';
import 'package:usama/app/modules/wifi_onboarding/views/ssid_guide_view.dart';
import 'package:usama/core/components/widgets/app_text_field.dart';
import 'package:usama/core/components/widgets/filled_round_button.dart';
import 'package:usama/core/theme/colors.dart';

class WifiOnboardingView extends GetView<WifiOnBoardingController> {
  const WifiOnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    WifiOnboardingBinding().dependencies();

    // final WifiOnoardingController controller = Get.find();

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
                  padding: EdgeInsets.only(top: Get.height * 0.1),
                  child: const Text(
                    'Enter your existing router SSID and\nPassword',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
                Form(
                  key: controller.signInKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 16.0, left: 20, right: 20),
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
                                    controller: controller.emailTextCtrl,
                                    obscureText: false,
                                    keyboardType: TextInputType.emailAddress,
                                    // hintText: 'Email Address',
                                    // prefixIcon: const Icon(Icons.mail_outline),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter email address';
                                      } else if (!value.isEmail) {
                                        return 'Please enter a valid email address';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.015),
                                Column(
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
                                        controller: controller.passwordTextCtrl,
                                        obscureText:
                                            !controller.showPassword.value,
                                        // hintText: 'Password',
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
                                  ],
                                ),
                              ]),
                        ),
                      ]),
                ),
                FilledRoundButton(
                    onPressed: () {
                      Get.to(const SsidGuideView());
                    },
                    buttonText: 'Next'),
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'chat bot',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      SizedBox(
                        width: Get.width * 0.15,
                      )
                    ],
                  ),
                )
              ]),
        )),
      ),
    ));
  }
}
