import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/activity_log_controller.dart';

class ActivityLogView extends GetView<ActivityLogController> {
  const ActivityLogView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const RioAppBar(
        titleText: 'Activity Log',
      ),
      body: Obx(() {
        return Stack(
          children: [
            if (controller.listOfActivityLog.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Scrollbar(
                  controller: controller.logScrollController,
                  child: ListView.builder(
                      itemCount: controller.listOfActivityLog.length,
                      controller: controller.logScrollController,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: ListTile(
                            title: SizedBox(
                              width: Get.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.listOfActivityLog[index]
                                      .formattedDateTime),
                                  Text(controller
                                      .listOfActivityLog[index].routerSRNo),
                                ],
                              ),
                            ),
                            subtitle: Text(
                                controller.listOfActivityLog[index].message),
                            tileColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                          ),
                        );
                      }),
                ),
              ),
            if (controller.getActivityLogModel.listOfActivityLog != null &&
                controller.getActivityLogModel.listOfActivityLog!.isEmpty)
              const Center(
                child: Text(
                  'There are no logs available',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.red),
                ),
              ),
            if (controller.showLoader.value)
              Positioned(
                child: SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: ColoredBox(
                    color: Colors.white12,
                    child: Lottie.asset(Assets.animations.loading),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
