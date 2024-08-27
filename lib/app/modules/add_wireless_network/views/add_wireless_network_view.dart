import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/components/widgets/app_pop_up_menu.dart';
import '../../../../core/components/widgets/app_text_field.dart';
import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/theme/colors.dart';

import '../../../../gen/assets.gen.dart';
import '../controllers/add_wireless_network_controller.dart';

class AddWirelessNetworkView extends GetView<AddWirelessNetworkController> {
  const AddWirelessNetworkView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      appBar: const RioAppBar(
        titleText: 'Add Wireless Network',
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return SizedBox(
            height: controller.pageHeight.value,
            width: Get.width,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: controller.addWifiKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'WiFi Network Name (SSID)',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black.withOpacity(0.5)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: AppTextField(
                                  controller: controller.wifiNameTEC,
                                  obscureText: false,
                                  hintText: 'Enter WiFi Network Name (SSID)',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      controller.updateScreenSize(0);
                                      return 'Please Enter WiFi Network Name (SSID) ';
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
                                'Frequency',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black.withOpacity(0.5)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: AppTextField(
                                  controller: controller.frequencyTEC,
                                  obscureText: false,
                                  readOnly: true,
                                  enabled: false,
                                  suffixIcon: const Icon(Icons.arrow_drop_down),
                                  hintText: 'Select Frequency',
                                  validator: null,
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
                                'Security Settings',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black.withOpacity(0.5)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: AppTextField(
                                  controller: controller.securitySettingsTEC,
                                  obscureText: false,
                                  readOnly: true,
                                  enabled: false,
                                  suffixIcon: const Icon(Icons.arrow_drop_down),
                                  hintText: 'Select Security Settings',
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
                                'WPA Encryption',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black.withOpacity(0.5)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: AppTextField(
                                  controller: controller.wpaEncryptionTEC,
                                  obscureText: false,
                                  readOnly: true,
                                  enabled: false,
                                  suffixIcon: const Icon(Icons.arrow_drop_down),
                                  hintText: 'Select WPA Encryption',
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  // controller.updateScreenSize();
                                  //     return 'Please Enter Router Name';
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
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
                                'Broadcast Status',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black.withOpacity(0.5)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: AppPopUpMenu(
                                  listOfPopupMenuItems: [
                                    AppPopupMenuItem.item(
                                        menuText: 'Enable', svgPath: ''),
                                    AppPopupMenuItem.item(
                                        menuText: 'Disable', svgPath: ''),
                                  ],
                                  onSelected: (broadcastStatus) {
                                    controller.broadcastTEC.text =
                                        broadcastStatus;
                                  },
                                  child: AppTextField(
                                    controller: controller.broadcastTEC,
                                    obscureText: false,
                                    readOnly: true,
                                    enabled: false,
                                    suffixIcon:
                                        const Icon(Icons.arrow_drop_down),
                                    keyboardType: TextInputType.none,
                                    hintText: 'Select Broadcast Status',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        controller.updateScreenSize(1);
                                        return 'Please Select Broadcast Status';
                                      } else {
                                        return null;
                                      }
                                    },
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
                                'WiFi Password',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black.withOpacity(0.5)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: AppTextField(
                                  controller: controller.wifiPasswordTEC,
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
                                      controller.updateScreenSize(2);
                                      return 'Please Enter Password';
                                    } else if (value.length < 8 ||
                                        value.length > 16) {
                                      controller.updateScreenSize(2);
                                      return 'Password length must be 8-16 characters';
                                    } else if (value !=
                                        controller
                                            .wifiConfirmPasswordTEC.text) {
                                      controller.updateScreenSize(2);
                                      return 'Both passwords are different';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: AppTextField(
                                  controller: controller.wifiConfirmPasswordTEC,
                                  obscureText:
                                      !controller.showConfirmWiFiPassword.value,
                                  hintText: 'Confirm Password',
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      controller.showConfirmWiFiPassword.value =
                                          !controller
                                              .showConfirmWiFiPassword.value;
                                    },
                                    child: Icon(
                                        controller.showConfirmWiFiPassword.value
                                            ? Icons.visibility_off_outlined
                                            : Icons.remove_red_eye_outlined),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      controller.updateScreenSize(3);
                                      return 'Please Enter Password';
                                    } else if (value !=
                                        controller.wifiPasswordTEC.text) {
                                      controller.updateScreenSize(3);
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
                        SizedBox(height: Get.height * 0.05),
                        FilledRoundButton(
                          onPressed: () {
                            if (controller.addWifiKey.currentState!
                                .validate()) {
                              controller.setWifi(controller.fillAddWifi());
                            }
                          },
                          buttonText: 'Add Network',
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
                        color: Colors.black54,
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
