import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/speed_test_controller.dart';

class SpeedTestWebView extends GetView<SpeedTestController> {
  const SpeedTestWebView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const RioAppBar(
        titleText: 'Connection Speed',
      ),
      body: Obx(() {
        return controller.pageOpened.value
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: WebViewWidget(controller: controller.webViewController),
              )
            : SizedBox(
                height: Get.height,
                width: Get.width,
                child: ColoredBox(
                  color: Colors.white12,
                  child: Lottie.asset(Assets.animations.loading),
                ),
              );
      }),
    );
  }
}
