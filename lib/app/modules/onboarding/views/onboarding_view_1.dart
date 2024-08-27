import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/components/widgets/onboarding_tile.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/onboarding_controller.dart';
import 'onboarding_view_11.dart';

class OnboardingView1 extends GetView<OnboardingController> {
  const OnboardingView1({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: Get.width * 0.075),
            const OnboardingTile(color: AppColors.primary),
            const OnboardingTile(color: AppColors.grey),
            const OnboardingTile(color: AppColors.grey),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'The router is connected directly to the modem of your internet service provider',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const OnboardingInstructionTile(
                    stepNo: '01',
                    stepInstructionTitle: 'POWER DOWN THE MODEM AND RIO ROUTER',
                    stepInstruction:
                        'Unplug the modem and Rio router from the power socket.',
                  ),
                  const OnboardingInstructionTile(
                    stepNo: '02',
                    stepInstructionTitle:
                        'CONNECT YOUR RIO ROUTER TO THE MODEM',
                    stepInstruction:
                        'Connect the WAN port of the Rio router to the modem ethernet port.',
                  ),
                  const OnboardingInstructionTile(
                    stepNo: '03',
                    stepInstructionTitle: 'POWER UP THE MODEM',
                    stepInstruction:
                        'Plug your modem into the power socket and power on.\nWait for 5-10 min until the modems status is active.',
                  ),
                  const OnboardingInstructionTile(
                    stepNo: '04',
                    stepInstructionTitle: 'POWER UP YOUR RIO ROUTER',
                    stepInstruction:
                        'Ensure that the Rio router is connected to the modem.\nPlug your Rio into the power socket, press the on button, and power up your Rio.',
                    showBorder: false,
                  ),
                  // SvgPicture.asset(Assets.svgs.routerStep1),
                  SizedBox(height: Get.height * 0.025),
                  Image.asset(Assets.images.routerStep1.path),
                  SizedBox(height: Get.height * 0.025),
                  Column(
                    children: [
                      FilledRoundButton(
                          onPressed: () {
                            Get.to(() => const OnboardingView11());
                          },
                          buttonText: 'Next'),
                      SizedBox(height: Get.height * 0.08),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingInstructionTile extends StatelessWidget {
  const OnboardingInstructionTile({
    super.key,
    required this.stepNo,
    required this.stepInstruction,
    this.showBorder = true,
    required this.stepInstructionTitle,
  });

  final String stepNo;
  final String stepInstructionTitle;
  final String stepInstruction;

  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        // horizontal: 8,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.splashTileBackground,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stepInstructionTitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    stepInstruction,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
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
