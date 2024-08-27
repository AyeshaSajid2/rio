import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/extensions/imports.dart';
import '../../../../core/theme/colors.dart';
import '../../../routes/app_pages.dart';
import '../controllers/onboarding_controller.dart';
import 'tabs/onboarding_opt1_tab_view.dart';
import 'tabs/onboarding_opt3_tab_view.dart';

class OnboardingTabsView extends GetView<OnboardingController> {
  const OnboardingTabsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Rio WiFi Network'),
      ),
      floatingActionButton: constants.isKeyboardOpened()
          ? null
          : FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Get.toNamed(Routes.CUSTOMER_SUPPORT);
              },
              child: const Icon(Icons.support_agent, color: AppColors.white),
            ),
      body: Center(
        child: DefaultTabController(
          length: controller.tabsList.length,
          child: SizedBox(
            width: Get.width,
            child: Column(
              children: [
                Container(
                  height: 48,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TabBar(
                    controller: controller.onboardingTabController,
                    labelColor: AppColors.white,
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    isScrollable: true,
                    padding: const EdgeInsets.all(2),
                    indicatorWeight: 0,
                    splashBorderRadius: BorderRadius.circular(7),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 1,
                            color: Color.fromRGBO(0, 0, 0, 0.04)),
                        BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 8,
                            color: Color.fromRGBO(0, 0, 0, 0.12)),
                      ],
                      color: AppColors.red,
                    ),
                    tabs: [
                      for (int i = 0; i < controller.tabsList.length; i++)
                        Tab(text: controller.tabsList[i]),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                      controller: controller.onboardingTabController,
                      children: const [
                        OnboardingOption1TabView(),
                        // OnboardingOption2TabView(),
                        OnboardingOption3TabView(),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
