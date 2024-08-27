import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/components/widgets/app_text_field.dart';
import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/extensions/imports.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/app_pages.dart';
import '../controllers/forgot_router_password_controller.dart';

class ForgotRouterPasswordView extends GetView<ForgotRouterPasswordController> {
  const ForgotRouterPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: RioAppBar(
        titleText: '',
        refresh: true,
        refreshText: controller.pageTitle,
        backOn: false,
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
                  key: controller.forgotRouterPasswordKey,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text(
                          'Enter the default password shown on the sticker at the bottom of the router.',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w300),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                            Assets.images.routerUsername.path,
                            // height: Get.height * 0.11,
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.04),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Default Router Password',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black.withOpacity(0.5)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: AppTextField(
                                controller: controller.defaultPasswordTEC,
                                obscureText: !controller.showWiFiPassword.value,
                                hintText: 'Enter Default Router Password',
                                suffixIcon: InkWell(
                                  onTap: () {
                                    controller.showWiFiPassword.value =
                                        !controller.showWiFiPassword.value;
                                  },
                                  child: Icon(controller.showWiFiPassword.value
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
                      ),
                      SizedBox(height: Get.height * 0.08),
                      FilledRoundButton(
                        onPressed: () {
                          if (controller.forgotRouterPasswordKey.currentState!
                              .validate()) {
                            controller.putAdminLogin(
                              controller.fillAdminLoginParam(),
                            );
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
