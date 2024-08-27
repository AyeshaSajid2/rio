import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/theme/colors.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return controller.listOfBottomNavWidgets
            .elementAt(controller.currentIndex.value);
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.CUSTOMER_SUPPORT);
        },
        child: const Icon(Icons.support_agent, color: AppColors.white),
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.black,
            // fixedColor: AppColors.white,
            selectedItemColor: AppColors.white,
            selectedIconTheme: const IconThemeData(color: AppColors.white),
            unselectedItemColor: AppColors.navUnselected,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(color: AppColors.white),
            unselectedLabelStyle:
                const TextStyle(color: AppColors.navUnselected),
            currentIndex: controller.currentIndex.value,
            onTap: (value) {
              controller.currentIndex.value = value;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.important_devices_outlined),
                label: 'Admin',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.manage_accounts_outlined),
                label: 'Managed',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.vpn_lock),
                label: 'VPN',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'System',
              ),
            ]);
      }),
    );
  }
}
