import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/components/widgets/pinput_text_field.dart';
import '../../../../core/extensions/imports.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/app_pages.dart';
import '../controllers/mobile_no_verify_controller.dart';

class MobileVerifyView extends GetView<MobileNoVerifyController> {
  const MobileVerifyView({super.key});
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
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
        child: SafeArea(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8.0,
                      top: 24,
                    ),
                    child: SvgPicture.asset(
                      Assets.svgs.logo,
                      width: Get.width * 0.15,
                      height: Get.width * 0.15,
                    ),
                  ),
                  const Text(
                    'Mobile Verification',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'A verification code has been\n sent to your Mobile \n\n${controller.completeMobileNo}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.03),
                  const Text(
                    'Please enter the verification code',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: controller.mobileVerifyKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Center(
                                  child: FilledRoundedPinPut(
                                controller: controller.mobileOtpTextCtrl,
                                validator: (value) {
                                  if (value != null) {
                                    if (value.length > 5) {
                                      return null;
                                    } else {
                                      return 'Enter Complete Code';
                                    }
                                  } else {
                                    return 'Enter Code';
                                  }
                                },
                              )),
                            ),
                            SizedBox(height: Get.height * 0.05),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Didn’t receive code? ',
                                  style: textTheme.bodyLarge!
                                      .copyWith(color: AppColors.appBlack),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.resend();
                                  },
                                  child: Text(
                                    'Resend',
                                    style: textTheme.bodyLarge!.copyWith(
                                        color: AppColors.primary,
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.primary),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.05),
                        Column(
                          children: [
                            FilledRoundButton(
                                onPressed: () {
                                  if (controller.mobileVerifyKey.currentState!
                                      .validate()) {
                                    constants.dismissKeyboard(context);

                                    controller.verifyCode();
                                  }
                                },
                                buttonText: 'Verify Code'),
                            SizedBox(height: Get.height * 0.08),
                          ],
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
