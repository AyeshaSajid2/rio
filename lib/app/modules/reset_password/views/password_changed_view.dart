import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/app_pages.dart';
import '../controllers/reset_password_controller.dart';

class PasswordChangedView extends GetView<ResetPasswordController> {
  const PasswordChangedView({super.key});
  @override
  Widget build(BuildContext context) {
    final pageHeight =
        Get.height - Get.statusBarHeight + (Get.mediaQuery.padding.top / 2);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: pageHeight,
          width: Get.width,
          child: Column(
            children: [
              SizedBox(
                height: pageHeight / 3,
                child: Column(
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
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 64),
                      child: Text(
                        'Rio App Password is Changed',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 64),
                      child: Text(
                        'Your password has been changed successfully.',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: pageHeight * 2 / 3,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(Assets.svgs.passwordChanged),
                      Column(
                        children: [
                          FilledRoundButton(
                              onPressed: () {
                                Get.offAllNamed(Routes.SIGN_IN);
                              },
                              buttonText: 'Next'),
                          SizedBox(height: Get.height * 0.08),
                        ],
                      ),
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
