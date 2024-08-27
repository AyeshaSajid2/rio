import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/customer_support_controller.dart';

class CustomerSupportView extends GetView<CustomerSupportController> {
  const CustomerSupportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      appBar: const RioAppBar(
        titleText: 'Customer Support',
      ),
      body: Obx(() {
        return controller.pageOpened.value
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                          height: Get.height * 0.8,
                          width: Get.width,
                          color: AppColors.white,
                          child: WebViewWidget(
                              controller: controller.webViewController)),
                    ],
                  ),
                ),
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
