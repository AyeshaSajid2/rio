import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/components/widgets/onboarding_tile.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/onboarding_controller.dart';
import 'onboarding_view_21.dart';

class OnboardingView2 extends GetView<OnboardingController> {
  const OnboardingView2({super.key});
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
                'The router is connected to your existing router.',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
            ),
            Onboarding2InstructionTiles(
              svgPath: Assets.svgs.wanPort,
              stepInstruction:
                  'Connect the Rio router using the WAN port (blue color) to your existing router.',
            ),
            Onboarding2InstructionTiles(
              svgPath: Assets.svgs.switchIcon,
              stepInstruction: 'Power up the Rio router.',
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // SvgPicture.asset(Assets.svgs.routerStep1),
                  Image.asset(Assets.images.routerInstallStep2.path),
                  SizedBox(height: Get.height * 0.08),
                  Column(
                    children: [
                      FilledRoundButton(
                          onPressed: () {
                            Get.to(() => const OnboardingView21());
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

class Onboarding2InstructionTiles extends StatelessWidget {
  const Onboarding2InstructionTiles({
    super.key,
    required this.stepInstruction,
    required this.svgPath,
  });

  final String stepInstruction;
  final String svgPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(4),
              alignment: Alignment.center,
              child: SvgPicture.asset(svgPath),
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
                  fontSize: 18,
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
