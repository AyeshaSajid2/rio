import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:usama/core/theme/colors.dart';
import 'package:usama/gen/assets.gen.dart';

import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/components/widgets/rio_app_bar.dart';
import '../controllers/back_up_controller.dart';

class BackUpView extends GetView<BackUpController> {
  const BackUpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      appBar: const RioAppBar(
        titleText: 'Backup Configuration',
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: Get.width,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      Assets.svgs.newDownload,
                      height: 24,
                      width: 24,
                    ),
                    const Text(
                      'DOWNLOAD',
                      style: TextStyle(fontSize: 20),
                    ),
                    FilledRoundButton(
                      onPressed: () {
                        // controller.downloadFile();
                      },
                      buttonText: 'Download File',
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 100),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Expanded(child: Divider(thickness: 1)),
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.white),
                    child: const Text('OR'),
                  ),
                  const Expanded(child: Divider(thickness: 1)),
                ],
              ),
              Container(
                width: Get.width,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      Assets.svgs.newUpload,
                      height: 24,
                      width: 24,
                    ),
                    const Text(
                      'UPLOAD',
                      style: TextStyle(fontSize: 20),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Click the below button to upload configuration file',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                    ),
                    FilledRoundButton(
                      onPressed: () {},
                      buttonColor: AppColors.blue,
                      buttonText: 'Upload File',
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 100),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
