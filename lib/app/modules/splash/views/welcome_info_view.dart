import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:usama/app/modules/splash/views/splash_view.dart';
import 'package:usama/core/extensions/imports.dart';
import 'package:usama/core/theme/colors.dart';

import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/splash_controller.dart';

class WelcomeInfoView extends GetView<SplashController> {
  const WelcomeInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
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
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.0),
                  child: Text(
                    'Your Rio Router comes with these special features:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Scrollbar(
                      controller: controller.welcomeInfoScrollController,
                      child: ListView.builder(
                          shrinkWrap: true,
                          controller: controller.welcomeInfoScrollController,
                          itemCount: controller.listOfWelcomeInfo.length,
                          itemBuilder: (context, index) {
                            return ColoredTile(
                                title: controller
                                    .listOfWelcomeInfo[index].keys.first,
                                stepInstruction: controller
                                    .listOfWelcomeInfo[index].values.first,
                                showBackgroundColor:
                                    index % 2 == 0 ? false : true);
                          }),
                    ),
                  ),
                  // const Spacer(),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text:
                                  'Enjoy setting up your Rio Router!\nIf you encounter any issues, you can use Rio’s built-in AI chatbot to help you with any questions you may have or reach out to us at ',
                              style: const TextStyle(
                                  color: AppColors.black, fontSize: 13),
                              children: [
                                TextSpan(
                                  text: 'support@riorouter.com.\n',
                                  style: const TextStyle(
                                      color: AppColors.primary, fontSize: 13),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchURL(
                                        scheme: 'mailto',
                                        path: 'support@riorouter.com',
                                      );
                                    },
                                ),
                                const TextSpan(
                                  text: 'We’re here to assist you!',
                                  style: TextStyle(
                                      color: AppColors.black, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ),
                        FilledRoundButton(
                          onPressed: () {
                            Get.to(() => const SplashView());
                          },
                          buttonText: 'NEXT',
                        ),
                      ],
                    ),
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

class ColoredTile extends StatelessWidget {
  const ColoredTile(
      {super.key,
      required this.title,
      required this.stepInstruction,
      required this.showBackgroundColor,
      this.showBorder = true});

  final String title;
  final String stepInstruction;
  final bool showBackgroundColor;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: showBackgroundColor
            ? AppColors.splashTileBackground
            : AppColors.white,
        border: showBorder
            ? const Border(
                bottom: BorderSide(color: AppColors.appGrabber, width: 0.5))
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 13,
                fontWeight: FontWeight.w700,
              )),
          Text(
            stepInstruction,
            style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
