import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/components/widgets/app_text_field.dart';
import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/router_password_change_controller.dart';

class RouterPasswordChangeView extends GetView<RouterPasswordChangeController> {
  const RouterPasswordChangeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const RioAppBar(
        titleText: 'Change Router Password',
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: controller.changeRouterPasswordKey,
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
                              'For security reasons, it is advised that you change your Rio Router password.',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Row(
                        children: [
                          Text(
                            'Router Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      // if (!controller.isFromForgotPassword)
                      //   Padding(
                      //     padding: const EdgeInsets.only(
                      //       top: 16.0,
                      //       // bottom: 8,
                      //     ),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           'Old Router Password',
                      //           style: TextStyle(
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w400,
                      //               color: AppColors.black.withOpacity(0.5)),
                      //         ),
                      //         Padding(
                      //           padding:
                      //               const EdgeInsets.symmetric(vertical: 4.0),
                      //           child: AppTextField(
                      //             controller: controller.oldRouterPasswordTEC,

                      //             hintText: 'Enter old router password',
                      //             obscureText:
                      //                 !controller.showOldRouterPassword.value,

                      //             suffixIcon: InkWell(
                      //               onTap: () {
                      //                 controller.showOldRouterPassword.value =
                      //                     !controller
                      //                         .showOldRouterPassword.value;
                      //               },
                      //               child: Icon(
                      //                   controller.showOldRouterPassword.value
                      //                       ? Icons.visibility_off_outlined
                      //                       : Icons.remove_red_eye_outlined),
                      //             ),
                      //             validator: (value) {
                      //               if (value == null || value.isEmpty) {
                      //                 return 'Please Enter Old Router Password';
                      //               } else if (value.length < 8 ||
                      //                   value.length > 16) {
                      //                 return 'Password length must be 8-16';
                      //               } else {
                      //                 return null;
                      //               }
                      //             },
                      //             // suffixIcon: controller.routerShowLoader.value
                      //             //     ? SizedBox(
                      //             //         height: 24,
                      //             //         width: 24,
                      //             //         child: Lottie.asset(
                      //             //             Assets.animations.loading))
                      //             //     : null,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16.0,
                          bottom: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'New Router Password',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black.withOpacity(0.5)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: AppTextField(
                                controller: controller.newRouterPasswordTEC,
                                hintText: 'Enter New Router Password',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter New Router Password';
                                  } else if (value.length < 8 ||
                                      value.length > 16) {
                                    return 'Password length must be 8-16';
                                  }
                                  // else if (value ==
                                  //     controller.getAdminPasswordModel
                                  //         .adminPassword) {
                                  //   return 'Please enter a New Password';
                                  // }
                                   else {
                                    return null;
                                  }
                                },
                                obscureText:
                                    !controller.showNewRouterPassword.value,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    controller.showNewRouterPassword.value =
                                        !controller.showNewRouterPassword.value;
                                  },
                                  child: Icon(
                                      controller.showNewRouterPassword.value
                                          ? Icons.visibility_off_outlined
                                          : Icons.remove_red_eye_outlined),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Confirm Password',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black.withOpacity(0.5)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: AppTextField(
                                controller:
                                    controller.newRouterConfirmPasswordTEC,
                                obscureText:
                                    !controller.showConfirmRouterPassword.value,
                                hintText: 'Enter Password',
                                suffixIcon: InkWell(
                                  onTap: () {
                                    controller.showConfirmRouterPassword.value =
                                        !controller
                                            .showConfirmRouterPassword.value;
                                  },
                                  child: Icon(
                                      controller.showConfirmRouterPassword.value
                                          ? Icons.visibility_off_outlined
                                          : Icons.remove_red_eye_outlined),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Password';
                                  } else if (value.length < 8 ||
                                      value.length > 16) {
                                    return 'Password length must be 8-16';
                                  } else if (value !=
                                      controller.newRouterPasswordTEC.text) {
                                    return 'Confirm Password Mismatched';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      FilledRoundButton(
                        onPressed: () {
                          // controller.getRouterName();
                          if (controller.changeRouterPasswordKey.currentState!
                              .validate()) {
                            controller.changePassword();
                          }
                        },
                        buttonText: 'Next',
                        padding: const EdgeInsets.symmetric(vertical: 4),
                      ),
                      // OutlinedAppButton(
                      //   onPressed: controller.showLoader.value
                      //       // (controller.routerShowLoader.value ||
                      //       //         controller.wifiShowLoader.value)
                      //       ? null
                      //       : () {
                      //           Get.offAllNamed(Routes.DASHBOARD);
                      //         },
                      //   buttonText: 'Skip',
                      //   padding: const EdgeInsets.symmetric(vertical: 4),
                      //   buttonColor: AppColors.black,
                      // ),
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
