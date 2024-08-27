import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/components/widgets/app_text_field.dart';
import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/components/widgets/pinput_text_field.dart';
import '../../../../core/extensions/imports.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';

import '../../../routes/app_pages.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});
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
                      // bottom: 42.0,
                      top: 24,
                    ),
                    child: SvgPicture.asset(
                      Assets.svgs.logo,
                      width: Get.width * 0.15,
                      height: Get.width * 0.15,
                    ),
                  ),
                  const Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Obx(() {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Form(
                    key: controller.resetPasswordKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 16, left: 32, right: 32),
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller
                                                  .attributeResponseModel
                                                  .codeDeliveryDetails!
                                                  .deliveryMedium ==
                                              'SMS'
                                          ? 'Check your Mobile Phone ${controller.attributeResponseModel.codeDeliveryDetails!.destination} for verification code'
                                          : 'Check your Email ${controller.attributeResponseModel.codeDeliveryDetails!.destination} for verification code',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Please enter the verification code',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Center(
                                    child: FilledRoundedPinPut(
                                  controller: controller.otpTextCtrl,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Didn’t receive code? ',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.appBlack,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Get.toNamed(Routes.SIGN_UP);
                                      controller.forgotPassword(
                                          controller.fillForgotPassword());
                                    },
                                    child: const Text(
                                      'Resend',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                          color: AppColors.primary,
                                          decoration: TextDecoration.underline,
                                          decorationColor: AppColors.primary),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Get.height * 0.05),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 16.0, top: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'New Password',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textGrey),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: AppTextField(
                                        controller: controller.passwordTextCtrl,
                                        obscureText:
                                            !controller.showPassword.value,
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
                                          } else if (value.length < 8) {
                                            return 'Password must be at least 8 characters long';
                                          } else if (RegExp(
                                                  r'[!@#$%^&*()-_=+[]{}|;:",.<>/\\?]')
                                              .hasMatch(value)) {
                                            return 'Password must have symbol characters';
                                          } else if (!value.contains(
                                              RegExp(r'[A-Z][a-z]'))) {
                                            return 'Password must have a lower and an upper case character';
                                          } else if (!value
                                              .contains(RegExp(r'[0-9]'))) {
                                            return 'Password must have numeric characters';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Confirm Password',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textGrey),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: AppTextField(
                                      controller:
                                          controller.confirmPasswordTextCtrl,
                                      obscureText:
                                          !controller.showConfirmPassword.value,
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          controller.showConfirmPassword.value =
                                              !controller
                                                  .showConfirmPassword.value;
                                        },
                                        child: Icon(controller
                                                .showConfirmPassword.value
                                            ? Icons.visibility_off_outlined
                                            : Icons.remove_red_eye_outlined),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Confirm Password';
                                        } else if (value !=
                                            controller.passwordTextCtrl.text) {
                                          return 'Mismatch Password';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.05),
                          Column(
                            children: [
                              controller.showLoader.value
                                  ? SizedBox(
                                      height: Get.height * 0.1,
                                      child: Lottie.asset(
                                          Assets.animations.loading))
                                  : FilledRoundButton(
                                      onPressed: () {
                                        if (controller
                                            .resetPasswordKey.currentState!
                                            .validate()) {
                                          controller.verifyForgotPassword(controller
                                              .fillForgotPasswordVerification());

                                          // Get.to(() =>
                                          //     const PasswordChangedView());
                                        }
                                      },
                                      buttonText: 'Submit'),
                              SizedBox(height: Get.height * 0.08),
                            ],
                          ),
                        ]),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
