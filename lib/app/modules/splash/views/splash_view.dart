import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:usama/app/modules/splash/views/get_started_view.dart';
import 'package:usama/core/theme/colors.dart';
import '../../../../core/components/widgets/filled_round_button.dart';

import '../../../../gen/assets.gen.dart';
import '../../../routes/app_pages.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  Assets.svgs.logo,
                  width: Get.width * 0.15,
                  height: Get.width * 0.15,
                ),
                Text(
                  'Setting up your Rio',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: Get.width - 32,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(8.0),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 18.0),
                          child: Text(
                            'This router is designed with top-notch security features, which might make the setup process a bit more involved. But don’t worry, we’re here to guide you through it. Once it’s all set up, you’ll appreciate the peace of mind that comes with enhanced security.',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: AppColors.black,
                              height: 0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const StepInstructorTile(
                          stepNo: '01',
                          stepInstruction:
                              'Create an account on the Rio app. This will allow you to manage your router.',
                          showBackgroundColor: true,
                        ),
                        const StepInstructorTile(
                          stepNo: '02',
                          stepInstruction:
                              'Follow the instructions provided in the Rio app to set up your Rio network.\nDo not connect the router until you have finished this step.',
                          showBackgroundColor: false,
                        ),
                        const StepInstructorTile(
                          stepNo: '03',
                          stepInstruction:
                              'Connect your Rio Router to your ISP Modem using the provided Ethernet cable. Make sure to reboot the modem.',
                          showBackgroundColor: true,
                        ),
                        const StepInstructorTile(
                          stepNo: '04',
                          stepInstruction:
                              'Access your Wi-Fi network and connect it to your Rio Router.',
                          showBackgroundColor: false,
                          showBorder: false,
                        ),
                        SizedBox(height: Get.height * 0.01),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              width: Get.width - 32,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledRoundButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        // Get.toNamed(Routes.SIGN_UP);
                        Get.to(() => const GetStartedView());
                        // Get.toNamed(Routes.SCANNER);
                      },
                      buttonText: 'Create my account'),
                  SizedBox(height: Get.height * 0.01),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  FilledRoundButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Get.toNamed(Routes.SIGN_IN);
                      },
                      buttonColor: AppColors.blue,
                      buttonText: 'Login Now'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StepInstructorTile extends StatelessWidget {
  const StepInstructorTile(
      {super.key,
      required this.stepNo,
      required this.stepInstruction,
      required this.showBackgroundColor,
      this.showBorder = true});

  final String stepNo;
  final String stepInstruction;
  final bool showBackgroundColor;
  final bool showBorder;

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
                  shape: BoxShape.circle, color: AppColors.red),
              child: Text(stepNo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                stepInstruction,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
