import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:usama/core/theme/colors.dart';

import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/components/widgets/outlined_app_button.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/app_pages.dart';
import '../controllers/router_setup_controller.dart';

class RouterReadyView extends GetView<RouterSetupController> {
  const RouterReadyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            // height: Get.height,
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
                    const Padding(
                      padding:
                          EdgeInsets.only(bottom: 16.0, left: 32, right: 32),
                      child: Text(
                        'Your router is ready.\nNow you can connect devices to the Router.',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.05),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      RouterReadyInstructionTile(
                        stepNo: '01',
                        stepInstruction:
                            'Share the password of a WiFi SSID or SecureRoom™ with your family and friends.',
                      ),
                      RouterReadyInstructionTile(
                        stepNo: '02',
                        stepInstruction:
                            'Instruct them to connect to the WiFi SSID.',
                      ),
                      RouterReadyInstructionTile(
                        stepNo: '03',
                        stepInstruction:
                            'Once they have connected to the WiFi, you will receive a notification on your mobile device.',
                      ),
                      RouterReadyInstructionTile(
                        stepNo: '04',
                        stepInstruction:
                            'Approve and move the device to a SecureRoom™ in that SSID.',
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Text(
                    'You can also connect devices automatically to the Shared SSID by using the WPS button found on the back of your Rio Router.',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
                SizedBox(height: Get.height * 0.05),
                OutlinedAppButton(
                  onPressed: () {
                    Get.toNamed(Routes.PASSWORDS);
                  },
                  buttonText: 'Share Password Now',
                  buttonColor: AppColors.black,
                ),
                SizedBox(height: Get.height * 0.0075),
                FilledRoundButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.HOME);
                  },
                  buttonText: 'Go to Dashboard',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RouterReadyInstructionTile extends StatelessWidget {
  const RouterReadyInstructionTile({
    super.key,
    required this.stepNo,
    required this.stepInstruction,
    this.showBorder = true,
  });

  final String stepNo;

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
