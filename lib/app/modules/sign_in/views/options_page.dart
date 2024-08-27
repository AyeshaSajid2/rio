import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';

import '../controllers/sign_in_controller.dart';

class OptionsView extends GetView<SignInController> {
  const OptionsView({super.key});
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 42.0,
              top: 24,
            ),
            child: SvgPicture.asset(
              Assets.svgs.logo,
              width: Get.width * 0.15,
              height: Get.width * 0.15,
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Welcome',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          OptionWidget(
            textTheme: textTheme,
            title: 'Option 1: ',
            body: 'Begin the setup process for your router configuration.',
            buttonText: 'Router Setup',
            onPressed: () {
              //
              Get.toNamed(Routes.ONBOARDING);
            },
          ),
          const SizedBox(height: 24),
          OptionWidget(
            textTheme: textTheme,
            title: 'Option 2:',
            body: 'Access the admin login screen to manage your Rio Network.',
            buttonText: 'Go to Admin Login',
            onPressed: () {
              Get.toNamed(Routes.ADMIN_LOGIN);
            },
          ),
          const Spacer()
        ],
      ),
    );
  }
}

class OptionWidget extends StatelessWidget {
  const OptionWidget({
    super.key,
    required this.textTheme,
    required this.title,
    required this.body,
    required this.onPressed,
    required this.buttonText,
  });

  final TextTheme textTheme;
  final String title;
  final String body;
  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        color: AppColors.greyBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          ),
          FilledRoundButton(
              padding: const EdgeInsets.symmetric(vertical: 8),
              onPressed: onPressed,
              buttonText: buttonText),
        ],
      ),
    );
  }
}
