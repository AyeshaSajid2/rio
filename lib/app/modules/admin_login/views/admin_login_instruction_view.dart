import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../gen/assets.gen.dart';

import '../controllers/admin_login_controller.dart';

class AdminLoginInstructionView extends GetView<AdminLoginController> {
  const AdminLoginInstructionView({super.key});
  @override
  Widget build(BuildContext context) {
    final pageHeight =
        (Get.height - Get.statusBarHeight + (Get.mediaQuery.padding.top / 2));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const RioAppBar(
        titleText: 'Admin Login',
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: pageHeight,
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        bottom: 24.0,
                        top: 42,
                      ),
                      child: Text(
                        'Bottom of the Rio Router',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Image.asset(
                      Assets.images.backSideRouter.path,
                    ),
                  ],
                ),
                SizedBox(
                  height: pageHeight * 0.03,
                ),
                const Text(
                  'In the label you will find Router Username and Password.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                Image.asset(
                  Assets.images.labelSteaker.path,
                ),
                const Spacer(),
                FilledRoundButton(
                  onPressed: () {
                    Get.back();
                  },
                  buttonText: 'Back to Login',
                  padding: const EdgeInsets.symmetric(vertical: 4),
                ),
                SizedBox(height: Get.height * 0.08),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
