import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:usama/core/theme/colors.dart';
import '../../../../core/components/widgets/rio_app_bar.dart';

import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/extensions/imports.dart';
import '../controllers/sign_up_controller.dart';

class TermsAndServiceView extends GetView<SignUpController> {
  const TermsAndServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle headingTS = TextStyle(
      fontWeight: FontWeight.w500,
      color: AppColors.black,
      fontSize: 14,
    );
    const TextStyle bodyTS = TextStyle(
      fontWeight: FontWeight.w400,
      color: AppColors.textGrey,
      fontSize: 12,
    );
    return Scaffold(
      appBar: const RioAppBar(
        titleText: 'Rio Router Terms of Service',
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        color: AppColors.background,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.grey),
                ),
                child: Scrollbar(
                  controller: controller.scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      controller: controller.scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(
                          //   height: Get.height,
                          //   width: Get.width,
                          //   child: Obx(() {
                          //     return controller.pageOpened.value
                          //         ? Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: WebViewWidget(
                          //                 controller:
                          //                     controller.webViewController),
                          //           )
                          //         : SizedBox(
                          //             height: Get.height,
                          //             width: Get.width,
                          //             child: ColoredBox(
                          //               color: Colors.white12,
                          //               child: Lottie.asset(
                          //                   Assets.animations.loading),
                          //             ),
                          //           );
                          //   }),
                          // ),
                          const Text(
                            'Effective Date: January 1st, 2023',
                            style: headingTS,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Welcome to Rio! These Terms of Service ("Terms") govern your use of Rio\'s products, services, and any associated software (collectively referred to as the "Service"). Please read these Terms carefully before accessing or using Rio. By accessing or using the Service, you agree to be bound by these Terms. If you do not agree with any part of these Terms, you may not use Rio.',
                            style: bodyTS,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            '1. Acceptance of Terms',
                            style: headingTS,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'By accessing or using the Service, you affirm that you are of legal age and have the authority to enter into this agreement. If you are using the Service on behalf of an organization, you agree to these Terms on behalf of that organization, and you represent that you have the authority to do so.',
                            style: bodyTS,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            '2. Use of the Service',
                            style: headingTS,
                          ),
                          const SizedBox(height: 12),
                          RichText(
                              text: const TextSpan(
                                  text: '2.1 License: ',
                                  style: headingTS,
                                  children: [
                                TextSpan(
                                  text:
                                      'Subject to these Terms, Rio grants you a limited, non-exclusive, non-transferable license to access and use the Service for your personal or organizational use.',
                                  style: bodyTS,
                                ),
                              ])),
                          const SizedBox(height: 12),
                          RichText(
                              text: const TextSpan(
                                  text: '2.2 Compliance: ',
                                  style: headingTS,
                                  children: [
                                TextSpan(
                                  text:
                                      'You agree to use the Service in compliance with all applicable laws, regulations, and these Terms. You are solely responsible for all activities conducted through your account.',
                                  style: bodyTS,
                                ),
                              ])),
                          const SizedBox(height: 12),
                          RichText(
                              text: const TextSpan(
                                  text: '2.3 Account Security: ',
                                  style: headingTS,
                                  children: [
                                TextSpan(
                                  text:
                                      'You are responsible for maintaining the confidentiality of your account credentials and for any activities or actions taken under your account. You must promptly notify Rio of any unauthorized use of your account or any other breach of security.',
                                  style: bodyTS,
                                ),
                              ])),
                          const SizedBox(height: 12),
                          const Text(
                            '3. Intellectual Property',
                            style: headingTS,
                          ),
                          const SizedBox(height: 12),
                          RichText(
                              text: const TextSpan(
                                  text: '3.1 Ownership: ',
                                  style: headingTS,
                                  children: [
                                TextSpan(
                                  text:
                                      'Rio retains all rights, title, and interest in and to the Service, including all intellectual property rights. These Terms do not grant you any right, title, or interest in or to the Service, except for the limited license rights expressly provided herein.',
                                  style: bodyTS,
                                ),
                              ])),
                          const SizedBox(height: 12),
                          RichText(
                              text: const TextSpan(
                                  text: '3.2 Restrictions: ',
                                  style: headingTS,
                                  children: [
                                TextSpan(
                                  text:
                                      'You may not copy, modify, distribute, sell, lease, or sublicense the Service or any part thereof unless expressly authorized by Rio in writing. You may not reverse engineer, decompile, or disassemble the Service or attempt to derive the source code from it.',
                                  style: bodyTS,
                                ),
                              ])),
                          const SizedBox(height: 12),
                          const Text(
                            '4. SMS Mobile Messaging',
                            style: headingTS,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'SMS mobile messages are used for sending the verification codes to the customers during the sign-up/Sign-in and forgot password processes to Rio Router Mobile App.',
                            style: bodyTS,
                          ),
                          const SizedBox(height: 12),

                          RichText(
                              text: const TextSpan(
                                  text:
                                      '4.1 User Opt-In for SMS Verification: ',
                                  style: headingTS,
                                  children: [
                                TextSpan(
                                  text:
                                      'The Program allows Users to opt-in to receive SMS mobile messages for verification codes. Regardless of the opt-in method you utilized to join the Program, you agree that this Agreement applies to your participation in the Program. By participating in the Program, you agree to receive mobile messages containing verification codes at the phone number associated with your opt-in. Message rates may apply.',
                                  style: bodyTS,
                                ),
                              ])),
                          const SizedBox(height: 12),
                          RichText(
                              text: TextSpan(
                                  text:
                                      '4.2 User Opt-Out for SMS Verification: ',
                                  style: headingTS,
                                  children: [
                                const TextSpan(
                                  text:
                                      'If you do not wish to continue receiving SMS mobile messages for verification codes or no longer agree to this Agreement, you can opt out of the Program by sending an email to ',
                                  style: bodyTS,
                                ),
                                TextSpan(
                                  text: 'support@riorouter.com',
                                  style: bodyTS.copyWith(color: AppColors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchURL(
                                        scheme: 'mailto',
                                        path: 'support@riorouter.com',
                                      );
                                    },
                                ),
                                const TextSpan(
                                  text:
                                      ' mentioning your Rio Router login email id and phone number.\nYou also understand and agree that any other method of opting out, including, but not limited to, texting words other than those set forth above or verbally requesting one of our employees to remove you from our list, is not a reasonable means of opting out.',
                                  style: bodyTS,
                                ),
                              ])),
                          const SizedBox(height: 12),
                          const Text(
                            '5. Privacy',
                            style: headingTS,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Rio respects your privacy and handles your personal information in accordance with its Privacy Policy. By using the Service, you consent to the collection, use, and disclosure of your personal information as described in the Privacy Policy.',
                            style: bodyTS,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            '6. Termination',
                            style: headingTS,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Rio reserves the right to suspend or terminate your access to the Service at any time, without notice or liability, for any reason, including if you violate these Terms or engage in any conduct that Rio, in its sole discretion, considers to be inappropriate, illegal, or harmful.',
                            style: bodyTS,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            '7. Limitation of Liability',
                            style: headingTS,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'To the maximum extent permitted by applicable law, Rio and its affiliates, directors, officers, employees, agents, suppliers, or licensors shall not be liable for any indirect, incidental, special, consequential, or exemplary damages, including but not limited to damages for loss of profits, goodwill, use, data, or other intangible losses, arising out of or in connection with the Service or these Terms.',
                            style: bodyTS,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            '8. Modifications to the Terms',
                            style: headingTS,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Rio reserves the right to modify or replace these Terms at any time. If a revision is material, Rio will provide notice, either through the Service or via email. Your continued use of the Service following the posting of any changes to these Terms constitutes acceptance of those changes.',
                            style: bodyTS,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            '9. Governing Law',
                            style: headingTS,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'These Terms shall be governed by and construed in accordance with the laws of [Insert applicable jurisdiction]. Any disputes arising out of or in connection with these Terms shall be subject to the exclusive jurisdiction of the courts located in [Insert applicable jurisdiction].',
                            style: bodyTS,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            '10. Entire Agreement',
                            style: headingTS,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'These Terms constitute the entire agreement between you and Rio regarding the Service and supersede all prior or contemporaneous agreements, understandings, or representations, whether oral or written, relating to the Service.',
                            style: bodyTS,
                          ),
                          const SizedBox(height: 12),

                          RichText(
                            text: TextSpan(
                              text:
                                  'If you have any questions or concerns about these Terms, please contact us at ',
                              style: bodyTS,
                              children: [
                                TextSpan(
                                  text: 'support@riorouter.com',
                                  style: bodyTS.copyWith(color: AppColors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchURL(
                                        scheme: 'mailto',
                                        path: 'support@riorouter.com',
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // const Spacer(),
            FilledRoundButton(
              onPressed: () {
                controller.isTermsAccepted.value = true;
                Get.back();
              },
              buttonText: 'I Agree - Take me to Sign Up',
            ),
            SizedBox(height: Get.height * 0.08),
          ],
        ),
      ),
    );
  }
}
