import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:usama/core/theme/colors.dart';
import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../routes/app_pages.dart';

import '../../../../gen/assets.gen.dart';
import '../controllers/splash_controller.dart';

class GetStartedView extends GetView<SplashController> {
  const GetStartedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      // appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            child: Image.asset(
              Assets.images.welcomeImg.path,
              width: Get.width,
              height: Get.height * 0.35,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: Get.height * 0.26,
            height: Get.height * 0.74,
            child: SingleChildScrollView(
              child: Container(
                width: Get.width - 32,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: SvgPicture.asset(
                        Assets.svgs.logo,
                        width: Get.width * 0.15,
                        height: Get.width * 0.15,
                      ),
                    ),
                    const Text(
                      'Let’s create your account',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: Get.height * 0.0125),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: Get.height * 0.008),
                        const Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: Text(
                            'Create your personal Rio account so you can manage your router preferences at any time.',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: AppColors.black,
                              height: 0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.05),
                        SvgPicture.asset(
                          Assets.svgs.email,
                          width: Get.width * 0.5,
                          height: Get.width * 0.15,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 32),
                          child: Text(
                            'An email will be sent to your address with a 6-digit verification code.',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: AppColors.black,
                              height: 0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        FilledRoundButton(
                            onPressed: () {
                              Get.toNamed(Routes.SIGN_UP);
                            },
                            buttonText: 'Create Account'),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.4),
                  ],
                ),
              ),
            ),
          ),
          // const Column(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [],
          // ),
        ],
      ),
    );
  }
}
