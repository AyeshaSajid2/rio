import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:usama/core/utils/helpers/askey_storage.dart';
import 'package:usama/core/utils/helpers/common_func.dart';

import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/components/widgets/app_text_field.dart';
import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';

import '../../../routes/app_pages.dart';
import '../controllers/admin_login_controller.dart';

class AdminLoginView extends GetView<AdminLoginController> {
  const AdminLoginView({super.key});
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: (controller.showLoader.value)
            ? null
            : RioAppBar(
                titleText: 'Router Login',
                backOn: controller.showBackButton,
              ),
        floatingActionButton: constants.isKeyboardOpened() ||
                (controller.showLoader.value)
            ? null
            : FloatingActionButton(
                onPressed: () {
                  Get.toNamed(Routes.CUSTOMER_SUPPORT);
                },
                child: const Icon(Icons.support_agent, color: AppColors.white),
              ),
        body: SingleChildScrollView(
          child: (!controller.showLoader.value)
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: controller.singInKey,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Text(
                            'Enter the username and password shown on the sticker at the bottom of the router.',
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
                        // Text(
                        //   controller.wifiName!.value,
                        //   style: const TextStyle(
                        //       fontSize: 22, fontWeight: FontWeight.w300),
                        //   textAlign: TextAlign.center,
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Router Username',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black.withOpacity(0.5)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: AppTextField(
                                  controller: controller.userNameTEC,
                                  obscureText: false,
                                  hintText: 'Enter username',
                                  enabled: false,
                                  readOnly: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter username';
                                    } else {
                                      return null;
                                    }
                                  },
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
                                'Router Password',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black.withOpacity(0.5)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: AppTextField(
                                  controller: controller.userPasswordTEC,
                                  obscureText:
                                      !controller.showWiFiPassword.value,
                                  hintText: 'Enter Password',
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      controller.showWiFiPassword.value =
                                          !controller.showWiFiPassword.value;
                                    },
                                    child: Icon(
                                        controller.showWiFiPassword.value
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.FORGOT_ROUTER_PASSWORD,
                                    arguments: {'isDeviceTokenInvalid': false});
                              },
                              child: Text(
                                'Forgot Password?',
                                style: textTheme.bodyLarge!.copyWith(
                                    color: AppColors.primary,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.primary),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.rememberMe.value =
                                    !controller.rememberMe.value;

                                asKeyStorage.saveAsKeyAdminRememberMe(
                                    controller.rememberMe.value);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Checkbox(
                                      value: controller.rememberMe.value,
                                      activeColor: AppColors.primary,
                                      onChanged: (value) {
                                        if (value != null) {
                                          if (value) {
                                            controller.rememberMe.value = value;
                                          } else {
                                            controller.rememberMe.value = value;
                                          }
                                        } else {
                                          controller.rememberMe.value = false;
                                        }
                                      }),
                                  Text(
                                    'Remember me ',
                                    style: textTheme.bodyLarge!.copyWith(
                                        color: controller.rememberMe.value
                                            ? AppColors.primary
                                            : AppColors.appBlack),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        FilledRoundButton(
                          onPressed: () async {
                            if (controller.singInKey.currentState!.validate()) {
                              controller.checkWifiNameAndCallAdminLogin();
                              // controller.callAdminLogin();
                            }
                          },
                          buttonText: 'Sign In',
                          padding: const EdgeInsets.symmetric(vertical: 4),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        SizedBox(
                          width: Get.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(Assets.svgs.quotesOpen),
                              ),
                              const Expanded(
                                child: Text(
                                  'Please make sure you are \nconnected to Rio WiFi Network',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    SvgPicture.asset(Assets.svgs.quotesClose),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Get.height * 0.08),
                      ],
                    ),
                  ),
                )
              : SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.1),
                        child: SvgPicture.asset(
                          Assets.svgs.logo,
                          width: Get.width * 0.15,
                          height: Get.width * 0.15,
                        ),
                      ),
                      const Text(
                        'Welcome to Rio',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Lottie.asset(Assets.animations.loading)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Text(
                                'Getting Ready...',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w300),
                                textAlign: TextAlign.center,
                              ),
                              if (controller.isWifiConnected.value &&
                                  controller.wifiName!.value != 'null') ...[
                                Text(
                                  'Connected to ${controller.wifiName!.value}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              ]
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.15,
                        width: Get.width,
                      ),
                    ],
                  ),

                  // ColoredBox(
                  //   color: Colors.white,
                  //   child: Lottie.asset(Assets.animations.loading),
                  // ),
                ),
        ),
      );
    });
  }
}
