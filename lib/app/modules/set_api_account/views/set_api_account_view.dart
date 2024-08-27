// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';

// import '../../../../core/components/widgets/rio_app_bar.dart';
// import '../../../../core/components/widgets/app_text_field.dart';
// import '../../../../core/components/widgets/filled_round_button.dart';
// import '../../../../core/theme/colors.dart';

// import '../../../../gen/assets.gen.dart';
// import '../controllers/set_api_account_controller.dart';

// class SetApiAccountView extends GetView<SetApiAccountController> {
//   const SetApiAccountView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: AppColors.background,
//       appBar: const RioAppBar(
//         titleText: 'Set VPN Account',
//       ),
//       body: Obx(() {
//         return Stack(
//           children: [
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
//               child: Form(
//                 key: controller.apiAccountKey,
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 24),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Account',
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColors.black.withOpacity(0.5)),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 4.0),
//                             child: AppTextField(
//                               controller: controller.accountTEC,
//                               obscureText: false,
//                               hintText: 'Enter Username',
//                               keyboardType: TextInputType.emailAddress,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please Enter Username';
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Password',
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColors.black.withOpacity(0.5)),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 4.0),
//                             child: AppTextField(
//                               controller: controller.passwordTEC,
//                               obscureText: !controller.showPassword.value,
//                               hintText: 'Enter Password',
//                               suffixIcon: InkWell(
//                                 onTap: () {
//                                   controller.showPassword.value =
//                                       !controller.showPassword.value;
//                                 },
//                                 child: Icon(controller.showPassword.value
//                                     ? Icons.visibility_off_outlined
//                                     : Icons.remove_red_eye_outlined),
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please Enter Password';
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           FilledRoundButton(
//                             onPressed: () {
//                               if (controller.apiAccountKey.currentState!
//                                   .validate()) {
//                                 controller.setApiAccount(
//                                     controller.fillSetApiAccount());
//                               }
//                             },
//                             buttonText: 'Set Account',
//                             padding: const EdgeInsets.symmetric(vertical: 4),
//                           ),
//                           SizedBox(height: Get.height * 0.08),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             if (controller.showLoader.value)
//               Positioned(
//                 child: SizedBox(
//                   height: Get.height,
//                   width: Get.width,
//                   child: ColoredBox(
//                     color: Colors.black54,
//                     child: Lottie.asset(Assets.animations.loading),
//                   ),
//                 ),
//               ),
//           ],
//         );
//       }),
//     );
//   }
// }
