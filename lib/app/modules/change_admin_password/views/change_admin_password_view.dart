import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/components/dialogs/dialog.dart';
import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/components/widgets/app_text_field.dart';
import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';

import '../controllers/change_admin_password_controller.dart';

class ChangeAdminPasswordView extends GetView<ChangeAdminPasswordController> {
  const ChangeAdminPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      appBar: const RioAppBar(
        titleText: 'Change Admin Password',
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return SizedBox(
            height: (Get.height - Get.statusBarHeight),
            width: Get.width,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: Form(
                    key: controller.changeAdminPasswordKey,
                    child: Column(
                      children: [
                        SizedBox(height: Get.height * 0.05),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         'Old Password',
                        //         style: TextStyle(
                        //             fontSize: 14,
                        //             fontWeight: FontWeight.w400,
                        //             color: AppColors.black.withOpacity(0.5)),
                        //       ),
                        //       Padding(
                        //         padding:
                        //             const EdgeInsets.symmetric(vertical: 4.0),
                        //         child: AppTextField(
                        //           controller: controller.oldPasswordTEC,
                        //           obscureText:
                        //               !controller.showWiFiPassword.value,
                        //           hintText: 'Enter Old Password',
                        //           suffixIcon: InkWell(
                        //             onTap: () {
                        //               controller.showWiFiPassword.value =
                        //                   !controller.showWiFiPassword.value;
                        //             },
                        //             child: Icon(
                        //                 controller.showWiFiPassword.value
                        //                     ? Icons.visibility_off_outlined
                        //                     : Icons.remove_red_eye_outlined),
                        //           ),
                        //           validator: (value) {
                        //             if (value == null || value.isEmpty) {
                        //               return 'Please Enter Old Password';
                        //             } else if (value !=
                        //                 controller.oldPassword) {
                        //               return 'Please Enter Correct Old Password';
                        //             } else {
                        //               return null;
                        //             }
                        //           },
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Set New Password',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            AppColors.black.withOpacity(0.5)),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Dialogs.showAlertDialogWithTitleContent(
                                          titleText: 'Password Requirements',
                                          bodyText:
                                              // 'Minimum length 8 characters\nContains at least 1 number\nContains at least 1 special character\nContains at least 1 uppercase letter\nContains at least 1 lowercase letter');
                                              'The password should be of length 8-16 and must contain lower-case letters, upper-case letters, digits, and special characters ~!@#%^*()_+');
                                    },
                                    child: const Column(
                                      children: [
                                        Text(
                                          'Password Requirements',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              decoration:
                                                  TextDecoration.underline,
                                              color: AppColors.black),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: AppTextField(
                                  controller: controller.adminNewPasswordTEC,
                                  obscureText:
                                      !controller.showAdminPassword.value,
                                  hintText: 'Enter Password',
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      controller.showAdminPassword.value =
                                          !controller.showAdminPassword.value;
                                    },
                                    child: Icon(
                                        controller.showAdminPassword.value
                                            ? Icons.visibility_off_outlined
                                            : Icons.remove_red_eye_outlined),
                                  ),
                                  // onTap: () {
                                  //   Dialogs.showAlertDialogWithTitleContent(
                                  //       titleText: 'Password Requirements',
                                  //       bodyText:
                                  //           // 'Minimum length 8 characters\nContains at least 1 number\nContains at least 1 special character\nContains at least 1 uppercase letter\nContains at least 1 lowercase letter');
                                  //           'The password should be of length 8-16  and must contain lower-case letters, upper-case letters, digits, and special characters ~!@#%^*()_+');
                                  // },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Password';
                                    } else if (!value.contains(RegExp(
                                        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+-])[^\s]{8,16}$'))) {
                                      return 'Password doesn\'t match requirements';
                                    }
                                    // else if (value.length < 8 ||
                                    //     value.length > 16) {
                                    //   return 'Password length must be 8-16';
                                    // } else if (!value
                                    //     .contains(RegExp(r'[A-Z]'))) {
                                    //   return 'Password must have an upper case character';
                                    // } else if (!value
                                    //     .contains(RegExp(r'[a-z]'))) {
                                    //   return 'Password must have a lower case character';
                                    // } else if (!value
                                    //     .contains(RegExp(r'[0-9]'))) {
                                    //   return 'Password must have numeric characters';
                                    // } else if (!(RegExp(
                                    //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&\?%^+*()_~]).{8,}$'))
                                    //     .hasMatch(value)) {
                                    //   return 'Password must have a special (~!@#\$%^&*()_+) character';
                                    // } else if (value !=
                                    //     controller
                                    //         .adminConfirmPasswordTEC.text) {
                                    //   return 'Both passwords are different';
                                    // }
                                    else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: AppTextField(
                                  controller:
                                      controller.adminConfirmPasswordTEC,
                                  obscureText: !controller
                                      .showConfirmAdminPassword.value,
                                  hintText: 'Confirm Password',
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      controller
                                              .showConfirmAdminPassword.value =
                                          !controller
                                              .showConfirmAdminPassword.value;
                                    },
                                    child: Icon(controller
                                            .showConfirmAdminPassword.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.remove_red_eye_outlined),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Password';
                                    } else if (value !=
                                        controller.adminNewPasswordTEC.text) {
                                      return 'Both passwords are different';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        FilledRoundButton(
                          onPressed: () {
                            if (controller.changeAdminPasswordKey.currentState!
                                .validate()) {
                              controller.changeAdminPassword(
                                  controller.fillAdminPassword());
                            }
                          },
                          buttonText: 'Save',
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
                        color: Colors.black12,
                        child: Lottie.asset(Assets.animations.loading),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
