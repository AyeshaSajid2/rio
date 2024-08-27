import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/sign_up_controller.dart';

class AccountCreatedView extends GetView<SignUpController> {
  const AccountCreatedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Get.height * 0.1),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 24.0,
                    top: 24,
                  ),
                  child: SvgPicture.asset(
                    Assets.svgs.logo,
                    width: Get.width * 0.15,
                    height: Get.width * 0.15,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Now Lets Setup your Rio Router Configuration',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'You now have your own Personal Rio Account. Before you begin the physical setup of your Rio Router, we require some information from you. This information can be found on the sticker located at the bottom of your router. Please enter this information when prompted during the setup process.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'Continue with your Router Setup',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            FilledRoundButton(
                onPressed: () {
                  Get.toNamed(Routes.ONBOARDING);
                },
                buttonText: 'Next'),
            SizedBox(height: Get.height * 0.08),
          ],
        ),
      ),
    );
  }
}
