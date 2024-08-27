import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/speed_test_controller.dart';

class SpeedTestView extends GetView<SpeedTestController> {
  const SpeedTestView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: const RioAppBar(
          titleText: 'Connection Speed',
        ),
        body: controller.isStarted.value
            ? SizedBox(
                height: Get.height,
                child: Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.05),
                  child: Center(
                    child: Column(
                      children: [
                        SvgPicture.asset(Assets.svgs.speedtest),
                        Container(
                          width: (Get.width - 40),
                          height: Get.height * 0.1,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                Assets.svgs.download,
                              ),
                              const SizedBox(width: 16),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'DOWNLOAD',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            AppColors.black.withOpacity(0.5)),
                                  ),
                                  Row(
                                    children: [
                                      Obx(() {
                                        return Text(
                                          (controller.downloadSpeed.value /
                                                  1000)
                                              .toStringAsFixed(2),
                                          style: TextStyle(
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        );
                                      }),
                                      Text(
                                        ' Mbps',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: (Get.width - 40),
                          height: Get.height * 0.1,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                Assets.svgs.uploadSpeed,
                              ),
                              const SizedBox(width: 16),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'UPLOAD',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            AppColors.black.withOpacity(0.5)),
                                  ),
                                  Row(
                                    children: [
                                      Obx(() {
                                        return Text(
                                          (controller.uploadSpeed.value / 1000)
                                              .toStringAsFixed(2),
                                          style: TextStyle(
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        );
                                      }),
                                      Text(
                                        ' Mbps',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Obx(() => DropdownButton<String>(
                              //       value: controller.selectedServer.value,
                              //       onChanged: (String? newValue) {
                              //         controller.selectedServer.value =
                              //             newValue!;
                              //       },
                              //       items:
                              //           controller.servers.map((String server) {
                              //         return DropdownMenuItem<String>(
                              //           value: server,
                              //           child: Text(server),
                              //         );
                              //       }).toList(),
                              //     )),
                              // const SizedBox(height: 20),
                              // Obx(() => Text(
                              //     'Selected Server: ${controller.selectedServer.value}')),
                              // const SizedBox(height: 20),
                              // Obx(() => Text(
                              //     'Download Speed: ${controller.downloadSpeed.value.toStringAsFixed(2)} bytes/s')),
                              // const SizedBox(height: 20),
                              // Obx(() => Text(
                              //     'Upload Speed: ${controller.uploadSpeed.value.toStringAsFixed(2)} bytes/s')),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: controller.runSpeedTest,
                                child: const Text(
                                  'Run Speed Test',
                                  style: TextStyle(color: AppColors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : SizedBox(
                height: Get.height / 1.5,
                child: Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.05),
                  child: Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () {
                          controller.isStarted.value = true;
                        },
                        child: SvgPicture.asset(
                          Assets.svgs.startButton,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      );
    });
  }
}
