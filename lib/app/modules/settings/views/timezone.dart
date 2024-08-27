import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/theme/colors.dart';
import '../controllers/settings_controller.dart';

class TimeZonePage extends GetView<SettingsController> {
  const TimeZonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      appBar: const RioAppBar(
        titleText: 'Time Zone',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Container(
                width: Get.width,
                margin: const EdgeInsets.symmetric(vertical: 24),
                padding: EdgeInsets.only(left: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.listOfTimeZoneName.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return AppTimeZoneRadio(
                        selectedTimeZone: controller.selectedTimeZoneName,
                        timezone: controller.listOfTimeZoneName[index],
                        onChanged: (timezone) {
                          controller.selectedTimeZoneName.value =
                              timezone as String;
                          controller.selectedTimeZoneIndex = index;
                        },
                        showBorder:
                            index + 1 != controller.listOfTimeZoneName.length,
                      );
                    }),
              ),
              // SizedBox(
              //     width: Get.width,
              //     child: Obx(() {
              //       return ListTile(
              //         title: const Text(
              //           'Day Light saving',
              //           style: TextStyle(
              //             fontSize: 16,
              //             color: AppColors.appBlack,
              //           ),
              //         ),
              //         trailing: CupertinoSwitch(
              //             activeColor: AppColors.primary,
              //             value: controller.isDayLightSavingOn.value,
              //             onChanged: (value) {
              //               controller.isDayLightSavingOn.value = value;
              //             }),
              //         tileColor: AppColors.white,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(6)),
              //       );
              //     })),
              // const Spacer(),
              FilledRoundButton(
                onPressed: () {
                  controller.setTimeZone(controller.fillSetTimeZone());
                },
                buttonText: 'Save',
                padding: const EdgeInsets.symmetric(vertical: 4),
              ),
              SizedBox(height: Get.height * 0.08),
            ],
          ),
        ),
      ),
    );
  }
}

class AppTimeZoneRadio extends StatelessWidget {
  const AppTimeZoneRadio({
    super.key,
    required this.selectedTimeZone,
    required this.timezone,
    this.showBorder = true,
    required this.onChanged,
  });

  final String timezone;
  final RxString selectedTimeZone;

  final bool showBorder;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.065,
      width: Get.width,
      padding: EdgeInsets.only(
        top: 8.h,
        // bottom: 8.h,
      ),
      decoration: BoxDecoration(
          border: showBorder
              ? Border(
                  bottom: BorderSide(color: AppColors.black.withOpacity(0.2)))
              : null),
      child: Obx(() {
        return RadioListTile.adaptive(
          value: timezone,
          dense: true,
          // visualDensity: const VisualDensity(vertical: -2),
          title: Text(
            timezone,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.appBlack,
            ),
          ),
          groupValue: selectedTimeZone.value,
          onChanged: onChanged,
          contentPadding: EdgeInsets.zero,
          activeColor: AppColors.appBlack,
        );
      }),
    );
  }
}
