import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:usama/core/theme/colors.dart';

import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/router_setup_controller.dart';
import 'router_setup_setting_view.dart';

class RouterSetupInfoView extends GetView<RouterSetupController> {
  const RouterSetupInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
                Text(
                  'Congratulations, \nyour Rio is ready!',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: Text(
                    'Rio comes with the following SSID Wi-Fi networks and SecureRooms™',
                    // 'Wi-Fi networks and SecureRooms™',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Scrollbar(
                      controller: controller.routerSetupInfoSC,
                      thumbVisibility: true,
                      child: ListView.builder(
                          shrinkWrap: true,
                          controller: controller.routerSetupInfoSC,
                          itemCount: controller.listOfSSIDAndRoomsInfo.length,
                          itemBuilder: (context, index) {
                            return ColoredTile(
                                title: controller
                                    .listOfSSIDAndRoomsInfo[index].keys.first,
                                stepInstruction: controller
                                    .listOfSSIDAndRoomsInfo[index].values.first,
                                subSteps: index == 3
                                    ? controller.listOfSubSSIDAndRoomsInfo
                                    : null,
                                isInstructionColorRed:
                                    index == 2 ? true : false,
                                showBackgroundColor:
                                    index % 2 == 0 ? true : false);
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    'Please note that each room can be individually customized in the next section, “SETTING UP SECUREROOMS”.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                FilledRoundButton(
                  onPressed: () {
                    Get.to(() => const RouterSetupSettingView());
                  },
                  buttonText: 'Setup Networks & SecureRooms',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ColoredTile extends StatelessWidget {
  const ColoredTile({
    super.key,
    required this.title,
    required this.showBackgroundColor,
    this.showBorder = true,
    required this.stepInstruction,
    this.isInstructionColorRed = false,
    this.subSteps,
  });

  final String title;
  final String stepInstruction;
  final List<Map<String, String>>? subSteps;
  final bool showBackgroundColor;
  final bool showBorder;
  final bool isInstructionColorRed;

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
      child: IntrinsicHeight(
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
                color: isInstructionColorRed
                    ? AppColors.red
                    : Colors.black.withOpacity(0.7),
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            if (subSteps != null && subSteps!.isNotEmpty)
              SizedBox(
                width: Get.width,
                height: 230,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: subSteps!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Wrap(
                        children: [
                          Text(subSteps![index].keys.first,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              )),
                          Text(subSteps![index].values.first,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                              )),
                        ],
                      );
                    }),
              ),
          ],
        ),
      ),
    );
  }
}
