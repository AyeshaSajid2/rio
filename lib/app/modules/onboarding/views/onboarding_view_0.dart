import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:usama/app/routes/app_pages.dart';

import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/components/widgets/outlined_app_button.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/onboarding_controller.dart';
import 'onboarding_view_1.dart';
import 'onboarding_view_2.dart';

class OnboardingView0 extends GetView<OnboardingController> {
  const OnboardingView0({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: SafeArea(
        bottom: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              child: Image.asset(
                Assets.images.onboardingBackgroundImg.path,
                width: Get.width,
                height: Get.height * 0.35,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: Get.height * 0.25,
              child: Container(
                width: Get.width - 32,
                height: Get.height * 0.75,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: SingleChildScrollView(
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
                        'Welcome to Rio',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 24.0.h),
                        child: const Text(
                          'Choose your connection choice',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: AppColors.textGrey,
                            height: 0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 18.0.h),
                            child: const Text(
                              'There are two scenarios \nto install the router.',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w300,
                                color: AppColors.black,
                                height: 0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          OnboardingWelcomeTile(
                            stepNo: '1',
                            stepInstruction:
                                'Connect router to your existing internet providers modem.',
                            showBackgroundColor: false,
                            onPressed: () {
                              Get.to(() => const OnboardingView1());
                            },
                          ),
                          OnboardingWelcomeTile(
                            stepNo: '2',
                            stepInstruction:
                                'Connect router to your existing router.',
                            showBackgroundColor: false,
                            showBorder: false,
                            onPressed: () {
                              Get.to(() => const OnboardingView2());
                            },
                          ),
                          FilledRoundButton(
                            onPressed: () {
                              Get.toNamed(Routes.ADMIN_LOGIN);
                            },
                            buttonText: 'Skip',
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.08),
                    ],
                  ),
                ),
              ),
            ),
            // const Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   // children: [Text('data')],
            // ),
          ],
        ),
      ),
    );
  }
}

class OnboardingWelcomeTile extends StatelessWidget {
  const OnboardingWelcomeTile(
      {super.key,
      required this.stepNo,
      required this.stepInstruction,
      required this.showBackgroundColor,
      this.showBorder = true,
      required this.onPressed});

  final String stepNo;
  final String stepInstruction;
  final bool showBackgroundColor;
  final bool showBorder;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        // horizontal: 8,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: showBackgroundColor ? AppColors.splashTileBackground : null,
        border: showBorder
            ? const Border(
                bottom: BorderSide(color: AppColors.appGrabber, width: 0.5))
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(4),
              // margin: const EdgeInsets.all(14),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.primary),
              child: Text(stepNo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      stepInstruction,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                      // maxLines: 3,
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: OutlinedAppButton(
                      onPressed: onPressed,
                      buttonText: 'Next',
                      buttonColor: AppColors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
