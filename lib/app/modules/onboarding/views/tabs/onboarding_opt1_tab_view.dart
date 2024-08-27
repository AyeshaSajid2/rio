import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../core/components/widgets/filled_round_button.dart';
import '../../../../../core/components/widgets/outlined_app_button.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/onboarding_controller.dart';

class OnboardingOption1TabView extends GetView<OnboardingController> {
  const OnboardingOption1TabView({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Scan the QR code',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  // textAlign: TextAlign.center,
                ),
                SizedBox(height: Get.height * 0.01),
                const Text(
                  'Scan the QR code located on the\n backside of the router as shown below.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Get.height * 0.08),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: Image.asset(
                      Assets.images.routerStep3Qr.path,
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.08),
                OutlinedAppButton.icon(
                  onPressed: () {
                    Get.toNamed(Routes.SCANNER);
                  },
                  buttonText: 'Open Camera',
                  svgPath: Assets.svgs.camera1,
                  buttonColor: AppColors.appBlack,
                ),
                FilledRoundButton(
                  onPressed: () {
                    // if (asKeyStorage.getAsKeyDeviceToken() == '') {
                    //   Get.to(() => const WaitingScreenView());
                    //   controller.startTimer(1);
                    // } else {
                    //   Get.toNamed(Routes.ADMIN_LOGIN);
                    // }
                    Get.offAndToNamed(Routes.ADMIN_LOGIN);
                  },
                  buttonText: 'Next',
                  buttonColor: AppColors.primary,
                ),
                SizedBox(height: Get.height * 0.08),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class OnboardingView3 extends GetView<OnboardingController> {
//   const OnboardingView3({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Row(
//           children: [
//             OnboardingTile(color: AppColors.primary),
//             OnboardingTile(color: AppColors.primary),
//             OnboardingTile(color: AppColors.primary),
//             OnboardingTile(color: AppColors.grey),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Text(
//               'Join Rio\'s Network',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
//             ),
            
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               // color: Colors.amber,
//               child: Column(
//                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       RichText(
//                         text: const TextSpan(
//                             text: 'Option 2: ',
//                             style: TextStyle(
//                                 color: AppColors.primary,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500),
//                             children: [
//                               TextSpan(
//                                 text: 'Connect Manually',
//                                 style: TextStyle(
//                                     color: AppColors.black,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ]),
//                       ),
//                       const Text(
//                         '1. Open the settings of mobile.\n2. Select "Wi-Fi" from the settings menu.\n3. Locate and tap on the "Rio Router" in the list of available networks.\n4. Select Rio Router SSID that is mentioned on the label on the bottom of the router shown below. \n5. When promotes enter the Wireless password that is mentioned on the label on the bottom of the router shown below.',
//                         style: TextStyle(
//                             fontSize: 12, fontWeight: FontWeight.w300),
//                         // textAlign: TextAlign.center,
//                       ),
//                       Center(
//                         // child: SvgPicture.asset(Assets.svgs.routerSetup3),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Image.asset(
//                             Assets.images.routerStep3Manual.path,
//                             // height: Get.height * 0.11,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       OutlinedAppButton.icon(
//                         onPressed: () {
//                           if (Platform.isAndroid) {
//                             const OpenSettingsPlusAndroid().wifi();
//                           } else if (Platform.isIOS) {
//                             const OpenSettingsPlusIOS().wifi();
//                           }
//                         },
//                         buttonText: 'Open Wifi Settings',
//                         svgPath: Assets.svgs.wifiSignals,
//                         buttonColor: AppColors.appBlack,
//                       ),
//                       OutlinedAppButton.icon(
//                         onPressed: () {
//                           Get.toNamed(Routes.SCANNER);
//                         },
//                         buttonText: 'Open Camera',
//                         svgPath: Assets.svgs.camera,
//                         buttonColor: AppColors.appBlack,
//                       ),
//                       FilledRoundButton(
//                         onPressed: () {
//                           Get.toNamed(Routes.ADMIN_LOGIN);
//                         },
//                         buttonText: 'Next',
//                         // svgPath: Assets.svgs.connect,
//                         buttonColor: AppColors.primary,
//                       ),
//                       SizedBox(height: Get.height * 0.08),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
