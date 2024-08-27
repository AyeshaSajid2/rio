import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:usama/app/modules/sign_up/views/terms_and_service_view.dart';
import 'package:usama/core/extensions/imports.dart';
import '../../../../core/components/widgets/app_text_field.dart';

import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/app_pages.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});
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
                SizedBox(
                  // width: 280,
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
                            'Create account',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            child: Text(
                              'Create your personal Rio account so you can \nmanage your router preferences at any time.',
                              // 'Let\'s get to work.\n Your Rio will be up and running in minutes.\n Your WiFi will be SUPER secure.',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Form(
                              key: controller.signUpKey,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 16.0,
                                        bottom: 8,
                                      ),
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
                                              hintText: 'Email',
                                              keyboardType:
                                                  TextInputType.emailAddress,

                                              // prefixIcon: const Icon(Icons.mail_outline),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please Enter Email Address';
                                                } else if (!value.isEmail) {
                                                  return 'Please Enter a valid Email Address';
                                                } else {
                                                  return null;
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // SizedBox(height: Get.height * 0.025),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                        // top: 16.0,
                                        bottom: 8,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Enter Password',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.black
                                                        .withOpacity(0.5)),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Dialogs.showAlertDialogWithTitleContent(
                                                      titleText: 'Password Requirements',
                                                      bodyText:
                                                          // 'Minimum length 8 characters\nContains at least 1 number\nContains at least 1 special character\nContains at least 1 uppercase letter\nContains at least 1 lowercase letter');
                                                          // 'The password should be of length 8-16 and must contain lower-case letters, upper-case letters, digits, and special characters ~!@#%^*()_+');
                                                          'Password Length: 8-16 characters\nLower-Case letter: 1 minimum\nUpper-Case Letter: 1 minimum\nDigits: 1 minimum\nSpecial Characters: 1 minimum from these ~!@#%^*()_+');
                                                },
                                                child: const Column(
                                                  children: [
                                                    Text(
                                                      'Password Requirements',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          color:
                                                              AppColors.black),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            child: AppTextField(
                                              controller:
                                                  controller.passwordTextCtrl,
                                              obscureText: !controller
                                                  .showPassword.value,
                                              hintText: 'Password',
                                              suffixIcon: InkWell(
                                                onTap: () {
                                                  controller
                                                          .showPassword.value =
                                                      !controller
                                                          .showPassword.value;
                                                },
                                                child: Icon(controller
                                                        .showPassword.value
                                                    ? Icons
                                                        .visibility_off_outlined
                                                    : Icons
                                                        .remove_red_eye_outlined),
                                              ),
                                              // onTap: () {
                                              //   Dialogs.showAlertDialogWithTitleContent(
                                              //       titleText: 'Password Requirements',
                                              //       bodyText:
                                              //           // 'Minimum length 8 characters\nContains at least 1 number\nContains at least 1 special character\nContains at least 1 uppercase letter\nContains at least 1 lowercase letter');
                                              //           'The password should be of length 8-16 and must contain lower-case letters, upper-case letters, digits, and special characters ~!@#%^*()_+');
                                              // },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please Enter Password';
                                                } else if (!value.contains(RegExp(
                                                    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+-])[^\s]{8,16}$'))) {
                                                  return 'Password doesn\'t match requirements';
                                                }
                                                // // else if (RegExp(
                                                // //         r'[!@#$%^&*()-_=+[]{}|;:",.<>/\\?]')
                                                // //     .hasMatch(value)) {
                                                // //   return 'Password must have symbol characters';
                                                // // }
                                                // else if (!value
                                                //     .contains(RegExp(r'[A-Z]'))) {
                                                //   return 'Password must have an upper case character';
                                                // } else if (!value
                                                //     .contains(RegExp(r'[a-z]'))) {
                                                //   return 'Password must have a lower case character';
                                                // } else if (!value
                                                //     .contains(RegExp(r'[0-9]'))) {
                                                //   return 'Password must have numeric characters';
                                                // } else if (value.length < 8) {
                                                //   return 'Password must be at least 8 characters long';
                                                // }
                                                // // else if (!value.contains(RegExp(
                                                // //         r'[!@#<>?$":_`~•;√π÷¶∆£¢∑¥ˆ˚≈=}{©®™€∫./[\]\\|=+)(*&^%0-9-]'))
                                                // //     // .hasMatch(value)
                                                // //     ) {
                                                // // }
                                                // else if (!(RegExp(
                                                //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&\?%^+*~]).{8,}$'))
                                                //     .hasMatch(value)) {
                                                //   return 'Password must have symbol characters';
                                                // }
                                                else {
                                                  return null;
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        // top: 16.0,
                                        bottom: 8,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Confirm Password',
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
                                              controller: controller
                                                  .passwordConfirmTextCtrl,
                                              obscureText: !controller
                                                  .showConfirmPassword.value,
                                              hintText: 'Confirm Password',
                                              suffixIcon: InkWell(
                                                onTap: () {
                                                  controller.showConfirmPassword
                                                          .value =
                                                      !controller
                                                          .showConfirmPassword
                                                          .value;
                                                },
                                                child: Icon(controller
                                                        .showConfirmPassword
                                                        .value
                                                    ? Icons
                                                        .visibility_off_outlined
                                                    : Icons
                                                        .remove_red_eye_outlined),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please Enter Password';
                                                } else if (value.trim() !=
                                                    controller
                                                        .passwordTextCtrl.text
                                                        .trim()) {
                                                  return 'Mismatch Password';
                                                } else {
                                                  return null;
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // SizedBox(height: Get.height * 0.025),

                                    SizedBox(height: Get.height * 0.025),
                                    Center(
                                      child: FittedBox(
                                        child: InkWell(
                                          onTap: () {
                                            controller.isTermsAccepted.value =
                                                !controller
                                                    .isTermsAccepted.value;
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  value: controller
                                                      .isTermsAccepted.value,
                                                  activeColor:
                                                      AppColors.primary,
                                                  onChanged: (value) {
                                                    if (value != null) {
                                                      if (value) {
                                                        controller
                                                            .isTermsAccepted
                                                            .value = value;
                                                      } else {
                                                        controller
                                                            .isTermsAccepted
                                                            .value = value;
                                                      }
                                                    } else {
                                                      controller.isTermsAccepted
                                                          .value = false;
                                                    }
                                                  }),
                                              Text(
                                                'I agree to ',
                                                style: textTheme.bodyLarge!
                                                    .copyWith(
                                                        color:
                                                            AppColors.appBlack),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.to(() =>
                                                      const TermsAndServiceView());
                                                },
                                                child: Text(
                                                  'Terms & Conditions',
                                                  style: textTheme.bodyLarge!
                                                      .copyWith(
                                                          color:
                                                              AppColors.primary,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          decorationColor:
                                                              AppColors
                                                                  .primary),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    FilledRoundButton(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        onPressed: controller
                                                .isTermsAccepted.value
                                            ? () {
                                                if (controller
                                                    .signUpKey.currentState!
                                                    .validate()) {
                                                  // Remove after testing and uncomment rest
                                                  // Get.toNamed(Routes.VERIFY,
                                                  //     arguments: {
                                                  //       'Email': controller
                                                  //           .emailTextCtrl
                                                  //           .text,
                                                  //       'Mobile': controller
                                                  //           .mobileTextCtrl
                                                  //           .text,
                                                  //       'ForgotPasswordPage':
                                                  //           false
                                                  //     });

                                                  controller.postSignUP(
                                                      controller.fillSignUp());
                                                }
                                              }
                                            : null,
                                        buttonText: 'Create my account'),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: Center(
                                        child: FittedBox(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Already have an account? ',
                                                style: textTheme.bodyLarge!
                                                    .copyWith(
                                                        color:
                                                            AppColors.appBlack),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.offAndToNamed(
                                                      Routes.SIGN_IN);
                                                },
                                                child: Text(
                                                  'Sign In',
                                                  style: textTheme.bodyLarge!
                                                      .copyWith(
                                                          color:
                                                              AppColors.primary,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          decorationColor:
                                                              AppColors
                                                                  .primary),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 16.0),
                                    //   child: OutlinedAppButton(
                                    //     onPressed: () {
                                    //       Get.toNamed(Routes.ONBOARDING);
                                    //     },
                                    //     buttonText: 'Skip',
                                    //     padding: const EdgeInsets.symmetric(
                                    //         vertical: 4),
                                    //     buttonColor: AppColors.black,
                                    //   ),
                                    // ),
                                  ]),
                            ),
                            SizedBox(height: Get.height * 0.08),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (controller.showLoader.value)
                  Positioned.fromRelativeRect(
                    rect: RelativeRect.fill,
                    child: ColoredBox(
                      color: Colors.black.withOpacity(0.5),
                      child: Lottie.asset(Assets.animations.loading),
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
