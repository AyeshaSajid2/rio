import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/components/widgets/onboarding_tile.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/onboarding_controller.dart';
import 'onboarding_tabs_view.dart';

class OnboardingView11 extends GetView<OnboardingController> {
  const OnboardingView11({super.key});
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: Get.width * 0.075),
            const OnboardingTile(color: AppColors.primary),
            const OnboardingTile(color: AppColors.primary),
            const OnboardingTile(color: AppColors.grey),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding:
                  EdgeInsets.only(top: 32.0, bottom: 18, left: 36, right: 36),
              child: Text(
                'Wait for your Rio router to activate',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 18,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.splashTileBackground,
                      border: Border(
                          bottom: BorderSide(
                              color: AppColors.appGrabber, width: 0.5)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ROUTER LED LIGHT',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Will turn solid green for a few seconds, followed by flashing green for 3-5 minutes, and back to solid green.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  SvgPicture.asset(Assets.svgs.routerLed),
                  // Image.asset(Assets.images.routerStep2.path),
                  SizedBox(height: Get.height * 0.02),
                  Column(
                    children: [
                      ListTile(
                        visualDensity: const VisualDensity(vertical: -4),
                        leading: SvgPicture.asset(Assets.svgs.flash1),
                        title: Text(
                          'Flashing Green',
                          style: textTheme.titleMedium,
                        ),
                        subtitle: const Text(
                          'Router is starting up',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                      ),
                      ListTile(
                        visualDensity: const VisualDensity(vertical: -4),
                        leading: SvgPicture.asset(Assets.svgs.bullet),
                        title: Text(
                          'Solid Green',
                          style: textTheme.titleMedium,
                        ),
                        subtitle: const Text(
                          'Router is ready',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                      ),
                      ListTile(
                        visualDensity: const VisualDensity(vertical: -4),
                        leading: SvgPicture.asset(Assets.svgs.bulletRed),
                        title: Text(
                          'Solid Red',
                          style: textTheme.titleMedium,
                        ),
                        subtitle: const Text(
                          'Router is not connected to the internet',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                      ),
                      ListTile(
                        visualDensity: const VisualDensity(vertical: -4),
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: SvgPicture.asset(Assets.svgs.flashRedBlue),
                        ),
                        title: Text(
                          'Flashing Red and Blue',
                          style: textTheme.titleMedium,
                        ),
                        subtitle: const Text(
                          'Updating router firmware',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.05),
                      FilledRoundButton(
                          onPressed: () {
                            Get.to(() => const OnboardingTabsView());
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
