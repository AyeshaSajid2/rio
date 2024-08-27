import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/components/widgets/app_text_field.dart';
import '../../../../core/utils/helpers/common_func.dart';
import '../../../routes/app_pages.dart';

import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});
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
          child: Obx(() {
            return Stack(
              children: [
                Column(
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
                            Assets.svgs.logo,
                            width: Get.width * 0.15,
                            height: Get.width * 0.15,
                          ),
                        ),
                        const Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Form(
                            key: controller.signInKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Email',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black
                                                  .withOpacity(0.5)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: AppTextField(
                                            controller:
                                                controller.emailTextCtrl,
                                            obscureText: false,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            hintText: 'Email Address',
                                            // prefixIcon: const Icon(Icons.mail_outline),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter email address';
                                              } else if (!value.isEmail) {
                                                return 'Please enter a valid email address';
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Password',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.black
                                                .withOpacity(0.5)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: AppTextField(
                                          controller:
                                              controller.passwordTextCtrl,
                                          obscureText:
                                              !controller.showPassword.value,
                                          hintText: 'Password',
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              controller.showPassword.value =
                                                  !controller
                                                      .showPassword.value;
                                            },
                                            child: Icon(controller
                                                    .showPassword.value
                                                ? Icons.visibility_off_outlined
                                                : Icons
                                                    .remove_red_eye_outlined),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please Enter Password';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.025,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(Routes.FORGOT_PASSWORD);
                                        },
                                        child: Text(
                                          'Forgot Password?',
                                          style: textTheme.bodyLarge!.copyWith(
                                              color: AppColors.primary,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  AppColors.primary),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  FilledRoundButton(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      onPressed: () {
                                        if (controller.signInKey.currentState!
                                            .validate()) {
                                          controller.postSignIn(
                                              controller.fillSignIn());
                                        }
                                      },
                                      buttonText: 'Sign In'),
                                  SizedBox(height: Get.height * 0.025),
                                ]),
                          ),
                          Column(
                            children: [
                              Center(
                                child: FittedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Don’t have an account? ',
                                        style: textTheme.bodyLarge!.copyWith(
                                            color: AppColors.appBlack),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.offAndToNamed(Routes.SIGN_UP);
                                        },
                                        child: Text(
                                          'Sign Up',
                                          style: textTheme.bodyLarge!.copyWith(
                                              color: AppColors.primary,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  AppColors.primary),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height * 0.08),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
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
      ),
    );
  }
}
