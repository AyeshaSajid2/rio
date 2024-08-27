import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/components/widgets/mobile_field/mobile_field.dart';
import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/extensions/imports.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/app_pages.dart';
import '../controllers/mobile_no_verify_controller.dart';

class MobileNoVerifyView extends GetView<MobileNoVerifyController> {
  const MobileNoVerifyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const RioAppBar(
        titleText: 'Mobile Number Verification',
      ),
      floatingActionButton: constants.isKeyboardOpened()
          ? null
          : FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Get.toNamed(Routes.CUSTOMER_SUPPORT);
              },
              child: const Icon(Icons.support_agent, color: AppColors.white),
            ),
      body: SingleChildScrollView(
        child: Obx(() {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: controller.mobileNoVerifyKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: AppColors.red.withOpacity(0.1),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   'ALERT',
                            //   style: TextStyle(
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.w500,
                            //       color: AppColors.red),
                            // ),
                            Text(
                              'For security reasons, we recommend configuring a mobile phone number for password recovery. This phone number can be used to reset your password in case you forget it.',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.025),
                      const Center(
                        child: Text(
                          'We will send you a code on your mobile number for verification',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.05),
                      Padding(
                        padding: const EdgeInsets.only(
                          // top: 16.0,
                          bottom: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mobile Number',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black.withOpacity(0.5)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: IntlPhoneField(
                                controller: controller.mobileTextCtrl,
                                dropdownIconPosition: IconPosition.trailing,
                                // disableLengthCheck: true,
                                decoration: const InputDecoration(
                                    // labelText: mobileNumberTEXT,
                                    // labelStyle: labelTextStyle,
                                    hintText: 'xxxxxxxxxx',
                                    border: OutlineInputBorder()),
                                // initialCountryCode: selectedCountry.code,
                                onTapOutside: (p0) {
                                  constants.dismissKeyboard(context);
                                },
                                validator: (phone) {
                                  if (phone != null) {
                                    controller.completeMobileNo =
                                        phone.completeNumber;

                                    return null;
                                  } else {
                                    return 'Please Enter Mobile Number';
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.1),
                      FilledRoundButton(
                        onPressed: () {
                          if (controller.mobileNoVerifyKey.currentState!
                              .validate()) {
                            controller.submit();
                          }
                        },
                        buttonText: 'Submit',
                        padding: const EdgeInsets.symmetric(vertical: 4),
                      ),
                      SizedBox(height: Get.height * 0.08),
                    ],
                  ),
                ),
              ),
              if (controller.showLoader.value)
                Positioned(
                  child: SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: ColoredBox(
                      color: Colors.black.withOpacity(0.5),
                      child: Lottie.asset(Assets.animations.loading),
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
