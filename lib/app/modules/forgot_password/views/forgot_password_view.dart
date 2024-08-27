import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/components/widgets/app_text_field.dart';
import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/extensions/imports.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';

import '../../../routes/app_pages.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
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
                      bottom: 42.0,
                      top: 24,
                    ),
                    child: SvgPicture.asset(
                      Assets.svgs.logoWithName,
                      width: Get.width * 0.25,
                      height: Get.width * 0.08,
                    ),
                  ),
                  const Text(
                    'Forgot Password',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Don’t worry, it happens!\n Enter the email address associated with your account.',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.08),
              Container(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: controller.forgotPasswordKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: AppTextField(
                          controller: controller.emailTextCtrl,
                          obscureText: false,
                          hintText: 'Email Address',
                          // prefixIcon: const Icon(Icons.mail_outline),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Email Address';
                            } else if (!value.isEmail) {
                              return 'Please Enter a valid Email Address';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(height: Get.height * 0.25),
                      Obx(() {
                        return Column(
                          children: [
                            controller.showLoader.value
                                ? SizedBox(
                                    height: Get.height * 0.1,
                                    child:
                                        Lottie.asset(Assets.animations.loading))
                                : FilledRoundButton(
                                    onPressed: () {
                                      if (controller
                                          .forgotPasswordKey.currentState!
                                          .validate()) {
                                        controller.forgotPassword(
                                            controller.fillForgotPassword());
                                      }
                                    },
                                    buttonText: 'Submit'),
                            SizedBox(height: Get.height * 0.08),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
