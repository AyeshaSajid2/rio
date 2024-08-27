import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/widgets/filled_rect_button.dart';
import '../../theme/colors.dart';

class AppDialog {
  // HomeController homeController = Get.find<HomeController>();

  // StudentAddStudentController studentController = StudentAddStudentController();

  showImageDialog() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(8),
      title: "Select Your Image",
      backgroundColor: AppColors.white,
      titleStyle: const TextStyle(color: Colors.black),
      cancelTextColor: Colors.red,
      confirmTextColor: Colors.black,
      buttonColor: Colors.red,
      barrierDismissible: true,
      radius: 8,
      content: SizedBox(
        width: double.maxFinite,
        height: 80,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledRectButton(
                        onPressed: () {
                          // studentController.selectImage(ImageSource.camera);
                        },
                        buttonText: 'Camera',
                        buttonColor: AppColors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledRectButton(
                        onPressed: () {
                          // studentController.selectImage(ImageSource.gallery);
                          // HomeController().pickImageFromGallery();
                        },
                        buttonText: 'Gallery',
                        buttonColor: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
